//
//  GenreView.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import SwiftUI

struct GenreView: View {
    @Binding var genres: [String]
    @State var genre: String
    @Binding var album: DetailedAlbum
    @State var symbol = "x" //Symbol will always be "x", no suggestions are made with a + other than add genre which is text input
    @State var color = Color.white
    @State var text = Color.black
    var body: some View {
        Text("\(genre) x")
        .pill(text: text, background: color)
        .padding(.trailing, 5)
        .onTapGesture {
            
            withAnimation {
              
                if genres.count > 1{ //Make sure deletion does not leave genre.count = 0
                    
                    if genre == album.sortGenre { //Check if deleting sortGenre, if so change it to the genre at the first index
                        album.sortGenre = genres[0]
                    }
                    genres.removeAll{ $0 == genre }
                    
                } else { //Else tell user their action is not allowed
                    vibration.notificationOccurred(.error) 
                }
                    
            }
            print(genres)

            
        }
        .onAppear{ //Set pill colors
            color = album.button
            text = album.background
            
        }
        .onChange(of: album.id) { newValue in //Change pill colors when album changes
                color = album.button
                text = album.background
        }
    }
}

