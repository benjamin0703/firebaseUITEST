import UIKit
import Firebase
//import FirebaseAuthUI
//import FirebaseGoogleAuthUI
//import FirebaseFacebookAuthUI

let device = FIRDatabase.database().reference()

class MainTableViewController: UITableViewController
{
    
    var aDictLocal : [String : String]!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //獲取當前登陸用戶
        FIRAuth.auth()?.addStateDidChangeListener(self.UserAlive(auth:user:))
        print("主畫面viewDidLoad")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("主畫面ViewDidAppear")
        
        if FIRAuth.auth()?.currentUser != nil
       {
            getDataFromDB()
       }
    }
    
    func UserAlive(auth: FIRAuth, user: FIRUser?)
    {
        if user == nil
        {
            
            self.present((self.storyboard?.instantiateViewController(withIdentifier: "SignIn"))!, animated: true, completion: nil)
        }
        else
        {
            csGolbal.g_User = user
        }
        
    }
    func getDataFromDB()
    {
        DispatchQueue.main.async( execute: {
            
            //let dbstrPath : String! = "Firebase Db path"
            let ref = device.child("USER").child(csGolbal.g_User!.email!.replacingOccurrences(of: ".", with: "_"))
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if !snapshot.exists()
                {
                    print("snapshot not exists")
                }
                else
                {
                    csGolbal.g_key.removeAll()
                   
                    for item in snapshot.children
                    {
                        let number = item as! FIRDataSnapshot
                        self.aDictLocal = number.value! as! [String : String]
                       // self.aDictLocal.updateValue(number.key, forKey: "key") //新增值。 forkey為鑰匙名稱
                        csGolbal.g_key.append(self.aDictLocal)
                        
                        print("value \(number.value!) And Key \(number.key)")
                    }
                }
                 self.tableView.reloadData()
            })
        })
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        
       if csGolbal.g_key.count > 0
       {
        return csGolbal.g_key.count
        }
        else
       {
        return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        cell.DeviceName.text = csGolbal.g_key[indexPath.row]["username"]
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //取消選取的狀態
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
