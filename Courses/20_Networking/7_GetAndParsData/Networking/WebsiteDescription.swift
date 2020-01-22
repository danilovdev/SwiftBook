//
//  WebsiteDescription.swift
//  Networking
//
//  Created by Alexey Danilov on 10/19/19.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import Foundation

struct WebsiteDescription: Decodable {
    
    let websiteDescription: String?
    
    let websiteName: String?
    
    let courses: [Course]?
}
