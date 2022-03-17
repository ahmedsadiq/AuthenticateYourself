//
//  FAHelper.swift
//  2FA
//
//  Created by Ahmed Sadiq on 14/03/2022.
//

import UIKit

final class FAHelper: NSObject {
    // MARK: - Properties -
    static let shared = FAHelper()
    // Initialization
    private override init() {}
    
    // MARK: - Methods -
    func UIColorFromHex(_ hexValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((hexValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hexValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hexValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    var osVersion:String{
        let systemVersion = UIDevice.current.systemVersion
        return systemVersion
    }
    func getDeviceToken() -> String
    {
        return Constant.shared.deviceToken
    }
    func getCallToken() -> String
    {
        return Constant.shared.callTOken
    }
    var current_Time:String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let  DateInFormat:String = dateFormatter.string(from: todaysDate as Date)
        print(DateInFormat)
        return DateInFormat
    }
    func checkNullvalue(value:Any?) -> String {
        var Param:Any? = value
        if(Param == nil || Param is NSNull)
        {
            Param=""
        }
        else
        {
            Param = String(describing: value!)
        }
        return Param as! String
    }
}
