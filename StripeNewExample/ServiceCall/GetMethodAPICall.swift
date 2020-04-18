//
//  UsersAPICall.swift
//  IncentiveApp
//
//  Created by ADMIN on 02/04/19.
//  Copyright © 2019 Success Resource Pte Ltd. All rights reserved.
//

import Foundation

class GetMethodAPICall: NSObject {
    static let sharedInstance = GetMethodAPICall()
    
/************************************ Get Method ***************************************/
    func getData(url: String, header: [String : String]?, completionHandler: @escaping( Data ) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: .infinity)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                guard let data = data else { return }
                completionHandler(data)
            }
        })
        dataTask.resume()
    }
}
