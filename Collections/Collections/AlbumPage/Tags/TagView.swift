//
//  TagView.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import SwiftUI

struct TagView: View {
    @Binding var tags: [String]
    @State var tag: String
    @Binding var album: DetailedAlbum
    @State var albumTag: Bool
    @State var symbol = "+"
    @State var color = Color.white
    @State var text = Color.black
    var body: some View {
        
        Text("\(tag) \(symbol)") //Tag name
        .pill(text: text, background: color)
        .padding(.trailing, 5)
        .onTapGesture {
            
            withAnimation {
                if symbol == "+"{ //If tag is being added (+ symbol)
                    tags.append(tag)
                    symbol = "x" //Change symbol to indicate removal and change colors
                    color = album.button
                    text = album.background
                } else { //If tag is being removed (x symbol)
                    tags.removeAll{$0 == tag}
                    symbol = "+" //Change symbol to indicate addition and change colors
                    color = Color.white
                    text = Color.black
                    
                }
                print(tags)

            }
        }
        .onAppear{
            if albumTag{ //If tag is applied to album change symbol to indicate removal, and colors to indicate its applied
                symbol = "x"
                color = album.button
                text = album.background
            } //Else maintain declarations
        }
        .onChange(of: album.id) { newValue in //Update
            if albumTag{
                symbol = "x"
                color = album.button
                text = album.background
            } else { //Reset to original declarations if not applied to album
                symbol = "+"
                color = Color.white
                text = Color.black
            }
        }
    }
}


