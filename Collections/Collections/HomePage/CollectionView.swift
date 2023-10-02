//
//  CollectionView.swift
//  Collections
//
//  Created by Aaron Geist on 7/3/23.
//

import SwiftUI
import MusicKit

struct CollectionView: View {
    @State var key: String
    @Binding var user: User
    @State var collection = Collection()
    @State var covers = [LP]()
 
    var body: some View {
        HStack(alignment: .top){
            HStack(spacing: 0){
                if collection.items.count >= 4
                {
                    VStack(spacing: 0){
                        CoverView(item: covers[0])
                        CoverView(item: covers[1])
                    }
                    VStack(spacing: 0){
                        CoverView(item: covers[2])
                        CoverView(item: covers[3])
                    }
                } else if collection.items.count >= 1 {
                    
                    CoverView(item: collection.items[0])
                        
                } else {
                   
                    Rectangle()
                        .fill(.white)
                        .frame(width: 150, height: 150)
                    
                }
                            
            }
            
            VStack(alignment: .leading){
                Text(key)
                    .font(.title)
                Text("\(collection.items.count)")
                    .font(.caption)
            }
            .padding(.leading, 10)
            

            Spacer()
            Image(systemName: "chevron.right")
                .font(.title3)
            
        }
        .padding()
        .onAppear{
            let value = user.types[key] ?? ""
            print("\(value) - \(key)")
            
            collection.load(key: value)
//            collection.id = value
//            collection.type = key
//            collection.tags = ["Vintage", "New", "Used", "Double LP", "Grandpa", "Caroline"]

//            collection.save()
            if collection.items.count > 0{
                getCovers()
            }
            
            print(collection.items)
            
        }
            
    }
    
    private func getCovers() {
        for _ in 0..<4{
            var random = collection.items.randomElement()!
            while covers.contains(where: {$0.id == random.id}){
                random = collection.items.randomElement() ?? LP(title: "", date: Date(), artist: "", id: "")
            }
            covers.append(random)
        }
        
        for cover in covers {
            print(cover.title, cover.tags)
        }
        
    }
    
}


