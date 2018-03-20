//
//  SecondSplashViewController.swift
//  M4C
//
//  Created by Kalpesh Satasiya on 12/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit

class SecondSplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // change 2 to desired number of seconds
            // Your code with delay
            if pGlobal.isAuthorized(){
                self.performSegue(withIdentifier: "Home", sender: self)
            }
            else{
                self.performSegue(withIdentifier: "Lending", sender: self)
            }
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
