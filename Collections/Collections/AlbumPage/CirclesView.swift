//
//  CirclesView.swift
//  Collections
//
//  Created by Aaron Geist on 6/28/23.
//

import SwiftUI

struct CirclesView: View {
    @Binding var album: DetailedAlbum
    var body: some View {
        VStack{
            
            Circle()
                .fill(album.text)
                .frame(width: 50, height: 50)
            
            Circle()
                .fill(album.button)
                .frame(width: 50, height: 50)
                
            Circle()
                .fill(album.color4)
                .frame(width: 50, height: 50)
            Circle()
                .fill(album.color3)
                .frame(width: 50, height: 50)
//            Circle()
//                .fill(album.background)
//                .frame(width: 50, height: 50)
        }
    }
}

