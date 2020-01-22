//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Alexey Danilov on 8/16/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthService!
    
    init(authService: AuthService = AppDelegate.shared.authService) {
        self.authService = authService
    }
    
    func getFeed() {
        guard let token = authService.token else { return }
        var components = URLComponents()
        let filterParams = ["filters": "post, photo"]
        var allParams = filterParams
        allParams["access_token"] = token
        allParams["version"] = API.version
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) }
        let url = components.url!
        print(url)
        
    }
}
