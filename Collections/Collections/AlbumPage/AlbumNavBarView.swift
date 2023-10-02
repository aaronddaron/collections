//
//  AlbumNavBarView.swift
//  Collections
//
//  Created by Aaron Geist on 6/29/23.
//

import SwiftUI

struct AlbumNavBarView: View {
    @Binding var album: DetailedAlbum
    @Binding var collection: Collection
    @Binding var opacity: Double
    @Binding var offset: CGFloat
    @Binding var editing: Bool
    
    @State private var editText = "edit"
    
    var body: some View {
        HStack{
            Image(systemName: "chevron.down")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    if !editing{
                        withAnimation(.easeOut){
                            offset = 1000
                            opacity = 0.0
                            
                        }
                    }
                }
            Text(album.title)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(.caption)
            Spacer()
            Image(systemName: "trash")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    print("tapped")
                    withAnimation{
                        if !editing{
                            withAnimation(.easeOut){
                                offset = 1000
                                opacity = 0.0
                                collection.delete(item: collection.items[collection.find(album: album)])
                            }
                            
                        }
                    }
                }
                .padding(.leading)
            Image(systemName: "line.3.horizontal")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .onTapGesture {
                    print("tapped")
                    withAnimation{
                        editing = true
                    }
                }
                .padding(.leading)
        }
    }
}


