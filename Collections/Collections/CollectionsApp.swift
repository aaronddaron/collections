//
//  CollectionsApp.swift
//  Collections
//
//  Created by Aaron Geist on 6/22/23.
//

import SwiftUI
import MusicKit

@main
struct CollectionsApp: App {
    
    init(){
        setDateStyle()
        setDuration()
        fetchMusic(searchTerm: "Band")
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()

        }

    }
    
    @State private var searchResults = [LP]()
    private func fetchMusic(searchTerm: String){
         let request: MusicCatalogSearchRequest = {
             var request = MusicCatalogSearchRequest(term: searchTerm, types: [Album.self])
            request.limit = 25
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
