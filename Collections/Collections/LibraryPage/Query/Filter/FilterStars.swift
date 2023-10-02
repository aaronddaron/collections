//
//  FilterStars.swift
//  Collections
//
//  Created by Aaron Geist on 7/7/23.
//

import SwiftUI

struct FilterStars: View {
    @Binding var rating: Int
    @State var stars = ["star", "star", "star", "star", "star"]
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: stars[0])
                .onTapGesture {
                if stars[0] == "star.fill" && stars[1] == "star"{
                    stars[0] = "star"
                    rating = 0
                    
                } else {
                    stars[0] = "star.fill"
                    stars[1] = "star"
                    stars[2] = "star"
                    stars[3] = "star"
                    stars[4] = "star"
                    rating = 1
                    }
                }
            Image(systemName: stars[1])
                .onTapGesture {
                    if stars[1] == "star.fill" && stars[2] == "star" {
                        stars[1] = "star"
                        rating = 1
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star"
                        stars[3] = "star"
                        stars[4] = "star"
                        rating = 2
                    }
                }
            Image(systemName: stars[2])
                .onTapGesture {
                    if stars[2] == "star.fill" && stars[3] == "star" {
                        stars[2] = "star"
                        rating = 2
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star.fill"
                        stars[3] = "star"
                        stars[4] = "star"
                        rating = 3
                    }
                }
            Image(systemName: stars[3])
                .onTapGesture {
                    if stars[3] == "star.fill" && stars[4] == "star" {
                        stars[3] = "star"
                        rating = 3
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star.fill"
                        stars[3] = "star.fill"
                        stars[4] = "star"
                        rating = 4
                    }
                }
            Image(systemName: stars[4])
                .onTapGesture {
                    if stars[4] == "star.fill" {
                        stars[4] = "star"
                        rating = 4
                    } else {
                        stars[0] = "star.fill"
                        stars[1] = "star.fill"
                        stars[2] = "star.fill"
                        stars[3] = "star.fill"
                        stars[4] = "star.fill"
                        rating = 5
                    }
                }
        }
        .onAppear{
            for i in 0..<rating {
                stars[i] = "star.fill"
            }
        }
    }
    
}

