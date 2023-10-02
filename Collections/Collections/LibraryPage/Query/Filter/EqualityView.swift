//
//  EqualityView.swift
//  Collections
//
//  Created by Aaron Geist on 7/7/23.
//

import SwiftUI

struct EqualityView: View {
    @Binding var equality: String
    
    var body: some View {
       
        Text(equality)
            .foregroundColor(.white)
            .padding(5)
            .padding(.horizontal, 5)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
            )
            .onTapGesture {
                if equality == "=" {
                    withAnimation {
                        equality = "<"
                    }
                    
                    
                } else if equality == "<"{
                    withAnimation {
                        equality = "<="
                    }
                    
                    
                } else if equality == "<="{
                    withAnimation {
                        equality = ">"
                    }
                    
                } else if equality == ">"{
                    withAnimation {
                        equality = ">="
                    }
                } else {
                    equality = "="
                }
            }
            
        
    }
}


