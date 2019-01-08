//
//  AppDelegate.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 04/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

// Note: Todo Added proper spinner here
public class NetworkHelper : UIViewController {
    
    @available(*, deprecated, message: "use shareWithPars: instead")

    public static func shareWithPars(parameter:NSDictionary?,method: HTTPMethod, url: String, completion: @escaping (_ result: [[String : Any]]) -> Void, completionError: @escaping (_ error:  [String : Any]) -> Void , completionLogin: @escaping (_ result: [String : Any]) -> Void )  {
        let status = Reachability.isConnectedToNetwork()
        switch status {
        case .unknown,.offline:
            let errorDist = ["errorType":1, "errorValue": "No Internet Connection"] as [String : Any]
            completionError(errorDist as [String : Any])
            break
        case .online(.wwan),.online(.wiFi):
            Alamofire.request( url , method: .get)
                .responseJSON { response in
                    if response.result.isSuccess {
                        print(response)
                        if let json = response.result.value {
                            if let jsonDict = json as? [String: Any] {
                                completionLogin(jsonDict)
                            } else if let jsonObjects = json as? [[String: Any]] {
                                completion(jsonObjects)
                            }
                        }
                    } else if let error = response.result.error {
                        let errorDist = ["errorType":2, "errorValue": error] as [String : Any]
                        completionError(errorDist as [String : AnyObject])
                    }
            }
        }
    }
    
    public static func headerDictionary()-> NSMutableDictionary {
        let headers: NSMutableDictionary = NSMutableDictionary()
        headers.setValue("application/json", forKey: "Content-Type")
        return headers
    }
    
}
