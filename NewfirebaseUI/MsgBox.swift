//
//  MsgBox.swift
//  NewfirebaseUI
//
//  Created by ＳＣＳＡ on 2017/5/18.
//  Copyright © 2017年 ＳＣＳＡ. All rights reserved.
//

import Foundation
import UIKit

class MsgBox: UIAlertController
{
    
    //
    func PopDefault(Title:String,Content:String)->UIAlertController
    {
        let MsgController = UIAlertController(title: Title, message: Content, preferredStyle: .alert)
        
        MsgController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return MsgController
    }
    
}
