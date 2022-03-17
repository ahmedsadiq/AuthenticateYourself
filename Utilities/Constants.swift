//
//  Constants.swift
//  2FA
//
//  Created by Ahmed Sadiq on 15/03/2022.
//

import Foundation
class Constant : NSObject
{
    static let shared = Constant()
    
    let deviceToken = ""
    let callTOken = ""
    
    //Error Message
    let errorMessage:String = "Network connection failed"
    
    private var baseUrl : String {
        get {
            return ""
        }
    }
   
    var registerNo : String {
        get {
            return "\(baseUrl)/Login"
        }
    }
    var confirmOTP : String {
        get {
            return "\(baseUrl)/VerifyMsisdn"
        }
    }
}
