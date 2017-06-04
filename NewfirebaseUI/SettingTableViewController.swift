//
//  SettingTableViewController.swift
//  NewfirebaseUI
//
//  Created by ＳＣＳＡ on 2017/5/23.
//  Copyright © 2017年 ＳＣＳＡ. All rights reserved.
//

import UIKit
import Firebase

class SettingTableViewController: UITableViewController
{
    let TitleAry = ["新增設備"]
    let LogOutAry = ["登出"]
    
    @IBAction func LogOut(_ sender: Any)
    {
        if csGolbal.g_User != nil
        {
            try! FIRAuth.auth()!.signOut()
            csGolbal.g_User = nil
        }
    }
    
   // let FruitArray = ["Apple","Mango","Banana"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //設置距離最上方有30
        //self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0
        {
            return TitleAry.count
        }
        else
        {
            return LogOutAry.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if(indexPath.section==0)
        {
            cell.textLabel?.text = TitleAry[indexPath.row]
        }
        else
        {
            //cell.textLabel?.text = FruitArray[indexPath.row]
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if(section == 0)
        {
            return " "
        }
        else
        {
            return " "
        }
    }

    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("select section: \(indexPath.section)")
        print("select row: \(indexPath.row)")
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let myWebView = self.storyboard!.instantiateViewController(withIdentifier: "User Information")
                self.navigationController?.pushViewController(myWebView, animated: true)
            }
        }
                
        
        //取消選取的狀態
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
