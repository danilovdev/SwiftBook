//
//  Course.swift
//  Networking
//
//  Created by Alexey Danilov on 10/19/19.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import Foundation

struct Course: Decodable {
    
    let id: Int?
    
    let name: String?
    
    let link: String?
    
    let imageUrl: String?
    
    let numberOfLessons: Int?
    
    let numberOfTests: Int?
}
