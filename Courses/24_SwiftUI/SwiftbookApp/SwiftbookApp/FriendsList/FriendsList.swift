//
//  FriendsList.swift
//  SwiftbookApp
//
//  Created by Alexey Danilov on 1/23/20.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import SwiftUI

struct FriendsList : View {
    var body: some View {
        NavigationView {
            List(userResponse) { user in
                Cell(user: user)
            }
            .navigationBarTitle(Text("Friends"))
        }
    }
}

#if DEBUG
struct FriendsList_Previews : PreviewProvider {
    static var previews: some View {
        FriendsList()
    }
}
#endif
