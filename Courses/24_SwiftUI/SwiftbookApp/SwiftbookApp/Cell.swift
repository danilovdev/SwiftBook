//
//  Cell.swift
//  SwiftbookApp
//
//  Created by Alexey Danilov on 1/23/20.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import SwiftUI

struct Cell: View {
    
    var user: UserResponse
    
    var body: some View {
        VStack(spacing: 16.0) {
            TopView(user: user)
            Text(user.text)
            .lineLimit(nil)
        }.padding()
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(user: userResponse[0])
    }
}
