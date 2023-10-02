//
//  SearchView.swift
//  Collections
//
//  Created by Aaron Geist on 6/23/23.
//

import SwiftUI

struct SearchItemView: View {
    @State var item: LP
    @State var inCollection: Bool
    @Binding var wishlist: [LP]
    @Binding var add: [LP]
    @Binding var collection: Collection
    @State var showingWishlist: Bool
    
    @State var plusImage = "plus.circle"
    @State var bookmarkImage = "bookmark"
    @State var added = false
    @State var inWishlist = false
    @State var index = 0
    @State var date = ""
    
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: item.cover?.url(width: 50, height: 50))
                    .padding(.trailing)
                VStack(alignment: .leading){
                    Text("\(item.title)")
                        .font(.headline)
                    Text("\(item.artist)")
                    Text(date)
                }
                .font(.caption)
                Spacer()
                if !showingWishlist {
                    Image(systemName: plusImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.trailing)
                        .foregroundColor(.white)
                        .onTapGesture{
                            if !inCollection {
                                 if !added {
                                    added.toggle()
                                    index = add.count
                                    add.append(item)
                                    withAnimation{
                                        plusImage = "plus.circle.fill"
                                    }
                                                                      
                                } else if added {
                                    added.toggle()
                                    add.remove(at: index)
                                    withAnimation{
                                        plusImage = "plus.circle"
                                    }
                                }
                            }
                        }
                } else {
                    Image(systemName: bookmarkImage)
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.trailing)
                        .onTapGesture {
                            if !inWishlist{
                                inWishlist.toggle()
                                collection.wishlistInsert(album: item)
                                withAnimation {
                                    bookmarkImage = "bookmark.fill"
                                }
                                
                            } else {
                                inWishlist.toggle()
                                withAnimation {
                                    let i = wishlist.firstIndex(of: item) ?? -1
                                    if i > -1 {
                                        wishlist.remove(at: i)
                                    }
                                    collection.save()
                                    withAnimation{
                                        bookmarkImage = "bookmark"
                                    }
                                }
                            }
                        }
                }
                    
                
            }
            .padding([.horizontal])

            Divider()
        }
        .onAppear{
            date = dateFormatter.string(from: item.date)
            if inCollection {
                plusImage = "plus.circle.fill"
            }
            inWishlist = wishlist.contains{ $0.id == item.id}
            if inWishlist {
                bookmarkImage = "bookmark.fill"
            }
        }
    }
        
}

