//
//  LendingScreenViewController.swift
//  M4C
//
//  Created by Hitesh Thummar on 11/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit

class LendingScreenViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var btnSignIN: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnContinueAsGuest: UIButton!
    
    
    @IBOutlet weak var viewDetail: UIView!
    
    let commanUntil = CommanUntil()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setScreenLayOut()
        
    }
    
    func setScreenLayOut()  {
        
        commanUntil.ViewCornerRadiou(view: viewDetail)
        commanUntil.ButtonCornerRedious(button: btnSignIN)
        commanUntil.ButtonCornerRedious(button: btnRegister)

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
