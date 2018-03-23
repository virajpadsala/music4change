//
//  HomeScreenViewController.swift
//  M4C
//
//  Created by Hitesh Thummar on 11/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit
import SWRevealViewController
import MBProgressHUD
import AFNetworking

class HomeScreenViewController: UIViewController, UITextFieldDelegate, SWRevealViewControllerDelegate {

    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var homefeedtableview: UITableView!
    @IBOutlet weak var txtSearchMusic: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    var isSearched : Bool! = false
    var strBrowse = String()
    var URLHOME = String()

    var dictMusicDetail = NSDictionary()
    
    var hud = MBProgressHUD()
    var arrHomeScreenList = NSMutableArray()
    var FirstTableArray = [String]()
    
    
    var homedata:[NSDictionary] = []
    var homesearchdata:[NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        leftSilder()
        getHomeScreenData()
        self.txtSearchMusic.isHidden = true
        isSearched = false
    }
    
    func leftSilder() {
        
        
        if self.revealViewController() != nil {
            
            self.revealViewController().delegate = self
            self.revealViewController() .panGestureRecognizer().isEnabled = true
            btnMenu.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)) , for:.touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func getHomeScreenData()  {

        hud = MBProgressHUD .showAdded(to: self.view, animated: true)
        
        if strBrowse == "Browse" {
            URLHOME = BROWSE
        }else{
            URLHOME = HOME
        }


        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.securityPolicy.allowInvalidCertificates = true
        manager.securityPolicy.validatesDomainName  = false
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.get(HOME, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if let jsonResponse = responseObject as? NSDictionary {
                // here read response
                self.hud .hide(animated: true)
                
                
                if jsonResponse.value(forKey: "errorMsg") as! String == "" {
                    
                    if let arr = jsonResponse.value(forKey: "data") as? [NSDictionary]
                    {
                        self.homedata = arr;
                    }
                    print(self.homedata)
                    
                    self.homefeedtableview.reloadData()
                    
                }
                else{
                    let alert = UIAlertView(title: "Oops!", message: jsonResponse.value(forKeyPath: "errorMsg")! as? String, delegate:nil, cancelButtonTitle: "Ok")
                    alert.show()
                    
                }
            }
            
            
            
        }) { (task: URLSessionDataTask?, error: Error) in
            self.hud .hide(animated: true)
            print("POST fails with error \(error)")
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.txtSearchChanged(textField)
        return true
    }
    
    @IBAction func txtSearchChanged(_ sender: Any) {
        
        var URLSearch = String()
        URLSearch = SEARCH + "=\(txtSearchMusic.text!)"
        let urlString = URLSearch.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        hud = MBProgressHUD .showAdded(to: self.view, animated: true)

        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.securityPolicy.allowInvalidCertificates = true
        manager.securityPolicy.validatesDomainName  = false
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.get(urlString!, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if let jsonResponse = responseObject as? NSDictionary {
                // here read response
                self.hud .hide(animated: true)
                
                
                if jsonResponse.value(forKey: "errorMsg") as! String == "" {
                    
                    if let arr = jsonResponse.value(forKey: "data") as? [NSDictionary]
                        
                    {
                        self.homesearchdata = arr;
                    }
                    print(self.homesearchdata)
                    self.homefeedtableview.reloadData()
                }
                else{
                    let alert = UIAlertView(title: "Oops!", message: jsonResponse.value(forKeyPath: "errorMsg")! as? String, delegate:nil, cancelButtonTitle: "Ok")
                    alert.show()
                    
                }
            }
            
            
            
        }) { (task: URLSessionDataTask?, error: Error) in
            self.hud .hide(animated: true)
            print("POST fails with error \(error)")
        }

    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        if isSearched{
            isSearched = false
            self.txtSearchMusic.isHidden = true
            self.txtSearchMusic.text = ""
            self.txtSearchMusic.resignFirstResponder()
            self.btnSearch.setImage(UIImage.init(named: "ic_search"), for: .normal)
        }
        else{
            isSearched = true
            self.txtSearchMusic.isHidden = false
            self.txtSearchMusic.text = ""
            self.txtSearchMusic.becomeFirstResponder()
            self.btnSearch.setImage(UIImage.init(named: "close_white"), for: .normal)
            self.homesearchdata = self.homedata
        }
        self.homefeedtableview.reloadData()
    }
        
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if (self.revealViewController().frontViewPosition != FrontViewPosition.left) {
            btnMenu.setImage(UIImage.init(named: "ic_menu"), for: .normal)
        }
        else{
            btnMenu.setImage(UIImage.init(named: "close_white"), for: .normal)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Search" {
            let vcSearch = segue.destination as! SearchScreenViewController
            vcSearch.data = FirstTableArray
        }else if segue.identifier == "Music" {
            let vcDetail = segue.destination as! PlayMusicScreenViewController
            vcDetail.dictMusicDetail = dictMusicDetail
        }
        
    }
    

}

