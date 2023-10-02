//
//  StarsView.swift
//  Collections
//
//  Created by Aaron Geist on 6/28/23.
//

import SwiftUI

struct StarsView: View {
    @Binding var album: DetailedAlbum
    @Binding var stars: [String]
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: stars[0])
                .onTapGesture {
                if stars[0] == "star.fill" && stars[1] == "star"{
                    stars[0] = "star"
                    
                } else {
                    stars[0] = "star.fill"
                    stars[1] = "star"
                    stars[2] = "star"
                    stars[3] = "star"
                    stars[4] = "star"
                    }
                }
            Image(systemName: stars[1])
                .onTapGesture {
                    if stars[1] == "star.fill" && stars[2] == "star" {
                        stars[1] = "star"
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star"
                        stars[3] = "star"
                        stars[4] = "star"
                    }
                }
            Image(systemName: stars[2])
                .onTapGesture {
                    if stars[2] == "star.fill" && stars[3] == "star" {
                        stars[2] = "star"
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star.fill"
                        stars[3] = "star"
                        stars[4] = "star"
                    }
                }
            Image(systemName: stars[3])
                .onTapGesture {
                    if stars[3] == "star.fill" && stars[4] == "star" {
                        stars[3] = "star"
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star.fill"
                        stars[3] = "star.fill"
                        stars[4] = "star"
                    }
                }
            Image(systemName: stars[4])
                .onTapGesture {
                    if stars[4] == "star.fill" {
                        stars[4] = "star"
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star.fill"
                        stars[3] = "star.fill"
                        stars[4] = "star.fill"
                    }
                }
        }
    }
}

