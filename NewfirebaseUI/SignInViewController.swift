import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI

class SignInViewController: UIViewController
{

    @IBAction func SignIn(_ sender: UIButton)
    {
            //if let語法 如果authUI不為nil時 才會執行大括號內
            if let authUI = FUIAuth.defaultAuthUI()
            {
                //獲取Google登入UI
                let googleAuthUI = FUIGoogleAuth.init()
                //獲取FB登入UI
                let FBAuthUI = FUIFacebookAuth.init()
                
                //用於實現登入UI
                authUI.providers = [googleAuthUI,FBAuthUI]
                
                let authViewController = authUI.authViewController()
                self.present(authViewController, animated: true, completion: nil)
                
            }
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        print("viewDidLoad")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
        if (FIRAuth.auth()?.currentUser) != nil
        {
            self.present((self.storyboard?.instantiateViewController(withIdentifier: "Entrance"))!, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
