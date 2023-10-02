//
//  CollectionItemView.swift
//  Collections
//
//  Created by Aaron Geist on 6/23/23.
//

import SwiftUI

struct CollectionItemView: View {
    @Binding var item: LP
    @Binding var collection: Collection
    @Binding var showEditing: Bool
    @Binding var delete: [Int]
    @Binding var showingDates: Bool
    @Binding var showingRating: Bool

    @State var wishlist: Bool = false
    @State var editing = false
    @State var showingAlbum = false
    @State var date = ""
    @State var newName = ""
    @State var newTitle = ""
    @State var deleteImage = "minus.circle"
    
    var body: some View {
            VStack (alignment: .leading){
                HStack{
                    if showEditing {
                        Button(action: {
                            var index = -1
                            if !wishlist{
                                index = collection.items.firstIndex(of: item) ?? -1
                            } else {
                                index = collection.wishlist.firstIndex(of: item) ?? -1
                            }
                            withAnimation{
                                if deleteImage == "minus.circle"{
                                    if index > -1 {
                                        delete.append(index)
                                    }
                                    deleteImage = "minus.circle.fill"
                                } else {
                                    let deleteIndex = delete.firstIndex(of: index) ?? -1
                                    
                                    if deleteIndex > -1 {
                                        delete.remove(at: deleteIndex)
                                    }
                                    deleteImage = "minus.circle"
                                }
                            }
                            
                        }){
                            Image(systemName: deleteImage)
                                .font(.title2)
                                .foregroundColor(Color(UIColor(cgColor: item.cover?.secondaryTextColor ?? UIColor.white.cgColor)))
                        }
                    }
                    if !item.tags.contains("Manual"){
                        AsyncImage(url: item.cover?.url(width: 60, height: 60))
                            .cornerRadius(5)
                    } else {
                        if let data = item.manualCover, let uiimage = UIImage(data: data){
                            Image(uiImage: uiimage)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(5)
                        }
                    }
                    VStack(alignment: .leading){
                        
                        Text("\(item.title)")
                            .font(.headline)
                        Text("\(item.artist)")
                        HStack{
                            if (!showEditing && showingDates) || collection.sortType == "Date"{
                                Text(date)
                                Spacer()
                            }
                            
                            if ((!showEditing && showingRating) || collection.sortType == "Rating") && !wishlist {
                                CollectionStarsView(item: item)
                            }
                        }
                        
                           
                    }
                    Spacer()
                    
                }
                .font(.caption)

            }
        .onAppear{
            date = dateFormatter.string(from: item.date)
        }
    
    }
}

