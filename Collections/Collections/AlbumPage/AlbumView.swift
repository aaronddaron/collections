//
//  InspectionView.swift
//  Collections
//
//  Created by Aaron Geist on 6/27/23.
//

import SwiftUI
import MusicKit

struct InspectionView: View {
    @Binding var collection: Collection
    @Binding var album: DetailedAlbum
    @Binding var opacity: Double
    @Binding var offset: CGFloat
    @Binding var editing: Bool

    @State private var stars = ["star", "star", "star", "star", "star"]
    @State private var newName = ""
    @State private var newTitle = ""
    @State private var genres = [String]()
    
    @State var songs: MusicItemCollection<Track> = MusicItemCollection<Track>()
    @State var artists: MusicItemCollection<Artist> = MusicItemCollection<Artist>()
    @State var albums: [LP] = []
    @State var copyright: String = ""
    @State var notes: String = ""
    @State var numTracks: Int = 0
    @State var duration: String = ""
    @State var date = ""
    
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    CirclesView(album: $album)
                    Spacer()
                    ArrowsView(collection: $collection, album: $album, editing: $editing, stars: $stars)
                    
                }
                .foregroundColor(album.button)
                .padding(.horizontal, 15)
     
                if !album.tags.contains("Manual"){
                    AsyncImage(url: album.cover)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
                    .padding(5)
                } else {
                    if let data = album.manualCover, let uiimage = UIImage(data: data){
                        Image(uiImage: uiimage)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 10, x: 0, y: 5)
                            .padding(5)
                        
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .frame(width: 300, height: 300)
                            .shadow(color: .black, radius: 10, x: 0, y: 5)
                            .padding(5)
                        
                    }
                }
                
            }
                    
            VStack{
                
                if !editing {
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            Text(album.title)
                                .font(.title)
                            Text(album.artist)
                                .font(.title2)
                            Spacer()
                       
                            Text(album.sortGenre)
                                
                        }
                        Spacer()
                        VStack(alignment: .trailing){
                            StarsView(album: $album, stars: $stars)
                                .foregroundColor(album.button)
                                .font(.title)
                            Text(date)
                                .font(.title3)
                            Spacer()
                            if !album.tags.contains("Manual"){
                                Text("\(numTracks) tracks - \(duration)")
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                    .padding([.horizontal, .top], 10)
                } else {
                    AlbumEditView(collection: $collection, album: $album, newName: $newName, newTitle: $newTitle, editing: $editing)
                }
                
                if !album.tags.contains("Manual"){ //Print tracks if not 
                    TracksView(album: $album, songs: $songs)
                
                    Text(notes)
                        .padding(10)
                    Text(copyright)
                        .font(.caption2)
                        .padding(.bottom, 10)
                } else {
                   Text("")
                }
                
            }
            .foregroundColor(album.text)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(album.background)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
            )
            
            AddGenresView(collection: $collection, album: $album, genres: $genres)
            AddTagsView(collection: $collection, album: $album)
            
            HStack{
                Text("More from \(album.artist)")
                    .foregroundColor(album.text)
                    .padding([.leading, .top])
                Spacer()
            }
                
            AlbumArtistView(artists: $artists, albums: $albums, album: $album, collection: $collection, editing: $editing, stars: $stars)
                        
            Spacer()
                        
        }
        .padding(.bottom, 30)
        .padding(.top)
        .opacity(opacity)
        .onDisappear{
            withAnimation(.easeOut){
                opacity = 0
            }

            withAnimation{
                collection.changeRating(of: album, to: stars)
                collection.changeSortGenre(of: album, to: album.sortGenre)
            }
        }
        .onAppear{
            newName = album.artist
            newTitle = album.title
            genres = album.genres
            
            
            withAnimation(.easeOut){
                opacity = 1
            }
            
            stars = album.getRating()
            albums = collection.albumsInCollectionBy(name: album.artist)
            date = dateFormatter.string(from: album.date)
            
            if !album.tags.contains("Manual"){
                Task{
                    let status = await MusicAuthorization.request()
                    switch status{
                    case.authorized:
                        do{
                            let request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: album.id )
                            let response = try await request.response()
                            guard let data = response.items.first else { return }
                            let detailedAlbum = try await data.with([.tracks, .artists])
                            songs = detailedAlbum.tracks!
                            artists = detailedAlbum.artists!
                            notes = (data.editorialNotes?.short) ?? ""
                            numTracks = data.trackCount
                            copyright = data.copyright ?? ""
                            
                            var length = 0.0
                            for song in songs {
                                length += song.duration ?? 0
                            }
                            duration = durationFormatter.string(from: length) ?? ""
                            
                           
                        } catch {
                            print(String(describing: error))
                        }
                    default:
                        break
                    }
                      
                } 
            } else {
                artists = MusicItemCollection<Artist>()
                Task{
                    let status = await MusicAuthorization.request()
                    switch status{
                    case.authorized:
                        do{
                            var request = MusicCatalogSearchRequest(term: album.artist, types: [Artist.self])
                            request.limit = 1
                            let response = try await request.response()
                            artists = response.artists
                            
                        } catch {
                            print(String(describing: error))
                        }
                    default:
                        break
                    }
                }
            }
        }
        .onChange(of: album.id) { newValue in
            genres = album.genres
            newName = album.artist
            newTitle = album.title

            stars = album.getRating()
            albums = collection.albumsInCollectionBy(name: album.artist)
            date = dateFormatter.string(from: album.date)
            
            if !album.tags.contains("Manual"){
                Task{
                    let status = await MusicAuthorization.request()
                    switch status{
                    case.authorized:
                        do{
                            let request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: album.id )
                            let response = try await request.response()
                            guard let data = response.items.first else { return }
                            let detailedAlbum = try await data.with([.tracks, .artists])
                            songs = detailedAlbum.tracks!
                            artists = detailedAlbum.artists!
                            notes = (data.editorialNotes?.short) ?? ""
                            numTracks = data.trackCount
                            copyright = data.copyright ?? ""
                            
                            var length = 0.0
                            for song in songs {
                                length += song.duration ?? 0
                            }
                            duration = durationFormatter.string(from: length) ?? ""
                            

                        } catch {
                            print(String(describing: error))
                        }
                    default:
                        break
                    }
                      
                }
            } else {
                artists = MusicItemCollection<Artist>()
                Task{
                    let status = await MusicAuthorization.request()
                    switch status{
                    case.authorized:
                        do{
                            var request = MusicCatalogSearchRequest(term: album.artist, types: [Artist.self])
                            request.limit = 1
                            let response = try await request.response()
                            artists = response.artists
                            
                        } catch {
                            print(String(describing: error))
                        }
                    default:
                        break
                    }
                }
            }
            
        }
    }
    
    
}


