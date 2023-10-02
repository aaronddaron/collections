//
//  Shared.swift
//  Collections
//
//  Created by Aaron Geist on 7/6/23.
//

import Foundation
import SwiftUI
import MusicKit

//Var
public let vibration = UINotificationFeedbackGenerator()
public let resign = #selector(UIResponder.resignFirstResponder)
public let dateFormatter = DateFormatter()
public let durationFormatter = DateComponentsFormatter()

//Functions
public func setDateStyle(){
    dateFormatter.dateStyle = .long
}

public func setDuration(){
    durationFormatter.unitsStyle = .abbreviated
    durationFormatter.zeroFormattingBehavior = .dropAll
    durationFormatter.allowedUnits = [ .hour, .minute, .second]
}


//Extensions

//From https://stackoverflow.com/questions/57688242/swiftui-how-to-change-the-placeholder-color-of-the-textfield
extension View {
    public func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    
    //Creates pill like background for a view with a given text and background color
    public func pill(text: Color = Color.black,  background: Color = Color.white) -> some View {
        return foregroundColor(text)
        .padding(5).padding(.horizontal, 5)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(background)
        )
    }
    
}


extension Array where Element == LP{
    func ratingSort(asc: Bool) -> [LP]{
        var items = self
        if asc {
            items.sort{ $0.rating < $1.rating }
        } else {
            items.sort{ $0.rating > $1.rating }
        }
        
        return items
    }
    
    func ratingInsert(add: LP, asc: Bool) -> [LP]{
        var items = self
            var i = -1
            if items.count > 0{
                if asc {
                    i = items.firstIndex{
                        $0.rating > add.rating
                    } ?? -1
                } else {
                    i = items.firstIndex{
                        $0.rating < add.rating
                    } ?? -1
                }
                if i > -1 {
                    items.insert(add, at: i)
                } else {
                    items.append(add)
                }
            } else {
                items.append(add)
            }
        return items
            
    }
    
    func titleSort(asc: Bool) -> [LP] {
        var items = self
        if asc {
            items.sort{ $0.title < $1.title }
        } else {
            items.sort{ $0.title > $1.title }
        }
        return items
        
    }
    
    func titleInsert(add: LP, asc: Bool) -> [LP]{
        var items = self
            var i = -1
            if items.count > 0{
                if asc {
                    i = items.firstIndex{
                        $0.title > add.title
                    } ?? -1
                } else {
                    i = items.firstIndex{
                        $0.title < add.title
                    } ?? -1
                }
                if i > -1 {
                    items.insert(add, at: i)
                } else {
                    items.append(add)
                }
            } else {
                items.append(add)
            }
        return items
            
    }
    
    func dateInsert(add: LP, asc: Bool) -> [LP]{
        var items = self
            var i = -1
            if items.count > 0{
                if asc {
                    i = items.firstIndex{
                        $0.date > add.date
                    } ?? -1
                } else {
                    i = items.firstIndex{
                        $0.date < add.date
                    } ?? -1
                }
                if i > -1 {
                    items.insert(add, at: i)
                } else {
                    items.append(add)
                }
            } else {
                items.append(add)
            }
        return items

    }
    
    func dateSort(asc: Bool) -> [LP]{
        var items = self
        if asc {
            items.sort{
                $0.date < $1.date
            }
        } else {
            items.sort{
                $0.date > $1.date
            }
        }
        return items
    }

    func artistInsert(add: LP, asc: Bool) -> [LP]{
        
        var items = self
        
        let newArtist = add.artist.removeThe

            if items.count > 0{
                let index = items.firstIndex {
                    
                    let existingArtist = $0.artist.removeThe
                    
                    if existingArtist == newArtist && $0.date > add.date {
                        return true
                    } else {
                        return false
                    }
                    
                }  ?? -1
                if index >= 0 {
                    
                    items.insert(add, at: index)
                    
                } else { //No albums by that artist have been added yet
                    let index = items.firstIndex {
                        
                        let existingArtist = $0.artist.removeThe
                        
                        if asc {
                            if existingArtist > newArtist {
                                return true
                            } else {
                                return false
                            }
                        } else {
                            if existingArtist < newArtist {
                                return true
                            } else {
                                return false
                            }
                        }
                        
                        
                    } ?? -1
                    if index >= 0 {
                        items.insert(add, at: index)
                    } else { //Album artist is > than all other artist
                        items.append(add)
                    }
                }
            } else {
                items.append(add)
            }
        return items

    }
    
