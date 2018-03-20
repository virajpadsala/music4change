//
//  UIColor.swift
//  Pleez
//
//  Created by Jaydeep on 09/11/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func custColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

    convenience init(_ hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    static var settingsBackground = UIColor(0xE6E6E6)
}
