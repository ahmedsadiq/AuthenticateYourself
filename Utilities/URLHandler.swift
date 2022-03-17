//
//  URLHandler.swift
//  2FA
//
//  Created by Ahmed Sadiq on 15/03/2022.
//

import Foundation
import UIKit
import Alamofire
import SystemConfiguration


protocol URLHandlerDelegate : AnyObject {
    func ReturnDownloadProgress(id: String, Dict: NSDictionary, status: String)
}

final class URLHandler: NSObject {
    
    weak var Delegate:URLHandlerDelegate?
    static let sharedinstance = URLHandler()
    var Dictionary:NSDictionary!=NSDictionary()
    var RetryValue:NSInteger!=3
    func makeCall(url: String,param:NSDictionary, completionHandler: @escaping (_ responseObject: NSDictionary?,_ error:NSError?  ) -> ()?) {
        let HeaderDict:NSDictionary=NSDictionary()
        Alamofire.request("\(url)", method: .post, parameters: param as? Parameters, encoding: JSONEncoding.default, headers: HeaderDict as? HTTPHeaders).validate()
            .responseJSON { response in
                if(response.result.error == nil)
                {
                    do {
                        
                        self.Dictionary = try JSONSerialization.jsonObject(
                            with: response.data!,
                            options: JSONSerialization.ReadingOptions.mutableContainers
                        ) as? NSDictionary
                        completionHandler(self.Dictionary as NSDictionary?, response.result.error as NSError? )
                    }
                    catch let error as NSError {
                        // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
                        print("A JSON parsing error occurred, here are the details:\n \(error)")
                        self.Dictionary=nil
                        completionHandler(self.Dictionary as NSDictionary?, error )
                    }
                }
                else
                {
                    var i=0;
                    if(i<self.RetryValue)
                    {
                        completionHandler(self.Dictionary as NSDictionary?, response.result.error as NSError? )
                        
                    }
                    else
                    {
                        self.Dictionary=nil
                        completionHandler(self.Dictionary as NSDictionary?, response.result.error as NSError? )
                        print("A JSON parsing error occurred, here are the details:\n \(response.result.error!)")
                    }
                    i=i+1
                    
                }
            }
    }
    deinit {
    }
}
