//
//  Common.swift
//  Manage Golfer
//
//  Created by Viraj Padsala on 9/30/16.
//  Copyright © 2016 Viraj Padsala. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import SDWebImage

//MARK: - Colors
func RGBColor(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: 1.0)
}

let redColor : UIColor = RGBColor(235, green: 25, blue: 18)
let lightGrayColor = RGBColor(155, green: 155, blue: 155)
let lightSkyColor = RGBColor(99, green: 169, blue: 247)
let ACCEPTABLE_NUMBERS = "0123456789"
let pGlobal = PGlobalUtills()
//let aComman = CommonAPI()
//let cAPI = CommonAPI()

//Google Social Media Login
let kClientID = ""

//Rechability
var isInternetRechable = false

//Google Map Key
let kGoogleMap_API_Key = ""

//SwiftyUserDefaults
let UDK_userDetail = DefaultsKey<String>("userDetail")
let UDK_userEmail = DefaultsKey<String?>("userEmail")
let UDK_userName = DefaultsKey<String?>("userName")
let UDK_accessToken = DefaultsKey<String>("userToken")
let UDK_companyname = DefaultsKey<String>("companyname")
let UDK_orgnumber = DefaultsKey<String>("organization_number")
let UDK_Masteruser = DefaultsKey<[[String:Any]]>("Masteruser")
let UDK_Mastermanager = DefaultsKey<[[String:Any]]>("Mastermanager")
let UDK_Masteruserid = DefaultsKey<String>("Masteruserid")

let UDK_userAccountDetail = DefaultsKey<String>("userAccountDetail")
let UDK_sportDetail = DefaultsKey<String>("sportDetail")
let UDK_isAuthorized = DefaultsKey<Bool>("isAuthorized")
let UDK_location = DefaultsKey<String>("location")
let UDK_ctype = DefaultsKey<String>("ctype")
let UDK_ShortStateName = DefaultsKey<String>("ShortStateName")
let UDK_TaskCount = DefaultsKey<String>("TaskCount")
let UDK_NotificationCount = DefaultsKey<String>("NotificationCount")
extension DefaultsKeys {
    static let userDetail = DefaultsKey<String>("userDetail")
    static let userEmail = DefaultsKey<String?>("userEmail")
    static let userName = DefaultsKey<String?>("userName")
    static let accessToken = DefaultsKey<String>("userToken")
    static let companyname = DefaultsKey<String>("companyname")
    static let orgnumber = DefaultsKey<String>("organization_number")
      static let Masteruser = DefaultsKey<[[String:Any]]>("Masteruser")
     static let Mastermanager = DefaultsKey<[[String:Any]]>("Mastermanager")
    
     static let Masteruserid = DefaultsKey<String>("Masteruserid")
    static let userAccountDetail = DefaultsKey<String>("userAccountDetail")
    static let sportDetail = DefaultsKey<String>("sportDetail")
    static let deviceToken = DefaultsKey<String?>("DeviceToken")
    static let isAuthorized = DefaultsKey<Bool>("isAuthorized")
    static let location = DefaultsKey<String>("location")
    static let ctype = DefaultsKey<String>("ctype")
    static let ShortStateName = DefaultsKey<String>("ShortStateName")
    static let TaskCount = DefaultsKey<String>("TaskCount")
    static let NotificationCount = DefaultsKey<String>("NotificationCount")
}
//MARK: - Service Table Names
//let REACH_HOST = "http://public.managegolfer.com"
//let SERVICEPATH = "http://public.managegolfer.com/api/"   //LIVE
//let VERSION = SERVICEPATH + "v1/"
//let VERSION2 = SERVICEPATH + "v2/"
//let EMAIL_LOGIN = VERSION + "login"
//let EMAIL_REGISTER = VERSION + "register"

//MARK: - Common NSPrint For Enable / Disable Log
func NSPrint(items: Any..., separator: String = " ", terminator: String = "\n") {
    //#if RELEASE // RELEASE
        var idx = items.startIndex
        let endIdx = items.endIndex
        repeat {
            Swift.print(items[idx], separator: separator, terminator: idx == (endIdx - 1) ? terminator : separator)
            idx += 1
        }
        while idx < endIdx
//    #endif
}

//MARK: - Common Tableview with Animation Bottom to Top
func animateTable(tbl : UITableView) {
    let cells = tbl.visibleCells
    let tableHeight: CGFloat = tbl.bounds.size.height
    for i in cells {
        let cell: UITableViewCell = i as UITableViewCell
        cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
    }
    var index = 0
    for a in cells {
        let cell: UITableViewCell = a as UITableViewCell
        UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations:  {
            cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        index += 1
    }
}

//MARK: - Common Tableview with Animation Right to Left
func animateTableHorizontally(tbl : UITableView) {
    let cells = tbl.visibleCells
    let tablewidth: CGFloat = tbl.bounds.size.width
    for i in cells {
        let cell: UITableViewCell = i as UITableViewCell
        cell.transform = CGAffineTransform(translationX: tablewidth, y: 0)
    }
    var index = 0
    for a in cells {
        let cell: UITableViewCell = a as UITableViewCell
        UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        index += 1
    }
}

func image(from view: UIView) -> UIImage {
    UIGraphicsBeginImageContext(view.frame.size)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}

func setSd_ImageWithLoader(imageView : UIImageView) {
    imageView.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.white)    
    imageView.sd_addActivityIndicator()
}

