//
//  MenuView.swift
//  Collections
//
//  Created by Aaron Geist on 6/26/23.
//

import SwiftUI

struct MenuView: View {
    @Binding var editing: Bool
    @Binding var showingMenu: Bool
    @Binding var showingAdd: Bool
    @Binding var collection: Collection
    @State var wishlist: Bool
    @Binding var user: User
    
    private let sortType = ["Date", "Artist", "Title", "Rating"]
    @State private var name = ""

    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                Image(systemName: "trash.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                Text("Clear \(name)")
                    .font(.title2)
                    .onTapGesture {
                        withAnimation{
                            if !wishlist{
                                collection.clear()
                            } else {
                                collection.clearWishlist()
                            }
                        }
                        showingMenu.toggle()
                    }
            }
            .padding(.horizontal)
            HStack{
                Image(systemName: "minus.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                Text("Edit \(name)")
                    .font(.title2)
                    .onTapGesture {
                        withAnimation{
                            editing.toggle()
                        }
                        showingMenu.toggle()
                    }
            }
            .padding([.top, .horizontal])
            
            
            HStack{
                Image(systemName: "tag.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
//                        ForEach(collection.tags, id: \.self) { tag in
//                            FilterTagView(tags: $collection.tags, tag: tag)
//
//                        }
                    }
                }
            }
            .padding([.leading, .vertical])
            
            Divider()
            
            Toggle(isOn: $user.showDates.animation()){
                HStack{
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Show Dates")
                        .font(.title2)
                }
            }
            .tint(.black)
            .onChange(of: user.showDates) { newValue in
                print(user.showDates.description)
                user.save()
            }
            .padding([.top, .horizontal])
            
            
            Toggle(isOn: $user.showRating.animation()){
                HStack{
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Show Rating")
                        .font(.title2)
                }
            }
            .tint(.black)
            .onChange(of: user.showRating, perform: { newValue in
                print(user.showDates.description)
                user.save()
            })
            .padding([.top, .horizontal])
            
        }
        .padding(.top)
        .foregroundColor(.black)
        .onAppear{
            if !wishlist {
                name = collection.type
            } else {
                name = "Wishlist"
            }
        }
        
    }
    
}

