//
//  APICall.swift
//  IncentiveApp
//
//  Created by ADMIN on 02/04/19.
//  Copyright © 2019 Success Resource Pte Ltd. All rights reserved.
//

import Foundation

class PostMethodAPICall: NSObject {
    static let sharedInstance = PostMethodAPICall()
    
/************************************ Post Method ***************************************/
    func getResponse(url: String, body: [String : Any], header: [String : String], completionHandler: @escaping( Data ) -> Void){
        
        let postData = try! JSONSerialization.data(withJSONObject: body, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                //                completionHandler(response as! HTTPURLResponse)
                guard let httpResponseBody = data else { return }
                completionHandler(httpResponseBody)
            }
        })
        
        dataTask.resume()
    }
}
