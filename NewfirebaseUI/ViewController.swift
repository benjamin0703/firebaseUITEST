import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI

class ViewController: UIViewController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.addStateDidChangeListener(
        { (auth, user) in
            if user != nil
            {
                    
            }
            else
            {
                self.signIn()
            }
        })
    }
    
    @IBAction func signIn()
    {
        //if let語法 如果authUI不為nil時 才會執行大括號內
        if let authUI:FUIAuth = FUIAuth.defaultAuthUI()
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   }

