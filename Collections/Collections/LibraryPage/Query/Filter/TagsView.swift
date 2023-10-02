//
//  TagsView.swift
//  Collections
//
//  Created by Aaron Geist on 7/12/23.
//

import SwiftUI

struct TagsView: View {
    @State var collectionTags: [String]
    @Binding var tags: [String]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(collectionTags, id: \.self) { tag in
                    FilterTagView(tags: $tags, collectionTags: $collectionTags, tag: tag)
                    
                }
            }
        }
        
    }
}

