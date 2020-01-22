//
//  AlamofireNetworkRequest.swift
//  Networking
//
//  Created by Alexey Danilov on 10/23/19.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course]) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        request(url, method: .get).validate()
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    
                    guard let courses: [Course] = Course.getArray(from: value) else {
                        return
                    }
                    
                    completion(courses)
                    
                case .failure(let error):
                    print(error)
                }
            
        }
    }
}