extension HomeScreenViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearched{
            if self.homesearchdata.isEmpty {
                let noItemLabel = UILabel() //no need to set frame.
                noItemLabel.textAlignment = .center
                noItemLabel.textColor = .white
                noItemLabel.numberOfLines = 0
                noItemLabel.text = NSLocalizedString("No Results Available", comment: "No data Found")
                tableView.backgroundView = noItemLabel
                tableView.separatorStyle = .none
            }
            else{
                tableView.separatorStyle = .singleLine
            }
            tableView.backgroundView?.isHidden = !self.homesearchdata.isEmpty
            return self.homesearchdata.count;
        }
        if self.homedata.isEmpty {
            let noItemLabel = UILabel() //no need to set frame.
            noItemLabel.textAlignment = .center
            noItemLabel.textColor = .white
            noItemLabel.numberOfLines = 0
            noItemLabel.text = NSLocalizedString("", comment: "No data Found")
            tableView.backgroundView = noItemLabel
            tableView.separatorStyle = .none
        }
        else{
            tableView.separatorStyle = .singleLine
        }
        tableView.backgroundView?.isHidden = !self.homedata.isEmpty
        return self.homedata.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeCell
        
        var dict = NSDictionary()
        if self.isSearched{
            dict = homesearchdata[indexPath.row]
        }
        else{
            dict = homedata[indexPath.row]
        }
        
        if let url  = dict.value(forKey: "image_url") as? String
        {
            loadImageWithURL(url: url, view: (cell?.backgroundimage)!)
            loadImageWithURL(url: url, view: (cell?.frontimage)!)
        }
        
        if let title  = dict.value(forKey: "title") as? String
        {
            cell?.headinglbl.text = title;
            FirstTableArray .append(title)
        }
        
        
        if dict.value(forKey: "target") != nil ,dict.value(forKey: "tip") != nil
        {
            let str = "$\(setcurrencyWithoutSymbol(price: "\(dict.value(forKey: "tip")!)")) in Tips"
            let attributedString = NSMutableAttributedString(string:str)
            let range = (str as NSString).range(of: "$\(setcurrencyWithoutSymbol(price: "\(dict.value(forKey: "tip")!)"))")
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.hexa("3ba250", alpha: 1.0), range: range)
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "HelveticaNeue-Bold", size: 23)!, range: range)
            
            cell?.amtlbl.attributedText = attributedString;
            
        }
        
        if dict.value(forKey: "charity_name") != nil && dict.value(forKey: "charity_name") as! String != ""
        {
            let str = "$\(setcurrencyWithoutSymbol(price: "\(dict.value(forKey: "tip")!)")) PLEDGE TO \(dict.value(forKey: "charity_name")!)."
            let attributedString = NSMutableAttributedString(string:str)
            let range = (str as NSString).range(of: "$\(setcurrencyWithoutSymbol(price: "\(dict.value(forKey: "tip")!)"))")
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.hexa("ef3644", alpha: 1.0), range: range)
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "HelveticaNeue-Bold", size: 13)!, range: range)

            cell?.desclbl.attributedText = attributedString;
            
        }
        else{
            let attributedString = NSMutableAttributedString(string:"")
            cell?.desclbl.attributedText = attributedString;
        }
        
        setBorderToView(view: (cell?.frontimage)!, color: UIColor.white, width: 1);
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.width * 17/16;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSearched{
            dictMusicDetail = homesearchdata[indexPath.row]
        }
        else{
            dictMusicDetail = homedata[indexPath.row]
        }
        self .performSegue(withIdentifier: "Music", sender: self);
    }
    
}





class HomeCell: UITableViewCell {
    
    @IBOutlet weak var backgroundimage: UIImageView!
    @IBOutlet weak var frontimage: UIImageView!
    @IBOutlet weak var headinglbl: UILabel!
    @IBOutlet weak var amtlbl: UILabel!
    @IBOutlet weak var desclbl: UILabel!
    
}