func setPreffredInternetConnection(status : Bool) {
    isInternetRechable = status
}

func prefferedInternetConnection() -> Bool {
    return isInternetRechable
}

/*extension String {
    func nsRange(from range: Range<Index>) -> NSRange {
        let lower = UTF16View.Index(range.lowerBound, within: utf16)
        let upper = UTF16View.Index(range.upperBound, within: utf16)
        return NSRange(location: utf16.startIndex.distance(to: lower), length:
            lower!.distance(to: upper))
    }
    func stringToDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from:self)!
    }
    func toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}*/

/*func getnotificationMessage(notificationDetail : UserNotificationDetails) -> NSMutableAttributedString {
    switch notificationDetail.notificationTypeId {
    case 1:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 2:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 3:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 4:
        let message =  "\(notificationDetail.action.text!) \(notificationDetail.action.display!.uppercased())"
        let boldString = "Join Team"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        let index1 = message.nsRange(from: message.range(of: notificationDetail.action.display.uppercased())!)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(index1.location , notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        return attributedstring
    case 5:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let boldString = "Join Team"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        //        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGray, range:boldRange)
        return attributedstring
    case 6:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.length))
        return attributedstring
    case 7:
        let message =  "\(notificationDetail.action.text!) \(notificationDetail.action.display!.uppercased())"
        let attributedstring = NSMutableAttributedString(string: message)
        let boldString = "Recruit Player"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let index1 = message.nsRange(from: message.range(of: notificationDetail.action.display.uppercased())!)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(index1.location , notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        return attributedstring
    case 8:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let boldString = "Join Team"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        //        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGray, range:boldRange)
        return attributedstring
    case 9:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let boldString = "Recruit Player"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        //        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGray, range:boldRange)
        return attributedstring
    case 10:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let boldString = "Recruit Player"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        //        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGray, range:boldRange)
        return attributedstring
    case 11:
        let message = "\(notificationDetail.action.text!) \(notificationDetail.action.display!.uppercased())"
        let boldString = "Register Team"
        let index = message.nsRange(from: message.range(of: notificationDetail.action.display.uppercased())!)
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(index.location, notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        //        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGray, range:boldRange)
        return attributedstring
    case 12:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 13:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 14:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let boldString = "Register to League"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        return attributedstring
    case 15:
        let message = "\(notificationDetail.action.text!) \(notificationDetail.action.display!.uppercased())"
        let boldString = "Register to League"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        return attributedstring
    case 16:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let boldString = "Register to League"
        let boldRange = message.nsRange(from: message.range(of: boldString)!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        attributedstring.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-DemiBold", size: 13)!, range:boldRange)
        //        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGray, range:boldRange)
        return attributedstring
    case 17:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 18:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 19:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 20:
        let message = "\(notificationDetail.action.text!) \(notificationDetail.maker.displayName!.uppercased()) & \(notificationDetail.target.displayName!.uppercased())"
        let index = message.nsRange(from: message.range(of: notificationDetail.target.displayName.uppercased())!)
        let index1 = message.nsRange(from: message.range(of: notificationDetail.maker.displayName.uppercased())!)
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(index.location, notificationDetail.target.displayName.uppercased().length))
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(index1.location , notificationDetail.maker.displayName.uppercased().length))
        return attributedstring
    case 21:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 22:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 23:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 24:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    case 25:
        let message = "\(notificationDetail.action.display!.uppercased()) \(notificationDetail.action.text!)"
        let attributedstring = NSMutableAttributedString(string: message)
        attributedstring.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 99 / 255.0, green: 169 / 255.0, blue: 247 / 255.0, alpha: 1.0), range: NSMakeRange(0, notificationDetail.action.display.uppercased().length))
        return attributedstring
    default:
        return NSMutableAttributedString(string: "")
    }
}*/

/*func getnotificationProfile(notificationDetail :UserNotificationDetails) -> String {
    switch notificationDetail.notificationTypeId {
    case 4,6,9,10:
        return notificationDetail.maker.userProfilePicture != nil ? notificationDetail.maker.userProfilePicture : ""
    case 5,7,8,12,13,15,17,18,19:
        return notificationDetail.maker.teamProfilePicture != nil ? notificationDetail.maker.teamProfilePicture : ""
    case 11,14,16,22,21,20,23:
        return notificationDetail.maker.teamProfilePicture != nil ? notificationDetail.maker.teamProfilePicture : ""
    default:
        return ""
    }
}*/

