//
//  UIFonts.swift
//  Pleez
//
//  Created by Jaydeep on 12/11/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    public class func AppFontRegular(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: fontSize)!
    }
    
    public class func AppFontSemiBold(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Semibold", size: fontSize)!
    }
    
    public class func AppFontBold(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: fontSize)!
    }
    
    public class func AppFontMedium(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: fontSize)!
    }
    
    public class func AppFontLight(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Light", size: fontSize)!
    }
    
    public class func AppFontHelveticaMedium(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: fontSize)!
    }
    
    public class func AppFontHelveticaItalica(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Italic", size: fontSize)!
    }
    
    public class func AppFontHelveticaBold(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: fontSize)!
    }
    
}
