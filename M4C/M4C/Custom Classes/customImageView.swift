//
//  customImageView.swift
//  GoLeague
//
//  Created by Viraj Padsala on 07/07/17.
//  Copyright © 2017 Viraj Padsala. All rights reserved.
//

import UIKit

class customImageView: UIImageView {

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
//    @IBInspectable var tintcolor: UIImage? {
//        didSet {
//            self.tintColor = tintcolor?
        


    
    var tag1 = 0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
        }