    func artistSortAsc() -> [LP]{
        var items = self
        var temp = [LP]()
        items.sort{ $0.date < $1.date}
        while items.count > 0 {
            let min = items.min {a, b in
                let artist2 = b.artist.removeThe
                
                let artist1 = a.artist.removeThe
                
                if artist1 < artist2 {
                    return true
                } else {
                    return false
                }
                
            }!
            
            let index = items.firstIndex(of: min) ?? 0
            items.remove(at: index)
            
            temp.append(min)
        }
        return temp
    }
    
    func artistSortDesc() -> [LP]{
        var items = self
        var temp = [LP]()
        items.sort{ $0.date < $1.date}
        while items.count > 0 {
            let max = items.max {a, b in
                let artist2 = b.artist.removeThe
                
                let artist1 = a.artist.removeThe
                
                if artist1 < artist2 {
                    return true
                } else {
                    return false
                }
                
            }!
            
            let index = items.firstIndex(of: max) ?? 0
            items.remove(at: index)
            
            temp.append(max)
        }
        return temp
        
    }
}


struct SearchBar: View {
    let message: String
    @Binding var searchTerm: String
    var body: some View {
        HStack{
            
            TextField("", text: $searchTerm)
                .foregroundColor(.black)
                .placeholder(when: searchTerm.isEmpty) {
                    Text(message).foregroundColor(.black)
                        .opacity(0.5)
                }
            Spacer()
            Image(systemName: "x.circle.fill")
                .foregroundColor(.black)
                .onTapGesture {
                    withAnimation{
                        searchTerm = ""
                    }
                }
        }
        .padding()
        .padding(.horizontal, 5)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(.white)
                .shadow(color: .black, radius: 10, x: 0, y: 5)
            .frame(height: 30)
            .padding()
            
        )
    }
    
}

struct InputBar: View {
    let message: String
    @Binding var input: String
    var body: some View{
        HStack{
            TextField("", text: $input)
                .foregroundColor(.black)
                .placeholder(when: input.isEmpty) {
                    Text(message).foregroundColor(.black)
                        .opacity(0.5)
                }

            Spacer()
            Image(systemName: "x.circle.fill")
                .foregroundColor(.black)
                .onTapGesture {
                    withAnimation{
                        input = ""
                    }
                }
        }
    }
}

struct Division: View {
    @Binding var text: String
    
    var body: some View {
        
        if text != ""{
            HStack{
                Text(text)
                Spacer()
            }
            .padding(.leading)
            .padding(.vertical, 0)
        }
    }
}


extension String {
    
    public var toLowerOnlyLetters: String{
        let lower = self.lowercased() //Make lowercased
        var onlyLetters = ""
        for char in lower{ //Iterate through and kepp just letters
            if char.isLetter {
                onlyLetters += [char]
            }
        }
        return onlyLetters
    }
    
    public var upperFirstOnly: String{
        let noWhitespace = self.trimmingCharacters(in: .whitespacesAndNewlines) //Trim whitespace from front and back
        let prefix = noWhitespace.prefix(1).uppercased() //Get first letter from trimmed string and make uppercase
        let final = prefix + noWhitespace.dropFirst() //Drop first char of trimmed string and add capped first letter
        return final
    }
    
    public var removeThe: String{
        let prefix = self.prefix(4)
        if prefix == "The " || prefix == "the " {
            return String(self.dropFirst(4))
        } else {
            return self
        }
    }
    
}



