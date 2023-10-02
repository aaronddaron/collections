//
//  SortView.swift
//  Collections
//
//  Created by Aaron Geist on 6/26/23.
//

import SwiftUI

struct SortView: View {
    @State var sortBy: String
    @Binding var collectionSort: String
    @State var color = Color.black
    @State var color2 = Color.gray
    @State var image = ""
    @State var symbol = ""
    
    var body: some View {
        HStack{
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Text(sortBy)
                .font(.title2)
            Spacer()
            Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
        }
        .padding()
        .onChange(of: collectionSort, perform: { newValue in
            if sortBy == collectionSort{
                image = "checkmark"
                color = Color.white
            } else {
                image = ""
                color = Color.black
            }
        })
        .onAppear{
            print("sortBy")
            if sortBy == collectionSort{
                image = "checkmark"
                color = Color.white
                color2 = Color.white
            }
            switch sortBy{
            case "Date":
                symbol = "calendar.circle"
            case "Artist":
                symbol = "person.circle"
            case "Title":
                symbol = "pencil.circle"
            case "Rating":
                symbol = "star"
            default:
                symbol = ""
            }
        }
        .onChange(of: collectionSort, perform: { newValue in
            if sortBy == collectionSort{
                color2 = Color.white
            } else {
                color2 = Color.gray
            }
        })
        .foregroundColor(color)
        .background(
            Rectangle()
                .fill(color2)
                .opacity(0.1)
        )
        
    }
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView(sortBy: "Artist", collectionSort: .constant("Artist"))
    }
}
