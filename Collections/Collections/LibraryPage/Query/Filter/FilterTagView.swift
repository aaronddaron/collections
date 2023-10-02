//
//  FilterTagView.swift
//  Collections
//
//  Created by Aaron Geist on 7/7/23.
//

import SwiftUI

struct FilterTagView: View {
    @Binding var tags: [String]
    @Binding var collectionTags: [String]
    @State var tag: String
    @State private var symbol = "+"
    @State private var opacity = 0.5
    var body: some View {
        Text("\(tag) \(symbol)")
            .foregroundColor(.white)
            .padding(5)
            .padding(.horizontal, 5)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
            )
            .padding(.trailing, 5)
            .opacity(opacity)
            .onTapGesture {
                if symbol == "+" {
                    withAnimation{
                        opacity = 1
                        symbol = "x"
                        tags.append(tag)
                    }
                } else {
                    withAnimation{
                        opacity = 0.5
                        symbol = "+"
                        tags.removeAll{$0 == tag}
                    }
                }
            }
            .onChange(of: tags) { newValue in
                if tags == [] {
                    withAnimation{
                        symbol = "+"
                        opacity = 0.5
                    }
                }
                
            }
            .onAppear{
                if tags.contains(tag){
                    withAnimation{
                        symbol = "x"
                        opacity = 1
                    }
                }
            }
    }
}
