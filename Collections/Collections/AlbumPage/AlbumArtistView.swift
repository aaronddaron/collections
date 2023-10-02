//
//  AlbumArtistView.swift
//  Collections
//
//  Created by Aaron Geist on 7/1/23.
//

import SwiftUI
import MusicKit

struct AlbumArtistView: View {
    @Binding var artists: MusicItemCollection<Artist>
    @Binding var albums: [LP]
    @Binding var album: DetailedAlbum
    @Binding var collection: Collection
    @Binding var editing: Bool
    @Binding var stars: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .top){
                ForEach(artists, id: \.self) {a in
                    AsyncImage(url: a.artwork?.url(width: 150, height: 150))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(album.button, lineWidth: 3)
                                .shadow(color: .black, radius: 10, x: 0, y: 5)
                        )
                        .padding(.trailing, 20)
                }
                
                ForEach(albums, id: \.self) {lp in
                    if lp.id != album.id{
                        AsyncImage(url: lp.cover?.url(width: 150, height: 150))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(album.button, lineWidth: 3)
                                    .shadow(color: .black, radius: 10, x: 0, y: 5)
                            )
                            .padding(.trailing, 20)
                            .onTapGesture {
                                
                                withAnimation{
                                    collection.changeRating(of: album, to: stars)
                                }
                                
                                withAnimation{
                                    collection.changeSortGenre(of: album, to: album.sortGenre)
                                }
                                
                                let item = collection.items.first{$0.id == lp.id}
                                if !editing{
                                    withAnimation{
                                        album = DetailedAlbum(item: item ?? LP(title: "", date: Date(), artist: "", id: ""))
                                    }
                                }
                            }
                    }
                }
            }
            .padding([.vertical, .leading])
            .padding(.vertical, 5)
        }
        .foregroundColor(album.text)
    }
}


