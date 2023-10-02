//
//  AddGenresView.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import SwiftUI

struct AddGenresView: View {
    @Binding var collection: Collection
    @Binding var album: DetailedAlbum
    @Binding var genres: [String]
    @State private var i = -1
    @State private var showingPopup = false
    @State private var prevAlbum = DetailedAlbum()
    var body: some View {
        HStack{
            Image(systemName: "music.note")
                .padding([.leading, .trailing], 5)
                .foregroundColor(album.text)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(genres, id: \.self){ genre in //Display genres
                        GenreView(genres: $genres, genre: genre, album: $album)
                    }
                   
                    Text("Add Genre +")
                    .pill()
                    .padding(.trailing, 5)
                    .onTapGesture { //Display sheet to add genre
                        showingPopup.toggle()
                    }
                    .sheet(isPresented: $showingPopup) { //Sheet to allow user to add a genre
                        CreateGenreView(genres: $genres, color: $album.background, show: $showingPopup)
                            .presentationDetents([.height(25)])
                            .safeAreaInset(edge: .bottom){}
                            .background(album.button)
                            .foregroundColor(album.background)
                    }
                }
            }
        }
        .padding([.leading, .top])
        .onAppear{
            prevAlbum = album //Store album in prevAlbum for onChange and disappear below
            print(genres)
        }
        .onDisappear{
            print(i)
            //Set genres
            if genres != album.genres{
                withAnimation{
                    collection.changeGenres(of: album, to: genres)
                }
            }
            
        }
        .onChange(of: album.id) { newValue in
            print(genres)
            //Save genres to previous album before setting it to new album
            if genres != album.genres{
                withAnimation{
                    collection.changeGenres(of: prevAlbum, to: genres)
                }
            }
            prevAlbum = album            

        }
    }
}

