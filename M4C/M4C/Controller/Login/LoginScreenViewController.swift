//
//  LoginScreenViewController.swift
//  M4C
//
//  Created by Hitesh Thummar on 11/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import AFNetworking

class LoginScreenViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var viewDetail: UIView!
    
    let commanUntil = CommanUntil()
    
    var hud = MBProgressHUD()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtEmail.text = "vitar@xyz.com"
        txtPassword.text = "1231211"
        
        setScreenLayOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setScreenLayOut()  {
        
        commanUntil.ViewCornerRadiou(view: viewDetail)
        commanUntil.ButtonCornerRedious(button: btnSignIn)
        commanUntil.UserEmailTextField(textField: txtEmail)
        commanUntil.PassowrdTextField(textField: txtPassword)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: Validation
    
    func validation() -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        
        if txtEmail.text == "" {
            commanUntil .displayOkMsg(msg: "Email is required!", title: "Oops!")
            return false
        }else if !emailTest.evaluate(with: txtEmail.text){
            commanUntil .displayOkMsg(msg: "Enter valid email address!", title: "Oops!")
            return false
        }else if txtPassword.text == ""{
            commanUntil .displayOkMsg(msg: "Password is required!", title: "Oops!")
            return false
        }
        
        return true
        
    }
    
    @IBAction func btnSignIN(_ sender: Any) {
        
        if !validation() {
            return
        }
        
        
        hud = MBProgressHUD .showAdded(to: self.view, animated: true)
        
        
        let param = ["email":txtEmail.text,"password":txtPassword.text];
        

        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.securityPolicy.allowInvalidCertificates = true
        manager.securityPolicy.validatesDomainName  = false
//        manager.requestSerializer = AFJSONRequestSerializer()
        manager.post(LOGIN, parameters: param, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if let jsonResponse = responseObject as? NSDictionary {
                // here read response
                self.hud .hide(animated: true)
                
                
                if jsonResponse.value(forKeyPath: "data.success") as! Bool {
                    pGlobal.setAuthorized()
                    self.performSegue(withIdentifier: "Home", sender: self)
                }
                else{
                    let alert = UIAlertView(title: "Oops!", message: jsonResponse.value(forKeyPath: "errorMsg")! as? String, delegate:nil, cancelButtonTitle: "Ok")
                    alert.show()
                    
                }
//                self.performSegue(withIdentifier: "Home", sender: self)

            }
            
            
            
        }) { (task: URLSessionDataTask?, error: Error) in
            self.hud .hide(animated: true)
            print("POST fails with error \(error)")
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController? .popViewController(animated: true)
    }
}
