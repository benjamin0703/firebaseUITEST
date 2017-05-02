//
//  MainlayoutUI.swift
//  NewfirebaseUI
//
//  Created by ＳＣＳＡ on 2017/4/28.
//  Copyright © 2017年 ＳＣＳＡ. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

class MainlayoutUI: UIViewController {

    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    let chatReference = FIRDatabase.database().reference().child("swift_demo-chat")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
