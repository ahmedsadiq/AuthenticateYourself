//
//  OTPViewModel.swift
//  AuthenticateYourself
//
//  Created by Ahmed Sadiq on 17/03/2022.
//

import Foundation

class OTPViewModel: ViewModel {
    // MARK: - CallBack
    var apiResponse: ((NSDictionary) -> Void)?
    var didError: ((NSError) -> Void)?
    
    // MARK: - API's -
    func resendOTP(msisdn: String, phoneNumber: String, countryCode: String) {
        let param:NSDictionary = ["msisdn":"\(msisdn)", "manufacturer":"Apple","OS":"ios","Version":"\(FAHelper.shared.osVersion)","DeviceId":FAHelper.shared.getDeviceToken(),"DateTime":"\(FAHelper.shared.current_Time)","PhNumber":"\(phoneNumber)","CountryCode":"\(countryCode)", "callToken":FAHelper.shared.getCallToken(),"verification_type":"phone","userEmail":""]
        URLHandler.sharedinstance.makeCall(url:Constant.shared.registerNo as String, param: param, completionHandler: {(responseObject, error) ->  () in
            if(error != nil)
            {
                self.didError?(error ?? NSError())
            }
            else {
                let result = responseObject! as NSDictionary
                self.apiResponse?(result)
            }
        })
    }
}
