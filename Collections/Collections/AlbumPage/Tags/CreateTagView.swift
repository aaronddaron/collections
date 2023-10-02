//
//  CreateTagView.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import SwiftUI

struct CreateTagView: View {
    @Binding var tags: [String]
    @Binding var color: Color
    @Binding var show: Bool
    @Binding var collection: Collection
    
    @State private var newTag = ""
    @State private var showPlus = false
    @FocusState private var focused: Bool
    
    var body: some View {
        VStack{
            HStack{
                TextField("", text: $newTag)
                    .focused($focused) //On appear focus to keyboard
                    .task {
                      withAnimation{
                          focused = true
                      }
                    }
                    .placeholder(when: newTag.isEmpty) {
                        Text("New Tag").foregroundColor(color)
                            .opacity(0.5)
                    }
                    .onChange(of: newTag) { newValue in //If user enters anything show plus sign
                        withAnimation{
                            if newTag.isEmpty {
                                showPlus = false
                            } else {
                                showPlus = true
                            }
                        }
                    }
                if showPlus {
                    Image(systemName: "plus") //When tapped add new tag
                        .onTapGesture {
                            
                            newTag = newTag.upperFirstOnly //Convert tag so its comparible
                            print(newTag)
                            
                            if !tags.contains(newTag) && newTag != "Manual"{ //Only add if not in tags and isnt "manual"
                                tags.append(newTag)
                                show.toggle() //Close view
                            } else { //Otherwise keep view open and tell user error has occurred
                                vibration.notificationOccurred(.error)
                            }

                        }
                        .foregroundColor(color)
                }
            }
            .padding([.top, .horizontal])
        }
        .onChange(of: show) { newValue in
           
                focused.toggle() //When canceled, focus off keyboard
            
        }
    }
    
    
}
