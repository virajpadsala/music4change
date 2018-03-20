//
//  CommanUntil.swift
//  M4C
//
//  Created by Hitesh Thummar on 11/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit
import SDWebImage

class CommanUntil: NSObject {
    
    
    func ViewCornerRadiou(view:UIView)  {
        view.layer.cornerRadius = 6.0
        view.layer.masksToBounds = true
    }
    
    func ButtonCornerRedious(button:UIButton)  {
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = true
    }
    
    func UserEmailTextField(textField:UITextField)  {
        textField.attributedPlaceholder = NSAttributedString(string: "ENTER EMAIL",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
    }
    
    func UserNameTextField(textField:UITextField)  {
        textField.attributedPlaceholder = NSAttributedString(string: "ENTER USERNAME",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
    }
    
    func PassowrdTextField(textField:UITextField)  {
        textField.attributedPlaceholder = NSAttributedString(string: "ENTER PASSWORD",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
    }
    
    func CPassowrdTextField(textField:UITextField)  {
        textField.attributedPlaceholder = NSAttributedString(string: "CONFIRM PASSWORD",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
    }
    
    // MARK: -Display Error alert Message
    
    func displayOkMsg(msg:String, title:String)  {
        let av = UIAlertView (title: title, message: msg, delegate: self, cancelButtonTitle: "Ok")
        av .show()
        
    }
    
   

}

extension Double {
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

func setcurrencyWithoutSymbol(price:String) ->String
{
    let amt = Double(price)
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = NumberFormatter.Style.currency
    // localize to your grouping and decimal separator
    currencyFormatter.locale = NSLocale.current
    currencyFormatter.currencySymbol = ""
    return currencyFormatter.string(from: amt! as NSNumber)!
    
}

func setBorderToView(view:UIView,color:UIColor,width:Int)
{
    view.layer.borderWidth = CGFloat(width)
    view.layer.borderColor = color.cgColor
    
}

func loadImageWithURL(url:String,view:UIImageView)
{
    if let imgurl = URL(string: url)
    {
        view.sd_setImage(with: imgurl, placeholderImage: nil, options: [.refreshCached, .allowInvalidSSLCertificates], completed: { (img, err, type, u) in
        })
    }
}
