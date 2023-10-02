//
//  FilterArtistsView.swift
//  Collections
//
//  Created by Aaron Geist on 7/12/23.
//

import SwiftUI

struct FilterArtistsView: View {
    @Binding var parameters: ParameterSet
    @State var name = ""
    var body: some View {
        HStack{
            if parameters.artists.count > 0 {
                Text("Clear")
                    .pill(text: .white, background: .black)
                    .onTapGesture {
                        withAnimation{
                            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                            parameters.artists.removeAll()
                        }
                    }
            }
            InputBar(message: "Artist Filter", input: $name)
                .onSubmit {
                    withAnimation{
                        parameters.artists.append(name)
                        name = ""
                    }
                }
        }
        if parameters.artists.count > 0{
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                
                    ForEach(parameters.artists, id: \.self) { artist in
                        Text("\(artist) x")
                            .pill(text: .white, background: .black)
                            .padding(.trailing, 5)
                            .onTapGesture {
                                withAnimation{
                                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                                    parameters.artists.removeAll{ $0 == artist }
                                }
                            }
                    }
                }
            }
        }
    }
}
