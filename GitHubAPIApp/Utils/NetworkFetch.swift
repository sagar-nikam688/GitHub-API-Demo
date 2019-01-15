//
//  NetworkFetch.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 15/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import UIKit
import Foundation

class NetworkFetch: UIViewController {
    
    @available(*, deprecated, message: "use shareWithPars: instead")
    
    public static func shareWithPars(parameter:NSDictionary?,method: String, url: String, completion: @escaping (_ result: AnyObject) -> Void, completionError: @escaping (_ error:  Any) -> Void )  {
        let status = Reachability.isConnectedToNetwork()
        switch status {
        case .unknown,.offline:
            let errorDist = ["errorType":1, "errorValue": "No Internet Connection"] as [String : Any]
            completionError(errorDist as [String : Any])
            break
        case .online(.wwan),.online(.wiFi):
            guard let serviceUrl = URL(string: url) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = method
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter as Any, options: []) else {
                return
            }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        completion(json as AnyObject)
                        print(json)
                    } catch {
                        print(error)
                        completion(error as AnyObject)
                    }
                }
                if let error = error {
                    print(error)
                    completion(error as AnyObject)
                }
                }.resume()
        }
    }
    
}
