//
//  PGlobalUtills.swift
//  NyteOut
//
//  Created by Paras Chodavadiya on 01/01/16.
//  Copyright © 2016 Nimisha Ranipa. All rights reserved.
//

import UIKit
import Foundation

import SwiftyUserDefaults
import SwiftyJSON

class PGlobalUtills: NSObject {
    
    let defaults : UserDefaults = UserDefaults.standard
    static let sharedInstance = PGlobalUtills()
    
    func DisplayAlert(title: String, message: String, vc: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message,          preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default,handler: nil)
        alertVC.addAction(okAction)
        vc.present(alertVC, animated: true, completion: nil)
    }
    
    func Alertview(title: String, body: String, cancelbutton: String, okbutton: String, completion:@escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        
        // Create the actions
        let cancelAction = UIAlertAction(title: cancelbutton, style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        let okAction = UIAlertAction(title: okbutton, style: UIAlertActionStyle.default) {
            UIAlertAction in
            completion()
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    func setAuthorized(){
        Defaults[UDK_isAuthorized] = true
    }
    func isAuthorized() -> Bool {
        return Defaults[UDK_isAuthorized]
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                NSPrint(items: error)
            }
        }
        return nil
    }
   
    func getDateBeforeYear (_ date : Date,year : NSInteger) -> Date
    {
        let gregorian: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let currentDate: Date = Date()
        var components: DateComponents = DateComponents()
        
        components.year = year
        let maxDate: Date = (gregorian as NSCalendar).date(byAdding: components, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        return maxDate
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    
    func AddLeftPadding (_ txtField : UITextField, Lpad : CGFloat) {
        
        var RView: UIView
        var RViewFrame: CGRect
        var RMView: UIView
        RViewFrame = CGRect(x: 5, y: 0, width: txtField.frame.size.height, height: txtField.frame.size.height)
        RView = UIView(frame: RViewFrame)
        RView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        RMView = UIView(frame: CGRect(x: 0, y: 0, width: Lpad, height: RView.frame.size.height))
        RMView.addSubview(RView)
        txtField.leftView = RMView
        txtField.leftViewMode = .always
        
    }
    func AddLeftimageToTextField(_ txtField: UITextField, ImageName imgName: String, withRightPad RPad: CGFloat, textFieldMode : UITextFieldViewMode) {
        var RView: UIView
        var RViewFrame: CGRect
        var RMView: UIView
        var RImgView: UIImageView
        RImgView = UIImageView(image: UIImage(named: imgName))
        
        RImgView.frame = CGRect(x: 20, y: 0, width: 20, height: 24)
        RImgView.contentMode = .scaleAspectFill
        
        RViewFrame = CGRect(x: 0, y: 0, width: 40, height: txtField.frame.size.height)
        RView = UIView(frame: RViewFrame)
        RView.backgroundColor = UIColor.clear
        RView.addSubview(RImgView)
        RImgView.center = RView.center
        RMView = UIView(frame: CGRect(x: 0, y: 0, width: RView.frame.size.width + RPad, height: RView.frame.size.height))
        RMView.addSubview(RView)
        txtField.leftView = RMView
        txtField.leftViewMode = textFieldMode
    }
    
    func SetBorderToView(_ view : UITextField,BorderColor : UIColor,BorderHeight : CGFloat)    {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: 39, width: view.frame.size.width, height: BorderHeight)
        bottomBorder.backgroundColor = BorderColor.cgColor
        view.layer .addSublayer(bottomBorder)
    }
    
    func SetBorderTo30TextField(_ view : UITextField,BorderColor : UIColor,BorderHeight : CGFloat)    {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: 29, width: view.frame.size.width, height: BorderHeight)
        bottomBorder.backgroundColor = BorderColor.cgColor
        view.layer .addSublayer(bottomBorder)
    }
    
    func SetPlaceholderTextWithColor(_ txtView : UITextField,PlaceHolderColor : UIColor,Text : NSString) {
        txtView.attributedPlaceholder = NSAttributedString(string:Text as String,
                                                           attributes:[NSAttributedStringKey.foregroundColor: PlaceHolderColor])
    }
    
    func SetCornerToView(_ view : UITextField,BorderColor : UIColor,BorderWidth : CGFloat)    {
        view.layer.borderColor = BorderColor.cgColor;
        view.layer.borderWidth = BorderWidth;
    }
    
    func validateEmail(emailStr : NSString) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailStr)
    }
    
    func viewEditingOff(_ tapView : UIView)
    {
        UIView .beginAnimations(nil, context: nil)
        UIView .commitAnimations()
        tapView .endEditing(true)
    }
    
    func setImgToNewPosition(_ img : UIImageView, newHeight : CGFloat, newY : CGFloat, pading : CGFloat)
    {
        var ImageFrame : CGRect = img.frame
        ImageFrame.origin.y = newY + pading
        ImageFrame.size.height = newHeight
        img.frame = ImageFrame
    }
    
    func setLabelToNewPosition(_ lbl : UILabel, newHeight : CGFloat, newY : CGFloat, pading : CGFloat)
    {
        var LabelFrame : CGRect = lbl.frame
        LabelFrame.origin.y = newY + pading
        LabelFrame.size.height = newHeight
        lbl.frame = LabelFrame
    }
    
    func setViewToNewPosition(_ view : UIView, newHeight : CGFloat, newY : CGFloat, pading : CGFloat)
    {
        var ViewFrame : CGRect = view.frame
        ViewFrame.origin.y = newY + pading
        ViewFrame.size.height = newHeight
        view.frame = ViewFrame
    }
    
    func setTextViewToNewPosition(_ lbl : UITextView, newHeight : CGFloat, newY : CGFloat, pading : CGFloat)
    {
        var TvFrame : CGRect = lbl.frame
        TvFrame.origin.y = newY + pading
        TvFrame.size.height = newHeight
        lbl.frame = TvFrame
    }
    
    func setTextFiedlToNewPosition(_ lbl : UITextField, newHeight : CGFloat, newY : CGFloat, pading : CGFloat)
    {
        var TvFrame : CGRect = lbl.frame
        TvFrame.origin.y = newY + pading
        TvFrame.size.height = newHeight
        lbl.frame = TvFrame
    }
   /* func dropShadow(_ tapView : UIView)
    {
        tapView.layer.masksToBounds = false
        tapView.layer.shadowColor = UIColor(hexString: "000000")?.cgColor
        tapView.layer.shadowOpacity = 0.5
        tapView.layer.shadowOffset = CGSize(width: 0, height: 3)
        tapView.layer.shadowRadius = 3
        tapView.layer.shadowPath = UIBezierPath(rect: tapView.bounds).cgPath
        tapView.layer.shouldRasterize = true
    }*/
    func RemoveShadow(_ tapView : UIView)
    {
        tapView.layer.masksToBounds = true
        tapView.layer.shadowColor = UIColor.clear.cgColor
        tapView.layer.shadowOpacity = 0
        tapView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tapView.layer.shadowRadius = 0
        tapView.layer.shadowPath = UIBezierPath(rect: tapView.bounds).cgPath
        tapView.layer.shouldRasterize = true
    }
    
    func GetAddreess(_ details : Dictionary<String, AnyObject>?)  throws -> String
    {
        var Address : String = "Location"
        
        if details!["city"] != nil && details!["city"] as! String != ""
        {
            Address = details!["city"] as! String
            if details!["state"] != nil && details!["state"] as! String != ""
            {
                Address = Address + ", " + (details!["state"] as! String)
                if details!["country"] != nil && details!["country"] as! String != ""
                {
                    Address = Address + ", " + (details!["country"] as! String)
                }
            }
            else
            {
                if details!["country"] != nil && details!["country"] as! String != ""
                {
                    Address = Address + ", " + (details!["country"] as! String)
                }
            }
        }
        else
        {
            if details!["state"] != nil && details!["state"] as! String != ""
            {
                Address = (details!["state"] as! String)
                if details!["country"] != nil && details!["country"] as! String != ""
                {
                    Address = Address + ", " + (details!["country"] as! String)
                }
            }
            else if details!["country"] != nil && details!["country"] as! String != ""
            {
                Address = (details!["country"] as! String)
            }
        }
        return Address
    }
    
    //MARK: - GET LIST OF U.S. STATES
    func getStateList() -> [String] {
       return ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
  /*  func openSettings(nav : UINavigationController, str : String) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        vc.str = str
        nav.pushViewController(vc, animated: true)
    }*/
    
//    func gaussBlur(_ view: UIView, img : UIImageView) {
//        let imageData = captureSnap(view)
//        var imageView : UIImage = UIImage(data: imageData)!
//        imageView = getSubImage(from: imageView, with: CGRect(x: 234, y: 130, width: 770, height: 615))
//        defer {
//        }
//        do {
//            let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur")
//            gaussianBlurFilter?.setDefaults()
//            let inputImage = CIImage(cgImage: (imageView.cgImage)!)
//            gaussianBlurFilter?.setValue(inputImage, forKey: kCIInputImageKey)
//            gaussianBlurFilter?.setValue(10, forKey: kCIInputRadiusKey)
//            let outputImage: CIImage? = gaussianBlurFilter?.outputImage
//            let context = CIContext(options: nil)
//            let cgimg: CGImage? = context.createCGImage(outputImage!, from: inputImage.extent)
//            // note, use input image extent if you want it the same size, the output image extent is larger
//            let image = UIImage(cgImage: cgimg!)
//            img.image = image
////            return image
//            //CGImageRelease(cgimg!)
//        } catch _ {
//            print("Error in Blur")
//        }
//    }
    
//    func captureSnap(_ View: UIView) -> Data {
//        UIGraphicsBeginImageContextWithOptions(View.bounds.size, View.isOpaque, UIScreen.main.scale)
//        View.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return UIImageJPEGRepresentation(img!, 1.0)!
//    }
    
    func getSubImage(from img: UIImage, with rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        // translated rectangle for drawing sub image
        let drawRect = CGRect(x: CGFloat(rect.origin.x), y: CGFloat(-rect.origin.y), width: CGFloat(img.size.width), height: CGFloat(img.size.height))
        // clip to the bounds of the image context
        // not strictly necessary as it will get clipped anyway?
        context?.clip(to: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(rect.size.width), height: CGFloat(rect.size.height)))
        // draw image
        img.draw(in: drawRect)
        // grab image
        let subImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return subImage!
    
    }

}
extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.init(rawValue: 5)!)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    class func hexa (_ hexStr : NSString, alpha : CGFloat) -> UIColor {
        let realHexStr = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: realHexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string", terminator: "")
            return UIColor.white
        }
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0,y: 0,width: thickness,height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness,y: 0,width: thickness,height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        
        self.addSublayer(border)
    }
    
    
}
extension String {
    /// The Localized string for the receiver
    var localized: String {
        return NSLocalizedString(self, comment: "")
         
    }
}
