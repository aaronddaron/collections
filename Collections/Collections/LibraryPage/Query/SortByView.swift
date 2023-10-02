//
//  SortByView.swift
//  Collections
//
//  Created by Aaron Geist on 7/7/23.
//

import SwiftUI

struct SortByView: View {
    @Binding var collection: Collection
    private let sortType = ["Date", "Artist", "Title", "Rating"]
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "square.3.layers.3d.middle.filled")
                Text("Sort By:")
            }
            .padding(.horizontal)
            Toggle(isOn: $collection.asc){
                HStack{
                    Image(systemName: "chevron.up.circle")
                        .foregroundColor(.white)
                    Text("Ascending Order")
                }
            }
            .padding(.horizontal)
            .onChange(of: collection.asc) { newValue in
                print("changed")
                withAnimation{
                    switch collection.sortType{
                    case "Artist":
                        collection.sort()
                    default:
                        collection.items.reverse()
                        if collection.filtered.count > 0 {
                            collection.filtered.reverse()
                        }
                        collection.save()
                    }
                }
            }
            .font(.title2)
            .tint(.black)
               
            ForEach(sortType, id: \.self) { type in
                SortView(sortBy: type, collectionSort: $collection.sortType)
                    .onTapGesture {
                        withAnimation{
                            collection.changeSortType(type: type)
                        }
                    }
            }
            Spacer()
        }
        .padding(.top)
    }
}

