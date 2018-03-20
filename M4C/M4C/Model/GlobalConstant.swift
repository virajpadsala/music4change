

import Foundation
import UIKit
import SwiftyUserDefaults

let staging = "http://whatsapplyrics.com/videostatus/api/api.php?req="
let Live = "http://whatsapplyrics.com/videostatus/api/api.php?req="
let stagingimage = "http://stg.visualregistration.no"
let Liveimage = "http://www.visualregistration.no"
struct API
{
    //static var API_BASE_URL  = Live
    
    static var API_BASE_URL  = staging
    static var IMAGE_BASE_URL  = stagingimage
    
    //static var GET_REQUEST_TOKEN   = API_BASE_URL + "token/get_request_token"
    static var LATEST                         = API_BASE_URL + "statuslist"
    static var CATEGORY                       = API_BASE_URL + "cactegory"
    static var SEARCH_STATUS                  = API_BASE_URL + "searchstatus"
    static var POPULAR_STATUS                 = API_BASE_URL + "popularstatus"
    static var RELATED_STATUS                 = API_BASE_URL + "relatedstatus"
}

let deviceType = UIDevice.current.userInterfaceIdiom
let screenscale = UIScreen.main.bounds.width/320.0
let screenwidth = UIScreen.main.bounds.width
let screenheight = UIScreen.main.bounds.height

let userdefault = UserDefaults.standard
let appdelegate = UIApplication.shared.delegate as! AppDelegate


enum userdefaultKey: String {
    case isLogin = "isLogin"
    case isFirstTime = "isFirstTime"
    case authToken = "authToken"
    case phoneNumber = "phoneNumber"
    case userID = "userID"
    case deviceToken = "deviceToken"
    
    case firstName = "firstName"
    case lastName = "lastName"
    case profilePic = "profilePic"
    
    case firstAlert = "firstAlert"
    case secondAlert = "secondAlert"
    case firstSentAlert = "firstSentAlert"
    case secondSentAlert = "secondSentAlert"
    case frequentContact = "frequentContact"
    case ratingPopup = "ratingPopup"
    case ratingPopupSecond = "ratingPopupSecond"
    case isOnboarding = "isOnboarding"
    case isProfileBadge = "isProfileBadge"
    case isPushEnable = "isPushEnable"
    case isPreviewEnable = "isPreviewEnable"
    case isSoundEnable = "isSoundEnable"
    case isVibrateEnable = "isVibrateEnable"
    case soundNameDefault = "soundNameDefault"
    case soundNameIndex = "soundNameIndex"
    case frequentContactList = "frequentContactList"
    case alertType = "alertType"
}

enum notificationDefaultKey: String {
    case reloadMyTaskNotification = "reloadMyTaskNotification"
    case reloadSentTaskNotification = "reloadSentTaskNotification"
}

struct ColorCode
{
    static var hex1 = "e57373"
    static var hex2 = "f06292"
    static var hex3 = "ba68c8"
    static var hex4 = "9575cd"
    static var hex5 = "7986cb"
    static var hex6 = "64b5f6"
    static var hex7 = "4fc3f7"
    static var hex8 = "4dd0e1"
    static var hex9 = "4db6ac"
    static var hex10 = "81c784"
    static var hex11 = "aed581"
    static var hex12 = "ff8a65"
    static var hex13 = "d4e157"
    static var hex14 = "ffd54f"
    static var hex15 = "ffb74d"
    static var hex16 = "a1887f"
    static var hex17 = "90a4ae"
    
    static var COLOR_APP = "009688"
    static var COLOR_NOTI = "e0f5fe"
    static var COLOR_BLACK = "101010"
    static var COLOR_DARK_GRAY = "9e9e9e"
    static var COLOR_LIGHT_GRAY = "f0f0f0"
    static var COLOR_PLACEHOLDER = "00796B"
    static var COLOR_BORDER = "FFFFFF"
}

struct FONT {
    static var FONT_BOLD     =  "HelveticaNeue-Bold"
    static var FONT_RAGULAR  =  "HelveticaNeue"
    static var FONT_LIGHT    =  "HelveticaNeue-Light"
}

