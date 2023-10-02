//
//  AddView.swift
//  Collections
//
//  Created by Aaron Geist on 6/23/23.
//

import SwiftUI
import MusicKit

struct AddView: View {
    @Binding var add: [LP]
    @Binding var wishlist: [LP]
    @State var searchResults = [LP]()
    @State var searchTerm = ""
    @Binding var collection: Collection
    @State var showingWishlist: Bool
    
    var body: some View {
        VStack {

                SearchBar(message: "Search", searchTerm: $searchTerm)
                .onChange(of: searchTerm, perform:{ newValue in
                    if !searchTerm.isEmpty{
                        fetchMusic(searchTerm: searchTerm)
                    }
                })
                .onSubmit {
                    if !searchTerm.isEmpty{
                        fetchMusic(searchTerm: searchTerm)
                    }
                }
            
            
            ScrollView(showsIndicators: true){
                if searchTerm.isEmpty{
                    VStack(alignment: .leading){
                        Text("Can't find what you're looking for?")
                        Text("Add items manually by holding down the '+' button on the library page")
                        Spacer()
                    }
                } else {
                    ForEach(searchResults, id: \.self){ item in
                        
                        if !collection.items.contains(where: {$0.id == item.id}) || !showingWishlist{
                            SearchItemView(item: item, inCollection: checkStatus(item: item), wishlist: $wishlist, add: $add, collection: $collection, showingWishlist: showingWishlist)
                        }
                    }
                }
            }
            
        }
        .background(.gray.gradient)
    }
    
    
    private func checkStatus(item: LP) -> Bool{
        return collection.items.contains{$0.id == item.id} || add.contains{$0.id == item.id}
    }
    
    
    private func fetchMusic(searchTerm: String){
         let request: MusicCatalogSearchRequest = {
             var request = MusicCatalogSearchRequest(term: searchTerm, types: [Album.self])
            request.limit = 25
            request.includeTopResults = true
            return request
        }()
        Task{
            let status = await MusicAuthorization.request()
            switch status{
            case.authorized:
                do{
                    let result = try await request.response()
                    
                    
                    withAnimation{
                        searchResults = result.albums.compactMap({
                            if type(of: $0) == MusicKit.Album.self{
                                return .init(title: $0.title, date: $0.releaseDate ?? Date(timeIntervalSinceNow: 0), artist: $0.artistName, cover: $0.artwork, id: $0.id, genres: $0.genreNames)
                            } else{
                                return .init(title: $0.title, date: $0.releaseDate ?? Date(timeIntervalSinceNow: 0), artist: $0.artistName, cover: $0.artwork, id: $0.id)
                            }
                        })
                    }
                    
                } catch {
                    print(String(describing: error))
                }
            default:
                break
            }
        }
    }
}

