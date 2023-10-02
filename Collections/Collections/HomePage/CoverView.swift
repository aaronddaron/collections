//
//  CoverView.swift
//  Collections
//
//  Created by Aaron Geist on 7/12/23.
//

import SwiftUI

struct CoverView: View {
    @State var item: LP
    var body: some View {
        if item.tags.contains("Manual"){
            if let data = item.manualCover, let uiimage = UIImage(data: data){
                Image(uiImage: uiimage)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .cornerRadius(5)
            } else {
                Rectangle()
                    .fill(.white)
                    .frame(width: 150, height: 150)
            }
        } else {
            AsyncImage(url: item.cover?.url(width: 75, height: 75))
        }
    }
}


