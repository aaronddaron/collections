//
//  PreferencesView.swift
//  Collections
//
//  Created by Aaron Geist on 7/5/23.
//

import SwiftUI

struct PreferencesView: View {
    @Binding var user: User
    var body: some View {
        VStack{
            Toggle(isOn: $user.showDates){
                HStack{
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Show Dates")
                        .font(.title2)
                }
            }
            .tint(.black)
            .onChange(of: user.showDates, perform: { newValue in
                print(user.showDates.description)
                user.save()
            })
            .padding([.top, .horizontal])
            
            
            Toggle(isOn: $user.showRating){
                HStack{
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Show Rating")
                        .font(.title2)
                }
            }
            .tint(.black)
            .onChange(of: user.showRating, perform: { newValue in
                print(user.showDates.description)
                user.save()
            })
            .padding([.top, .horizontal])
        }
        .presentationDetents([.height(250)])
        .presentationDragIndicator(.visible)
        .safeAreaInset(edge: .bottom){}
        .background(.gray.gradient)
    }
}