struct IMAGESIZE {
    static var IMAGE_WIDTH     =  800
    static var IMAGE_HEIGHT    =  800
    static var IMAGE_QUALITY   =  0.7
}

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct UISCREEN {
    static var SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static var SCREEN_MAX_LENGTH    = max(SCREEN_WIDTH, SCREEN_HEIGHT)
    static var SCREEN_MIN_LENGTH    = min(SCREEN_WIDTH, SCREEN_HEIGHT)
}

struct DEVICE
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && UISCREEN.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && UISCREEN.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && UISCREEN.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && UISCREEN.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && UISCREEN.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && UISCREEN.SCREEN_MAX_LENGTH == 1366.0
}

struct VERSION{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (SYS_VERSION_FLOAT < 8.0 && SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (SYS_VERSION_FLOAT >= 8.0 && SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (SYS_VERSION_FLOAT >= 9.0 && SYS_VERSION_FLOAT < 10.0)
}

struct HEADER {
    //    static let REQUEST_TOKEN = AppPrefsManager.sharedInstance.getRequestToken() as String
    static let USER_AGENT = "budgetplanner iPhone 321"
}

struct HTTP_METHOD {
    static var GET      =  "GET"
    static var POST     =  "POST"
}

func ShortName(stateName: String){
    let StrUrl = String(format: "http://maps.googleapis.com/maps/api/geocode/json?address='%@'", stateName)
    let StrURL = StrUrl.replacingOccurrences(of: "\"" , with: "")
    let StrURL2 = StrURL.replacingOccurrences(of: " ", with: "")
    //print(StrURL2)
    let request = NSMutableURLRequest(url: NSURL(string:StrURL2)! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = nil
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if response != nil {
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if(statusCode == 200)
            {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    //print(jsonResponse as! NSDictionary)
                    let Dict : NSDictionary = jsonResponse as! NSDictionary
                    if (Dict.value(forKey: "results") != nil){
                        let Dict2 : NSMutableArray = Dict.value(forKey: "results") as! NSMutableArray
                        if  Dict2.count > 0 {
                            let Dict3 : NSDictionary = Dict2.object(at: 0) as! NSDictionary
                            let Dict4 : NSMutableArray = Dict3.value(forKey: "address_components") as! NSMutableArray
                            let Dict5 : NSDictionary = Dict4.object(at: 0) as! NSDictionary
                            let Dict6 : String = Dict5.value(forKey: "short_name") as! String
                            Defaults[UDK_ShortStateName] = Dict6
                        }else {
                            ShortName(stateName: stateName)
                        }
                    }
                }
                catch let error
                {
                    print(error)
                }
            }
        }
    })
    dataTask.resume()
}

extension UIColor {
    static let gradientStartColor = UIColor(red: 38.0/255.0,
                                            green: 64.0/255.0,
                                            blue: 89.0/255.0,
                                            alpha: 1.0)
    static let gradientEndColor = UIColor(red: 32.0/255.0,
                                          green: 35.0/255.0,
                                          blue: 68.0/255.0,
                                          alpha: 1.0)
    static let gradientColors: [UIColor] = [gradientStartColor, gradientEndColor]
    
    static let normalTabBarItem = UIColor(red: 143.0/255.0,
                                          green: 151.0/255.0,
                                          blue: 161.0/255.0,
                                          alpha: 1.0)

    static let selectedTabBarItem = UIColor(red: 35.0/255.0,
                                          green: 171.0/255.0,
                                          blue: 71.0/255.0,
                                          alpha: 1.0)

}


//extension UITabBar {
//
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        super.sizeThatFits(size)
//        guard let window = UIApplication.shared.keyWindow else {
//            return super.sizeThatFits(size)
//        }
//        var sizeThatFits = super.sizeThatFits(size)
//        if #available(iOS 11.0, *) {
//            sizeThatFits.height = window.safeAreaInsets.bottom + (UIScreen.main.bounds.size.width / 5) - 6
//        } else {
//            // Fallback on earlier versions
//            sizeThatFits.height = (UIScreen.main.bounds.size.width / 5) - 6
//        }
//        return sizeThatFits
//    }
//}


extension UIView {
    
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 8
        
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        view.backgroundColor = .clear
        setNavigationBarHidden(false, animated:true)
    }
    
    public func hideTransparentNavigationBar() {
        setNavigationBarHidden(true, animated:false)
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
}

extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
