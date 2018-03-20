//
//  SideMenuViewController.swift
//  M4C
//
//  Created by Viraj Padsala on 20/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit
import SWRevealViewController

class SideMenuViewController: UIViewController {
    
    
    var arrMenuList = NSMutableArray()
    var from : String! = ""
    
    @IBOutlet var viewNotLogin: UIView!
    @IBOutlet var viewLogin: UIView!
    
    @IBOutlet var tblMenuList: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "SideMenu", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        arrMenuList = dict? .value(forKey: "Items") as! NSMutableArray

        // Do any additional setup after loading the view.
        
        if pGlobal.isAuthorized(){
            viewNotLogin .isHidden = true
            viewLogin .isHidden = false
        }else{
            viewNotLogin .isHidden = false
            viewLogin .isHidden = true

        }
        
        tblMenuList .reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "home" {
            let vcHome = segue.destination as! HomeScreenViewController
            vcHome.strBrowse = from
        }
    }
    

}


extension SideMenuViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pGlobal.isAuthorized(){
            return arrMenuList.count
        }else{
            return arrMenuList.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MenuListTableViewCell
        let dict = arrMenuList[indexPath.row] as! NSMutableDictionary
        
        cell?.lblMenuname.text = dict .object(forKey: "Name") as? String
        cell?.imgMenu.image = UIImage (named: dict .object(forKey: "Image") as! String)
        
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:MenuListTableViewCell = tableView.cellForRow(at: indexPath)! as! MenuListTableViewCell
        selectedCell.contentView.backgroundColor = UIColor.red
        
        
        self.revealViewController() .revealToggle(animated: true)
        
        switch indexPath.row {
        case 0:
            self.from = ""
            self.performSegue(withIdentifier: "home", sender: self)
            break
        case 1:
            self.from = "Browse"
            self.performSegue(withIdentifier: "home", sender: self)
            break
        case 2:
            break
        default:
            break
        }
        
        
    }

    
}
