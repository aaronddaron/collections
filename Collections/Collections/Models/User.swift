//
//  User.swift
//  Collections
//
//  Created by Aaron Geist on 7/1/23.
//

import Foundation

struct User: Encodable, Decodable{
    var firstLaunch: Bool = true
    var showDates: Bool = true
    var showRating: Bool = false
    var hasSubscription: Bool = false
    var types = ["Vinyl":"",
                 "CDs":""  ]
    
    mutating func deleteAll(type: String){
        var collection = Collection()
        let key = types[type] ?? ""
        print(key)
        if !key.isEmpty{
            collection.load(key: key)
            collection.items.removeAll()
            collection.save()
        }
        print(self)
    }
    
    mutating func clear(){
        let typeNames = ["Vinyl", "CDs"]
        UserDefaults.standard.removeObject(forKey: "User")
        for type in typeNames{
            let key = types[type] ?? ""
            UserDefaults.standard.removeObject(forKey: key)
        }
        types.removeAll()
        save()
    }
    
    mutating func create(){
        firstLaunch.toggle()
        let typeNames = ["Vinyl", "CDs"]
        for type in typeNames{
            let key = UUID().uuidString
            types[type] = key
            let collection = Collection(type: type, id: key)
            print(collection)
            collection.save()
        }
        
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "User")
        }
    }
    
    mutating func load(){
        if let data = UserDefaults.standard.data(forKey: "User") {
            if let decoded = try? JSONDecoder().decode(User.self, from: data) {
                self = decoded
            }
        }
    }
}

