//
//  DivisionView.swift
//  Collections
//
//  Created by Aaron Geist on 7/13/23.
//

import SwiftUI

struct DivisionView: View {
    @Binding var collection: Collection
    @Binding var item: LP
    @Binding var user: User
    @Binding var editing: Bool
    @Binding var delete: [Int]
    @State var text = ""
    
    var body: some View {
        
//        Division(text: $text)
        
        HStack{
            CollectionItemView(item: $item, collection: $collection, showEditing: $editing, delete: $delete, showingDates: $user.showDates, showingRating: $user.showRating)
                .padding()
            
            if !editing{
                Image(systemName: "chevron.up")
                    .padding(.trailing)
            }

        }
        .onAppear{
            text = collection.show(album: item)
        }
        .onChange(of: collection.show, perform: { newValue in
            text = collection.show(album: item)

        })
        .background(
            Color(UIColor(cgColor: item.cover?.backgroundColor ?? UIColor.gray.cgColor)).gradient
        )
        .foregroundColor(Color(UIColor(cgColor: item.cover?.primaryTextColor ?? UIColor.black.cgColor)))
    }
}

