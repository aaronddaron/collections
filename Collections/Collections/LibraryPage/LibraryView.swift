//
//  ContentView.swift
//  Collections
//
//  Created by Aaron Geist on 6/22/23.
//

import SwiftUI
import MusicKit

struct LibraryView: View {
    
    @Binding var user: User
    @State var key: String
    
    @State private var add = [LP]()
//    @State var filtered = [LP]()
    @State private var manualItem = LP(title: "", date: Date(), artist: "", id: "")
    @State private var delete = [Int]()
    @State private var opacity = 0.0
    @State private var offset: CGFloat = 1000
    @State private var collection = Collection()
    @State private var album = DetailedAlbum(item: LP(title: "", date: Date(), artist: "", id: ""))
    
    
    @State var manualAdd = false
    @State var editing = false
    @State var editingAlbum = false
    @State var showingAdd = false
    @State var showingMenu = false
    @State var showingSort = false
    @State var goBack = false
    @State var wishlist = false
    @State var filtering = false
//    @State var plusSymbol = ""
    
    var body: some View {
        if goBack{
            HomeView()
        } else {
            library
        }
    }
    
    var library: some View {
        VStack{
            if offset != 125 && !editing && !filtering{
                HStack{
                    HStack{
                        Image(systemName: "chevron.left")

                        Text(collection.type)
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                    .onTapGesture {
                        withAnimation{
                            goBack.toggle()
                            
                        }
                        
                    }

                    Spacer()
                    NavBarView(showingMenu: $showingMenu, showingAdd: $showingAdd, manualAdd: $manualAdd, editing: $editing, wishlist: $wishlist, offset: $offset)
                    
                }
                .foregroundColor(.white)
                .padding()
                .background(.gray.opacity(0.1))
                .font(.title3)
                
            } else if editing {
                HStack{
                    Button(action: {
                        withAnimation{
                            editing.toggle()
                        }
                    }){
                        Text("Done")
                            .font(.title2)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation{
                            if !wishlist {
                                collection.delete(indeces: IndexSet(delete))
                            } else {
                                collection.deleteWishlist(indeces: IndexSet(delete))
                            }
                            delete.removeAll()
                            editing.toggle()
                        }
                    }){
                        Text("Delete")
                            .font(.title2)
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(.gray.opacity(0.1))
            } else if offset == 125{
                AlbumNavBarView(album: $album, collection: $collection, opacity: $opacity, offset: $offset, editing: $editingAlbum)
                    .padding()
                    .padding(.bottom)
                    .padding(.bottom)
                    .background(.gray.opacity(0.1))
                    .foregroundColor(.white)
            } else if filtering {
                HStack{
                    Text("Results")
                        .font(.title2)
                    Spacer()
                    Text("Done")
                        .onTapGesture {
                            withAnimation{
                                collection.filtered = []
                                filtering.toggle()
                            }
                        }
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .padding()
            }

            ScrollView(showsIndicators: true){
                if !wishlist && !filtering{
                    ForEach($collection.items, id: \.self){ $item in
                        
                        DivisionView(collection: $collection, item: $item, user: $user, editing: $editing, delete: $delete)
//
//                        HStack{
//                            CollectionItemView(item: $item, collection: $collection, showEditing: $editing, delete: $delete, showingDates: $user.showDates, showingRating: $user.showRating)
//                                .padding()
//
//                            if !editing{
//                                Image(systemName: "chevron.up")
//                                    .padding(.trailing)
//                            }
//
//                        }
//                        .background(
//                            Color(UIColor(cgColor: item.cover?.backgroundColor ?? UIColor.gray.cgColor)).gradient
//                        )
//                        .foregroundColor(Color(UIColor(cgColor: item.cover?.primaryTextColor ?? UIColor.black.cgColor)))
                        .onTapGesture {
                            if !editing {
                                if offset == 1000{
                                    album = DetailedAlbum(item: item)

                                    withAnimation(.easeOut(duration: 1)){
                                        offset = 125
                                    }
                                }
                            }
                            
                        }
                            
                        
                        
                    }
                } else if wishlist {
                    ForEach($collection.wishlist, id: \.self){ $item in
                        HStack{
                            CollectionItemView(item: $item, collection: $collection, showEditing: $editing, delete: $delete, showingDates: $user.showDates, showingRating: $user.showRating, wishlist: true)
                                .padding()
                            
                            if !editing {
                                Image(systemName: "plus")
                                    .padding(.trailing)
                                    .foregroundColor(Color(UIColor(cgColor: item.cover?.secondaryTextColor ?? UIColor.black.cgColor)))
                                    .onTapGesture {
                                        withAnimation{
                                            collection.insert(add: [item])
                                        }
                                    }
                                    
                            }

                        }
                        .background(
                            Color(UIColor(cgColor: item.cover?.backgroundColor ?? UIColor.white.cgColor)).gradient
                        )
                        .foregroundColor(Color(UIColor(cgColor: item.cover?.primaryTextColor ?? UIColor.black.cgColor)))
                    }
                } else if filtering {
                    ForEach($collection.filtered, id: \.self){ $item in
                        HStack{
                            CollectionItemView(item: $item, collection: $collection, showEditing: $editing, delete: $delete, showingDates: $user.showDates, showingRating: $user.showRating)
                                .padding()
                            
                            if !editing{
                                Image(systemName: "chevron.up")
                                    .padding(.trailing)
                            }
                            
                        }
                        .background(
                            Color(UIColor(cgColor: item.cover?.backgroundColor ?? UIColor.gray.cgColor)).gradient
                        )
                        .foregroundColor(Color(UIColor(cgColor: item.cover?.primaryTextColor ?? UIColor.black.cgColor)))
                        .onTapGesture {
                            if !editing {
                                if offset == 1000{
                                    album = DetailedAlbum(item: item)
                                    withAnimation(.easeOut(duration: 1)){
                                        offset = 125
                                    }
                                }
                            }
                            
                        }
                    }
                }
                
            }
          
            HStack{
                QueryView(collection: $collection, filtering: $filtering, filtered: $collection.filtered, wishlist: $wishlist)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .ignoresSafeArea()
            
        }
        .sheet(isPresented: $manualAdd) {
            NavigationStack{
                ManualAddView(newItem: $manualItem)
                    .foregroundColor(.black)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                                Text(collection.type)
                                    .font(.title)
                                    .foregroundColor(.black)
                            
                        }
                        ToolbarItem(placement: .confirmationAction){
                                Text("Add")
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        
                                        manualItem.artist = manualItem.artist.trimmingCharacters(in: .whitespacesAndNewlines)
                                        manualItem.title = manualItem.title.trimmingCharacters(in: .whitespacesAndNewlines)
                                        manualItem.sortGenre = manualItem.sortGenre.trimmingCharacters(in: .whitespacesAndNewlines)
                                        
                                        manualItem.id = MusicItemID(rawValue: UUID().uuidString)
                                        manualItem.genres = [manualItem.sortGenre]
                                        manualItem.tags = ["Manual"]
                                        print(manualItem)
                                        
                                        collection.insert(add: [manualItem])
                                        manualAdd.toggle()
                                    }
                            
                        }
                    }
            }
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showingAdd) {
            NavigationStack{
                AddView(add: $add, wishlist: $collection.wishlist, collection: $collection, showingWishlist: wishlist)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                                Text(collection.type)
                                    .font(.title)
                                    .foregroundColor(.black)
                            
                        }
                        
                        if !wishlist{
                            ToolbarItem(placement: .confirmationAction){
                                Button("Add") {
                                    collection.insert(add: add)
                                    add.removeAll()
                                    showingAdd = false
                                    print(collection)
                                }
                                .disabled(add.isEmpty)
                                .foregroundColor(.white)
                            }
                        }
                    }
            }
            .presentationDragIndicator(.visible)
            
        }
        .sheet(isPresented: $showingMenu) {
            MenuView(editing: $editing, showingMenu: $showingMenu, showingAdd: $showingAdd, collection: $collection, wishlist: wishlist, user: $user)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.visible)
                    .safeAreaInset(edge: .bottom){}
                    .background(.gray.gradient)
        }
        .onAppear{
            let value = user.types[key] ?? ""
            collection.load(key: value)
            
            if collection.items.isEmpty {
                showingAdd.toggle()
            }
            
        }
        .overlay(
                
            ZStack(alignment: .bottom){
                RoundedRectangle(cornerRadius: 30)
                    .fill(album.background)
                    .opacity(0.85)
                    .offset(y: offset)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
                if offset == 125 {
                
                    ScrollView{
                        InspectionView(collection: $collection, album: $album, opacity: $opacity, offset: $offset, editing: $editingAlbum)
                    }
                    .offset(y: offset - 85)
                }
            }
        )
        .background(.gray.gradient)
        
    }
    
}
