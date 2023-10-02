//
//  File.swift
//  Collections
//
//  Created by Aaron Geist on 6/24/23.
//

import Foundation
import MusicKit


struct Collection: Encodable, Decodable, Hashable{
    var items: [LP] = []
    var sortType: String = "Artist"
    var asc: Bool = true
    var type: String = ""
    var id: String = ""
    var wishlist: [LP] = []
    var filtered: [LP] = []
    var tags: [String] = ["Vintage", "New", "Used", "Double LP"]
    var show: Bool = false
    
    mutating func changeSortType(type: String){
        sortType = type
        sort()
        sortType = type
    }
    
    mutating func changeType(type: String){
        self.type = type
        save()
    }
    
    mutating func insert(add: [LP]){
        switch sortType{
        case "Date":
            for item in add{
                items = items.dateInsert(add: item, asc: asc)
                wishlist.removeAll{$0.id == item.id}
            }
        case "Artist":
            for item in add{
                items = items.artistInsert(add: item, asc: asc)
                wishlist.removeAll{$0.id == item.id}
            }
        case "Title":
            for item in add{
                items = items.titleInsert(add: item, asc: asc)
                wishlist.removeAll{$0.id == item.id}
                
            }
        case "Rating":
            for item in add{
                items = items.ratingInsert(add: item, asc: asc)
                wishlist.removeAll{$0.id == item.id}
                
            }
        default:
            for item in add{
                items = items.dateInsert(add: item, asc: asc)
                wishlist.removeAll{$0.id == item.id}
            }
        }
        save()
    }
    
    
    mutating func wishlistInsert(album: LP){
        switch sortType{
        case "Date":
            wishlist = wishlist.dateInsert(add: album, asc: asc)
        case "Artist":
            wishlist = wishlist.artistInsert(add: album, asc: asc)
        case "Title":
            wishlist = wishlist.titleInsert(add: album, asc: asc)
        case "Rating":
            wishlist = wishlist.ratingInsert(add: album, asc: asc)
        default:
            wishlist = wishlist.dateInsert(add: album, asc: asc)
        }
        save()
    }
    
    
    mutating func sort(){
        switch sortType{
        case "Date":
            items = items.dateSort(asc: asc)
            wishlist = wishlist.dateSort(asc: asc)
            if filtered.count > 0 {
                filtered = filtered.dateSort(asc: asc)
            }
        case "Artist":
            if asc{
                items = items.artistSortAsc()
                wishlist = wishlist.artistSortAsc()
                if filtered.count > 0 {
                    filtered = filtered.artistSortAsc()
                }
            } else {
                items = items.artistSortDesc()
                wishlist = wishlist.artistSortDesc()
                if filtered.count > 0 {
                    filtered = filtered.artistSortDesc()
                }
            }
        case "Title":
            items = items.titleSort(asc: asc)
            wishlist = wishlist.titleSort(asc: asc)
            if filtered.count > 0 {
                filtered = filtered.titleSort(asc: asc)
            }
        case "Rating":
            items = items.ratingSort(asc: asc)
            if filtered.count > 0 {
                filtered = filtered.ratingSort(asc: asc)
            }
        default:
            items = items.dateSort(asc: asc)
            wishlist = items.dateSort(asc: asc)
            if filtered.count > 0 {
                filtered = filtered.dateSort(asc: asc)
            }
        }
        save()
        show.toggle()
    }

    
    func save(){
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: id)
        }
    }
    
    mutating func delete(item: LP){
        let index = items.firstIndex(of: item) ?? -1
        
        if index > -1 {
            items.remove(at: index)
        }
        
        save()
    }
    
    mutating func delete(indeces: IndexSet){
        items.remove(atOffsets: indeces)
        
        save()
    }
    
    mutating func clear(){
        items.removeAll()
        save()
    }
    mutating func clearWishlist(){
        wishlist.removeAll()
        save()
    }
    
    mutating func deleteWishlist(indeces: IndexSet){
        wishlist.remove(atOffsets: indeces)
        
        save()
    }
    
    
    mutating func albumsInCollectionBy(name: String) -> [LP] {
        
        return items.filter{$0.artist == name}
    }
    
    func find(album: DetailedAlbum) -> Int{
        let index = items.firstIndex{$0.id == album.id} ?? -1
        return index
    }
    
    func find(lp: LP) -> Int{
        let index = items.firstIndex{$0.id == lp.id} ?? -1
        return index
    }
    
    func findFiltered(album: DetailedAlbum) -> Int{
        let index = filtered.firstIndex{$0.id == album.id} ?? -1
        return index
    }
    
    mutating func changeRating(of: DetailedAlbum, to: [String]) {
        var i = find(album: of)
        if i > -1 {
            items[i].setRating(stars: to)
            
            i = findFiltered(album: of)
            if i > -1 {
                filtered[i].setRating(stars: to)
            }
            
            if sortType == "Rating" {
                sort()
            } else {
                save()
            }
        }
    }
    
    mutating func changeTitle(of: DetailedAlbum, to: String) {
        var i = find(album: of)
        if i > -1 {
            items[i].title = to
            
            i = findFiltered(album: of)
            if i > -1 {
                filtered[i].title = to
            }
            
            if sortType == "Title"{
                sort()
            } else {
                save()
            }
            
        }
    }
    
    mutating func changeArtist(of: DetailedAlbum, to: String) {
        var i = find(album: of)
        if i > -1 {
            items[i].artist = to
            
            i = findFiltered(album: of)
            if i > -1 {
                filtered[i].artist = to
            }
            
            if sortType == "Artist"{
                sort()
            } else {
                save()
            }
        }
        
    }
    
    mutating func changeSortGenre(of: DetailedAlbum, to: String) {
        var i = find(album: of)
        if i > -1 {
            if items[i].sortGenre != to {
                items[i].sortGenre = to
                
                i = findFiltered(album: of)
                if i > -1 {
                    filtered[i].sortGenre = to
                }
            }
            
        }
        save()
    }
    
    mutating func changeGenres(of: DetailedAlbum, to: [String]) {
        var i = find(album: of)
        if i > -1 {
            items[i].genres = to
            
            i = findFiltered(album: of)
            if i > -1 {
                filtered[i].genres = to
            }
        }
        save()
    }
    
    mutating func changeTags(of: DetailedAlbum, to: [String]) {
        var i = find(album: of)
        if i > -1 {
            items[i].tags = to
            
            i = findFiltered(album: of)
            if i > -1 {
                filtered[i].tags = to
            }
            
        }
        
        for tag in to {
            if !self.tags.contains(tag) && tag != "Manual"{
                self.tags.append(tag)
            }
        }
        
        save()
    }
    
    func show(album: LP) -> String {
        let index = find(lp: album)
        switch sortType{
        case "Artist":
            if index == 0 {
                return album.artist
            } else if items[index - 1].artist != album.artist {
                return album.artist
            }
        case "Rating":
            if index == 0 {
                return String(album.rating)
            } else if items[index - 1].rating != album.rating {
                return String(album.rating)
            }
        case "Genre":
            if index == 0 {
                return album.sortGenre
            } else if items[index - 1].sortGenre != album.sortGenre {
                return album.sortGenre
            }
        default:
            let format = DateFormatter()
            format.dateFormat = "yyyy"
            let year = format.string(from: album.date)
            
            if index == 0 {
                return year
            } else {
                let prevYear = format.string(from: items[index - 1].date)
                if prevYear != year {
                    return year
                }
            }
        }
        return ""

    }
    
    mutating func getTags(of: DetailedAlbum) -> [String] {
        let i = find(album: of)
        if i > -1 {
            return items[i].tags
        }
        return []
    }
    
    mutating func load(key: String){
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(Collection.self, from: data) {
                self = decoded
                
            }
        }
    }
    
}
