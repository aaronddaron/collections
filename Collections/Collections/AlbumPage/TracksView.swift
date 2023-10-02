//
//  TracksView.swift
//  Collections
//
//  Created by Aaron Geist on 7/1/23.
//

import SwiftUI
import MusicKit

struct TracksView: View {
    @Binding var album: DetailedAlbum
    @Binding var songs: MusicItemCollection<Track>
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            VStack(alignment: .leading){
               
                ForEach(songs, id: \.self){ track in
                    HStack(alignment: .top){
                        Text("\(track.trackNumber ?? 0)")
                        Text("\(track.title)")
                            .font(.headline)
                    }
                }
            }
            Spacer()
            
           
        }
        .padding(10)
        .foregroundColor(album.background)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(album.color3)
                .shadow(color: .black, radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 10)
    }
}


