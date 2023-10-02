//
//  SelectLibraryView.swift
//  Collections
//
//  Created by Aaron Geist on 6/29/23.
//

import SwiftUI

struct SelectLibraryView: View {
    @Binding var user: User
    @Binding var collection: Collection
    @Binding var editing: Bool
    @Binding var i: Int

    private let collectionType = ["Vinyl", "CDs"]

    var body: some View {
        HStack{
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    
//                    if i == 0 {
//                        i = user.ids.count - 1
//                    } else {
//                        i-=1
//                    }
//                    print(i)
//                    withAnimation{
//                        collection.load(key: user.ids[i])
//                        print(collection)
//                        editing = false
//                    }
                }
                
            Spacer()

            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .onTapGesture {
//                    if i == user.ids.count - 1 {
//                        i = 0
//                    } else {
//                        i += 1
//                    }
//                    withAnimation{
//                        collection.load(key: user.ids[i])
//                        print(collection)
//                    }
                    editing = false
                }
        }
    }
}
