//
//  FilterView.swift
//  Collections
//
//  Created by Aaron Geist on 7/7/23.
//

import SwiftUI

struct FilterView: View {
    @Binding var collection: Collection
    @Binding var parameters: ParameterSet
    @State var title = ""
//    @State var name = ""
//    @State var genre = ""
    @State var year = ""
    @State private var tagsFilter = false
    @State private var ratingMessage = "Rating Filter"
    @State private var tagsMessage = "Tag Filters"
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                Text("Filter(s)")
                Text("Hit \"return\" after typing, to add filter")
            }
            .padding()
            
            
            
            VStack(alignment: .leading, spacing: 15){
                
                
                HStack{
                    InputBar(message: "Title Filter", input: $title)
                        .onSubmit {
                            withAnimation{
                                parameters.title = title
                                title = ""
                            }
                        }
                }
                
                if !parameters.title.isEmpty{
                    Text("\(parameters.title) x")
                        .pill(text: .white, background: .black)
                        .onTapGesture {
                            withAnimation{
                                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                                parameters.title = ""
                            }
                        }
                }
                
                FilterArtistsView(parameters: $parameters)
                
                FilterGenresView(parameters: $parameters)
                
                
                InputBar(message: "Year Filter", input: $year)
                    .onSubmit {
                        withAnimation{
                            parameters.year = year
                        }
                        year = ""
                    }
                
                if !parameters.year.isEmpty{
                    HStack{
                        EqualityView(equality: $parameters.yearEquality)
                        
                        Text("\(parameters.year) x")
                            .pill(text: .white, background: .black)
                            .onTapGesture {
                                withAnimation{
                                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                                    parameters.year = ""
                                }
                            }
                    }
                }
                
                Text(ratingMessage)
                    .pill(text: .white, background: .black)
                    .onTapGesture {
                        withAnimation{
                            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                            if parameters.rating > -1 {
                                parameters.rating = -1
                                ratingMessage = "Rating Filter"
                                
                            } else {
                                parameters.rating = 0
                                ratingMessage = "Clear Rating Filter"
                            }
                        }

                    }
                        
            
                if parameters.rating > -1{
                    HStack{
                        EqualityView(equality: $parameters.ratingEquality)
                            
                        FilterStars(rating: $parameters.rating)
                            .font(.title)
                    }
                }
            
                
                Text(tagsMessage)
                    .pill(text: .white, background: .black)
                    .onTapGesture {
                        withAnimation{
                            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                            if tagsFilter {
                                parameters.tags.removeAll()
                                tagsMessage = "Tag Filters"
                            } else {
                                tagsMessage = "Clear Tag Filters"
                            }
                            tagsFilter.toggle()
                        }
                        
                    }
                if tagsFilter{
                    TagsView(collectionTags: collection.tags, tags: $parameters.tags)
                }
                
                
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
            Spacer()
        }
        .font(.title2)
        .onTapGesture {
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }

    }
}


