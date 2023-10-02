//
//  CollectionStarsView.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import SwiftUI

struct CollectionStarsView: View {
    @State var item: LP
    @State private var stars = [String]()
    var body: some View {
        HStack(spacing: 0){
            ForEach(stars, id: \.self) { star in
                Image(systemName: star)
            }
        }
        .onAppear{
            stars = item.getRating()
        }
    }
}

