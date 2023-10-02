//
//  AlbumEditView.swift
//  Collections
//
//  Created by Aaron Geist on 7/1/23.
//

import SwiftUI

struct AlbumEditView: View {
    @Binding var collection: Collection
    @Binding var album: DetailedAlbum
    @Binding var newName: String
    @Binding var newTitle: String
    @Binding var editing: Bool
    
    @FocusState private var focus1: Bool
    @FocusState private var focus2: Bool
    
    var body: some View {
        VStack{
            TextField(album.title, text: $newTitle)
                .font(.title)
                .focused($focus1)
                  .task {
                    withAnimation{
                        focus1 = true
                    }
                  }
                  .onSubmit {
                      withAnimation{
                          focus2 = true
                      }
                  }
                  .submitLabel(.next)
                
            TextField(album.artist, text: $newName)
                .font(.title2)
                .focused($focus2)
                .onSubmit {
                    withAnimation{
                        editing = false
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Cancel") {
                            withAnimation{
                                focus1 = false
                                focus2 = false
                                editing = false
                            }
                        }
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(album.button))
                        .foregroundColor(album.background)
                        
                        Spacer()
                            
                        Button("Save") {
                            newName = newName.trimmingCharacters(in: .whitespacesAndNewlines)
                            newTitle = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if newName != album.artist{
                                withAnimation{
                                    collection.changeArtist(of: album, to: newName)
                                    album.artist = newName
                                }
                            }
                            
                            if newTitle != album.title {
                                withAnimation {
                                    collection.changeTitle(of: album, to: newTitle)
                                    album.title = newTitle
                                }
                            }

                            withAnimation{
                                focus1 = false
                                focus2 = false
                                editing = false
                            }
                        }
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(album.button))
                        .foregroundColor(album.background)
                        
                    }
                    
                }
                
        
        }
        .padding(10)
            .foregroundColor(album.background)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(album.button)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
            )
            .padding(10)
            .onDisappear{
                    focus1 = false
                    focus2 = false
                
            }
    }
}


