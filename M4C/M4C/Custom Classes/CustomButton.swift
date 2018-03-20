//
//  CustomButton.swift
//  GoTeam
//
//  Created by Viraj Padsala on 6/5/17.
//  Copyright © 2017 Viraj Padsala. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    var tag1 = 0
    var section = 0
    var row = 0
}
