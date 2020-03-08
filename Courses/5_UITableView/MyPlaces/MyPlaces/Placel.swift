//
//  Place.swift
//  MyPlaces
//
//  Created by Alexey Danilov on 3/8/20.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import Foundation

struct Place {
    
    let name: String
    
    let location: String
    
    let type: String
    
    let image: String
    
    static private let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]
    
    static func getPlaces() -> [Place] {
        var places: [Place] = []
        
        for name in restaurantNames {
            places.append(Place(name: name, location: "Москва", type: "Ресторан", image: name))
        }
        
        return places
    }
}
