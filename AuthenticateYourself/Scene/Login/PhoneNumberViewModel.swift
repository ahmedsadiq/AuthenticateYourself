//
//  PhoneNumberViewModel.swift
//  AuthenticateYourself
//
//  Created by Ahmed Sadiq on 17/03/2022.
//

import Foundation

class PhoneNumberViewModel: ViewModel {
    
    var apiResponse: ((NSDictionary) -> Void)?
    var didError: ((NSError) -> Void)?
    // MARK: - API's -
    func registerPhoneNo(countyCode: String, txtPhoneNumber: String) {
        
        
        let param:NSDictionary = ["msisdn":"\(countyCode)\(txtPhoneNumber)","manufacturer":"Apple","OS":"ios","Version":"\(FAHelper.shared.osVersion)","DeviceId":FAHelper.shared.getDeviceToken(),"DateTime":"\(FAHelper.shared.current_Time)","PhNumber":"\(txtPhoneNumber)","CountryCode":"\(countyCode)", "callToken":FAHelper.shared.getCallToken(),"verification_type":"phone","userEmail":"", "emailVerified": 2]
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
