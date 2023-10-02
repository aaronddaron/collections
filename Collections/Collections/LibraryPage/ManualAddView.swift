//
//  ManualAddView.swift
//  Collections
//
//  Created by Aaron Geist on 7/5/23.
//

import PhotosUI
import SwiftUI
import MusicKit

struct ManualAddView: View {
    @Binding var newItem: LP
    @State var photo: [PhotosPickerItem] = []
    @State var data: Data?
    var body: some View {
        VStack{
            if let data = data, let uiimage = UIImage(data: data){
                Image(uiImage: uiimage)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
                    .padding(5)
            }
            VStack(spacing: 20){

                InputBar(message: "Album Title", input: $newItem.title)
                InputBar(message: "Album Artist", input: $newItem.artist)
                InputBar(message: "Album Genre", input: $newItem.sortGenre)
            
                DatePicker(selection: $newItem.date, in: ...Date.now, displayedComponents: .date) {
                        Text("Album Release Date")
                }
                .tint(.gray)
                
                
                HStack(alignment: .top){
                    PhotosPicker(
                        selection: $photo,
                        maxSelectionCount: 1,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        HStack{
                            Text("Upload Cover")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "square.and.arrow.down")
                        }
                    }
                }
                .onChange(of: photo) { newValue in
                    guard let item = photo.first else {
                        return
                    }
                    item.loadTransferable(type: Data.self) { result in
                        switch result{
                        case .success(let data):
                            if let data = data {
                                self.data = data
                                newItem.manualCover = self.data
                                
                            }
                        case .failure(let failure):
                            fatalError("\(failure)")
                        }
                            
                    }
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
            )
            .padding([.horizontal, .bottom])
            Spacer()
        }
        .font(.title2)
        .background(.gray.gradient)
        .onAppear{
            newItem = LP(title: "", date: Date(), artist: "", id: "", genres: [""])
            print(newItem)
        }
    }
}


