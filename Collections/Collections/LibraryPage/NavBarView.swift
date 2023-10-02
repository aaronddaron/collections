//
//  NavBarView.swift
//  Collections
//
//  Created by Aaron Geist on 6/29/23.
//

import SwiftUI

struct NavBarView: View {
    @Binding var showingMenu: Bool
    @Binding var showingAdd: Bool
    @Binding var manualAdd: Bool
    @Binding var editing: Bool
    @Binding var wishlist: Bool
    @Binding var offset: CGFloat
    
    @State private var bookmarkImage = "bookmark"
    
    var body: some View {
        
        HStack {
            Image(systemName: bookmarkImage)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    if !wishlist {
                        withAnimation{
                            bookmarkImage = "bookmark.fill"
                            wishlist.toggle()
                        }
                    } else {
                        withAnimation{
                            bookmarkImage = "bookmark"
                            wishlist.toggle()
                        }
                    }
                }
            
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.leading)
                .simultaneousGesture(LongPressGesture().onEnded { _ in
                    if !wishlist{
                        manualAdd.toggle()
                    }
                    print("Long Press")
                    editing = false
                    offset = 1000
                   
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    
                })
                .simultaneousGesture(TapGesture().onEnded {
                    showingAdd.toggle()
                    editing = false
                    offset = 1000
                })
            
            Image(systemName: "line.3.horizontal")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.leading)
                .onTapGesture {
                    withAnimation{
                        showingMenu.toggle()
                        offset = 1000
                    }
                    editing = false
                }
        }
        .onAppear{
            if wishlist {
                bookmarkImage = "bookmark.fill"
            } else {
                bookmarkImage = "bookmark"
            }
        }
        
    }
}

