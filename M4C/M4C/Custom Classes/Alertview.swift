//
//  Alertview.swift
//  VRS
//
//  Created by Viraj Padsala on 11/23/17.
//  Copyright © 2017 Viraj Padsala. All rights reserved.
//
import UIKit
import Foundation
func alertview(title: String ,message : String ,  _ viewContriller : UIViewController, buttonName : String)
{
    DispatchQueue.main.async {
        
        let alert = UIAlertController(title: title , message: message , preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: buttonName, style: .default) { action in
            if UIApplication.topViewController() != nil{
               // stopSpinner()
                
               /* if value is HomeViewController
                {
                    let homeVC = value as! HomeViewController
                    homeVC.faxNumberBtton_Update()
                    homeVC.getCreditUIUpdate()
                }
                else if value is SettingsViewController
                {
                    let settingVC = value as! SettingsViewController
                    settingVC.deviceCount = 0
                    settingVC.reloadTable()
                }*/
            }
        }
        
        alert.addAction(ok)
        
        hideLoadingAlertWithPresentController(viewcontroller: alert)
        //        viewContriller.present(alert, animated: true, completion: nil)
    }
}

func alertviewwithCompletion(title: String ,message : String ,  _ viewContriller : UIViewController,completion:@escaping () -> Void)
{
    DispatchQueue.main.async {
        let alert = UIAlertController(title: title , message: message , preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "", style: .default) { action in
            if UIApplication.topViewController() != nil{
                
               /* if value is HomeViewController
                {
                    let homeVC = value as! HomeViewController
                    homeVC.faxNumberBtton_Update()
                    homeVC.getCreditUIUpdate()
                }
                else if value is SettingsViewController
                {
                    let settingVC = value as! SettingsViewController
                    settingVC.deviceCount = 0
                    settingVC.reloadTable()
                }*/
                completion()
            }
        }
        
        alert.addAction(ok)
        hideLoadingAlertWithPresentController(viewcontroller: alert)
    }
}

func hideLoadingAlertWithPresentController(viewcontroller:UIViewController) {
   // stopSpinner()
    
    DispatchQueue.main.async {
        if let value = UIApplication.topViewController()
        {
            if value is UIAlertController
            {
              //  NetworkActivityIndicatorManager.stop()
                //            DLog("\(#line)")
                value.dismiss(animated: true, completion: {
                    UIApplication.topViewController()!.present(viewcontroller, animated: true, completion: nil)
                })
            }
            else
            {
                UIApplication.topViewController()!.present(viewcontroller, animated: true, completion: nil)
            }
        }
        else
        {
            UIApplication.topViewController()!.present(viewcontroller, animated: true, completion: nil)
        }
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
