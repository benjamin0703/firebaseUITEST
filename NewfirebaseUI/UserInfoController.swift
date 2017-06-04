import UIKit
import Firebase
import FirebaseDatabaseUI
import FirebaseStorageUI

class UserInfoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var EditImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    var user = FIRAuth.auth()?.currentUser
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    //Database
    var userReference:FIRDatabaseReference?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        scrollview.contentSize.width = 320
        scrollview.contentSize.height = 700
        //綁定按鈕的事件
        SendButton.addTarget(self, action: #selector(UserInfoController.didTapSend), for: .touchUpInside)
       // EditButton.addTarget(self, action: #selector(UserInfoController.pickImage), for: .touchUpInside)
        
        
        // 新增手勢 按圖片時
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        EditImageView.isUserInteractionEnabled = true
        EditImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    //按鈕上傳事件
    func didTapSend(_ sender: AnyObject)
    {
        guard user != nil else { return } //if user is null then return
        let uid = user!.uid
        let userEmail = user!.email!
        guard let name = self.txtName.text as String?else { return } //是有值的
        if(name.isEmpty) { return }
        
        let _company = self.txtCompanyName.text as String?
        guard let company = _company else { return }
        if(company.isEmpty) { return }
        guard let description = self.txtDescription.text as String? else{ return }
        
        userReference = FIRDatabase.database().reference().child("USER").child(userEmail.replacingOccurrences(of: ".", with: "_"))
        
        //var aaa = user!.email!.replacingOccurrences(of: ".", with: "_")
        UploadData(UserName: name, UserCompany: company, Email: userEmail, Description: description)
       
    }
    
    //選圖片事件
    func pickImage()
    {
        // 建立一個 UIImagePickerController 的實體
        let imagePickerController = UIImagePickerController()
        
        // 委任代理
        imagePickerController.delegate = self
        
        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default)
        { (Void) in
            
            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        { (Void) in
            
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(cancelAction)
        present(imagePickerAlertController, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.imageView.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //當用戶取消選圖片
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    

    //上傳資料到Firebase
    func UploadData(UserName:String, UserCompany:String,Email:String, Description:String)
    {
        let GetKey:String = (self.userReference?.childByAutoId().key)!
        
        let storageRef = FIRStorage.storage().reference().child("devicePhoto").child("\(GetKey).png")
        //將selectedImg用UIImagePNGRepresentation轉換成Data形式
        if let uploadData = UIImagePNGRepresentation(self.imageView.image!)
        {
            // 這行就是 FirebaseStorage 關鍵的存取方法。
            storageRef.put(uploadData, metadata: nil, completion:
            { (data, error) in
                if error != nil
                {
                    // 若有接收到錯誤，我們就直接印在 Console 就好，在這邊就不另外做處理。
                    print("Error: \(error!.localizedDescription)")
                    return
                }
                let CurrentUser = User(username: UserName, company: UserCompany, memberEmail: Email, deviceId: GetKey, description: Description)
                
                self.userReference!.child(GetKey).setValue(CurrentUser.dictionary, withCompletionBlock:
                    { (error, dbref) in
                        if let error = error
                        {
                            print("\(error.localizedDescription)")
                        }
                        else
                        {
                            let Succeed = MsgBox()
                            self.present(Succeed.PopDefault(Title: "訊息", Content: "上傳成功!!"), animated: true, completion: nil)
                        }
                     })
                
            })
        }
    }
}
