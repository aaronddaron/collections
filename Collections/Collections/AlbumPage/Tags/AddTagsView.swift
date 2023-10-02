//
//  AddTagsView.swift
//  Collections
//
//  Created by Aaron Geist on 7/5/23.
//

import SwiftUI

struct AddTagsView: View {
    @Binding var collection: Collection
    @Binding var album: DetailedAlbum
    @State private var tags = [String]()
    @State private var i = -1
    @State private var showingPopup = false
    @State private var prevAlbum = DetailedAlbum()
    
    var body: some View {
        HStack{
            Image(systemName: "tag.fill")
                .padding([.leading, .trailing], 5)
                .foregroundColor(album.text)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(tags, id: \.self){ tag in
                        if tag != "Manual"{ //Show all tags except manual
                            TagView(tags: $tags, tag: tag, album: $album, albumTag: true)
                        }
                    }
                    ForEach(collection.tags, id: \.self){ tag in
                        if !tags.contains(tag) { //Show tags in collections tags that are not already applied to the album
                            TagView(tags: $tags, tag: tag, album: $album, albumTag: false)
                        }
                    }
                    Text("Create Tag +") //Option to create and add a tag
                    .pill()
                    .padding(.trailing, 5)
                    .onTapGesture {
                        showingPopup.toggle()
                    }
                    .sheet(isPresented: $showingPopup) { //Popup to type in tag name
                        CreateTagView(tags: $tags, color: $album.background, show: $showingPopup, collection: $collection)
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
            //Get album tags and save the album in prevAlbum
            tags = collection.getTags(of: album)
            prevAlbum = album
        }
        .onDisappear{
            if tags != album.tags{
                withAnimation{
                    collection.changeTags(of: album, to: tags) //Save changes
                }
            }
        }
        .onChange(of: album.id) { newValue in
            
            if tags != album.tags{
                withAnimation{
                    collection.changeTags(of: prevAlbum, to: tags) //Save changes of previous album
                }
            }
            tags = collection.getTags(of: album) //Get new tags
            prevAlbum = album //Set prev album to new album
        }
    }
}

