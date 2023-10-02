//
//  CreateGenreView.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import SwiftUI

struct CreateGenreView: View {
    @Binding var genres: [String]
    @Binding var color: Color
    @Binding var show: Bool
    
    @State private var newGenre = ""
    @State private var showPlus = false
    @FocusState private var focused: Bool
    
    var body: some View {
        VStack{
            HStack{
                TextField("", text: $newGenre)
                    .focused($focused) //Focus keyboard onAppear
                    .task {
                      withAnimation{
                          focused = true
                      }
                    }
                    .placeholder(when: newGenre.isEmpty) {
                        Text("New Genre").foregroundColor(color)
                            .opacity(0.5)
                    }
                    .onChange(of: newGenre) { newValue in //If user has entered something allow them to add it by revealing +
                        withAnimation{
                            if newGenre.isEmpty {
                                showPlus = false
                            } else {
                                showPlus = true
                            }
                        }
                    }
                if showPlus {
                    Image(systemName: "plus")
                        .onTapGesture {
                            
                            newGenre = newGenre.upperFirstOnly
                            print(newGenre)
                            
                            if !genres.contains(newGenre){ //If genre is not already applied add it and close view
                                
                                genres.append(newGenre)
                                show.toggle()
                            } else { //Else tell user error has occurred
                                vibration.notificationOccurred(.error)
                            }
                        }
                        .foregroundColor(color)
                }
            }
            .padding([.top, .horizontal])
        }
        .onChange(of: show) { newValue in //When show, focused; when !show !focused
           
                focused.toggle()
            
        }
    }
}

