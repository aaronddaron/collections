//
//  ArrowsView.swift
//  Collections
//
//  Created by Aaron Geist on 7/1/23.
//

import SwiftUI

struct ArrowsView: View {
    @Binding var collection: Collection
    @Binding var album: DetailedAlbum
    @Binding var editing: Bool
    @Binding var stars: [String]
    
    
    var body: some View {
        
        VStack{
            VStack{
                Image(systemName: "chevron.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        if !editing{
                            
//                            var newRating = 0
//                            for i in 0..<5 {
//                                if stars[i] == "star.fill" {
//                                    newRating+=1
//                                }
//                            }
//                                collection.items[index].rating = newRating
//                                collection.save()
                            withAnimation {
                                collection.changeRating(of: album, to: stars)
                            }
                            
                            
                        
//                            collection.items[index].sortGenre = album.sortGenre
//                            collection.save()
                            withAnimation{
                                collection.changeSortGenre(of: album, to: album.sortGenre)
                            }
                            
                            let index = collection.find(album: album)
                            if index > 0 {
                                let item = collection.items[index - 1]
                                withAnimation{
                                    album = DetailedAlbum(item: item)
                                }
                            } else if index == 0 {
                                let item = collection.items[collection.items.count-1]
                                withAnimation{
                                    album = DetailedAlbum(item: item)
                                }
                            }
                            print(album.sortGenre)
                        }
                    }
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        if !editing {
                            
                            
//                            var newRating = 0
//                            for i in 0..<5 {
//                                if stars[i] == "star.fill" {
//                                    newRating+=1
//                                }
//                            }
//
//                            let index = collection.items.firstIndex{$0.id == album.id} ?? -1
//                            if index > -1 && newRating != album.rating{
//                                collection.items[index].rating = newRating
//                                collection.save()
//                            }
//
//                            collection.items[index].sortGenre = album.sortGenre
//                            collection.save()
//                            print(collection.items[index].sortGenre)
                            withAnimation {
                                collection.changeRating(of: album, to: stars)
                            }
                            withAnimation{
                                collection.changeSortGenre(of: album, to: album.sortGenre)
                            }
                            
                            let index = collection.find(album: album)
                            if index > -1 && index < collection.items.count-1{
                                let item = collection.items[index + 1]
                                withAnimation{
                                    album = DetailedAlbum(item: item)
                                }
                            } else if index == collection.items.count-1{
                                let item = collection.items[0]
                                withAnimation{
                                    album = DetailedAlbum(item: item)
                                }
                            }
                            print(album.sortGenre)
                        }
                        
                    }
                    .offset(y: 100)
                
            }
            .offset(y: 100)
            Spacer()
        }
    }
}

