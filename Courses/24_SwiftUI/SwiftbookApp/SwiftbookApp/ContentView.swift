//
//  ContentView.swift
//  SwiftbookApp
//
//  Created by Alexey Danilov on 1/23/20.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var categories: [String: [ProductsResponse]] {
        .init(grouping: materialResponse,
              by: { $0.category.rawValue })
    }
    
    var body: some View {
        NavigationView {
            List {
                Cell(user: swiftbook).listRowInsets(EdgeInsets())
                ForEach(self.categories.keys.sorted(), id: \.self) { key in
                    ProductRow(categoryName: key,
                               items: self.categories[key]!)
                }.listRowInsets(EdgeInsets())
                
                NavigationLink(destination: FriendsList()) {
                    Text("Нащи преподаватели")
                }
            }
        .navigationBarTitle(Text("Friends"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
