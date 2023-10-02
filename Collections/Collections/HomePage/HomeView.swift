//
//  HomeView.swift
//  Collections
//
//  Created by Aaron Geist on 7/2/23.
//

import SwiftUI
import MusicKit

struct HomeView: View {
    @State private var user: User = User(showDates: true)
    @State private var opacity = 0.5
    @State private var navigate = false
    @State private var showingPref = false
    @State private var collection = ""
    @State private var types = ["Vinyl", "CDs"]
    
    var body: some View {
        if navigate {
            LibraryView(user: $user, key: collection)
        } else {
            home
        }
    }
    
    var home: some View {
        VStack{
            HStack{
                Text("Collections")
                    .font(.title2)
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .onTapGesture {
                        showingPref.toggle()
                    }
            }
            .padding(.horizontal)
            ScrollView{
                ForEach(types, id: \.self) { type in
                    CollectionView(key: type, user: $user)
                        .background(.gray.gradient)
                        .onTapGesture {
                            collection = type
                            withAnimation{
                                navigate.toggle()
                            }
                        }
                }

            }
        }
        .sheet(isPresented: $showingPref) {
            PreferencesView(user: $user)
        }
        .onAppear{
           
            user.load()
            if user.firstLaunch{
                user.create()
            }
            
//            user.showDates = true
            print(UserDefaults.standard.dictionaryRepresentation().keys)
            print(user)
            
            Task{
                let status = await MusicAuthorization.request()
                switch status{
                case.authorized:
                    user.hasSubscription  = try await !MusicSubscription.current.canBecomeSubscriber
//                    print(user.hasSubscription)
                    
                default:
                    break
                }
            }
            
        }
        .ignoresSafeArea()
        .padding(.vertical, 10)
        .background(.gray.gradient)
        .foregroundColor(.black)
    }
    
    func delete(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
