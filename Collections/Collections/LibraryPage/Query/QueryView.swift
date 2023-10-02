//
//  QueryView.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import SwiftUI

struct QueryView: View {
    @Binding var collection: Collection
    @Binding var filtering: Bool
    @Binding var filtered: [LP]
    @Binding var wishlist: Bool
    @State var searchTerm = ""
    @State var searching = false
    @FocusState private var focused: Bool
    
    @State var showingSort = false
    @State var showingFilter = false
    @State var parameters = ParameterSet()
    
    var body: some View {
        
        HStack{
            Image(systemName: "square.3.layers.3d.middle.filled")
                .padding(.trailing)
                .onTapGesture {
                    showingSort.toggle()
                }
            
               
            if !wishlist{
                Image(systemName: "line.3.horizontal.decrease")
                    .onTapGesture {
                        showingFilter.toggle()
                    }
            }
                
            Spacer()
            
        }
        .font(.title3)
        .sheet(isPresented: $showingSort) {
            SortByView(collection: $collection)
                .foregroundColor(.black)
                .background(.gray.gradient)
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.visible)
                .safeAreaInset(edge: .bottom){}
        }
        .sheet(isPresented: $showingFilter) {
            NavigationStack{
                FilterView(collection: $collection, parameters: $parameters)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Clear"){
                                withAnimation{
                                    parameters.reset()
                                }
                            }
                                .foregroundColor(.white)
                            
                        }
                        
                        
                        ToolbarItem(placement: .confirmationAction){
                            Button("Apply") {
                               
                                print(parameters)
                                if parameters.anySet(){
                                    
                                    withAnimation{
                                        filtering = true
                                        showingFilter.toggle()
                                    
                                    
                                        filtered = collection.items.filter { album in
                                            parameters.isMatch(with: album)
                                        }
                                    }
                                    
                                } else { vibration.notificationOccurred(.error) }
                                
                            }
                            .foregroundColor(.white)
                        }
                        
                    }
                    .foregroundColor(.black)
                    .background(.gray.gradient)
                    .safeAreaInset(edge: .bottom){}
            }
            .presentationDragIndicator(.visible)
        }
       
    }
}


