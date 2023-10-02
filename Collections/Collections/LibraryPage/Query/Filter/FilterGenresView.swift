//
//  FilterGenresView.swift
//  Collections
//
//  Created by Aaron Geist on 7/12/23.
//

import SwiftUI

struct FilterGenresView: View {
    @Binding var parameters: ParameterSet
    @State var genre = ""
    var body: some View {
        HStack {
            if parameters.genres.count > 0 {
                Text("Clear")
                    .pill(text: .white, background: .black)
                    .onTapGesture {
                        withAnimation{
                            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                            parameters.genres.removeAll()
                        }
                    }
            }
            InputBar(message: "Genre Filter", input: $genre)
                .onSubmit {
                    parameters.genres.append(genre)
                    genre = ""
                }
        }
        
        if parameters.genres.count > 0 {
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                
                    ForEach(parameters.genres, id: \.self) { genre in
                        Text("\(genre) x")
                            .pill(text: .white, background: .black)
                            .padding(.trailing, 5)
                            .onTapGesture {
                                withAnimation{
                                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                                    parameters.genres.removeAll{ $0 == genre}
                                }
                            }
                    }
                }
            }
        }
    }
}
