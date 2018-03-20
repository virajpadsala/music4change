//
//  CustomTabBarController.swift
//  VRS
//
//  Created by Viraj Padsala on 30/01/18.
//  Copyright © 2018 Viraj Padsala. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.selectedTabBarItem, size: CGSize.init(width: self.tabBar.frame.width/5, height: self.tabBar.frame.height))
        UITabBar.appearance().barTintColor = UIColor.init(red: 32, green: 35, blue: 68)
        let yOffset = 9 * self.tabBar.frame.width / 320
        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0.0, 0.0 - yOffset)

        // Uses the original colors for your images, so they aren't not rendered as grey automatically.
        for item in (self.tabBar.items)! {
            if let image = item.image {
                item.image = image.withRenderingMode(.alwaysOriginal)
                item.selectedImage = image.withRenderingMode(.alwaysOriginal)
            }

            
        }
        self.tabBar.tintColor = UIColor.white
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
        
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
