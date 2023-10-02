//
//  Album.swift
//  Collections
//
//  Created by Aaron Geist on 6/22/23.
//

import Foundation
import MusicKit
import SwiftUI

struct LP: Hashable, Decodable, Encodable{
    var title: String
    //var duration: Int
    var date: Date
    var artist: String
    var cover: Artwork?
    var manualCover: Data?
    var id: MusicItemID
    var rating: Int
    var tags: [String]
    var genres: [String]
    var sortGenre: String
    var sortArtist: String
   
    init(title: String, date: Date, artist: String, cover: Artwork? = nil, id: MusicItemID, manualCover: Data = Data(), rating: Int = 0, tags: [String] = [], genres: [String] = []) {
        self.title = title
        self.date = date
        self.artist = artist
        self.cover = cover
        self.manualCover = manualCover
        self.id = id
        self.rating = rating
        self.tags = tags
        self.genres = []
        self.sortArtist = artist
        
        
        for genre in genres{
            if genre != "Music" && !genres.contains(where: {$0.contains(genre) && $0 != genre}){
                self.genres.append(genre)
            }
        }
        
        
        if genres.count > 0{
            self.sortGenre = genres[0]
        } else {
            self.sortGenre = "None"
        }
        
    }
    
    mutating func setRating(stars: [String]){
        var newRating = 0
        for i in 0..<5 {
            if stars[i] == "star.fill" {
                newRating+=1
            }
        }
        if rating != newRating{
            rating = newRating
        }
    }
    
    func getRating() -> [String] {
        var stars = ["star", "star", "star", "star", "star"]
        for i in 0..<rating {
            stars[i] = "star.fill"
        }
        return stars
    }

    
}

struct DetailedAlbum {
    var title: String
    var date: Date
    var artist: String
    var cover: URL?
    var manualCover: Data?
    var background: Color
    var text: Color
    var button: Color
    var color3: Color
    var color4: Color
    var id: MusicItemID
    var rating: Int
    var genres: [String]
    var tags: [String]
    var sortGenre: String
    
    init(item: LP = LP(title: "", date: Date(), artist: "", id: "")) {
        self.title = item.title
        self.date = item.date
        self.artist = item.artist
        self.cover = item.cover?.url(width: 300, height: 300)
        self.manualCover = item.manualCover
        self.background = Color(UIColor(cgColor: item.cover?.backgroundColor ?? UIColor.gray.cgColor))
        self.text = Color(UIColor(cgColor: item.cover?.primaryTextColor ?? UIColor.black.cgColor))
        self.button = Color(UIColor(cgColor: item.cover?.secondaryTextColor ?? UIColor.white.cgColor))
        self.color3 = Color(UIColor(cgColor: item.cover?.tertiaryTextColor ?? UIColor.gray.cgColor))
        self.color4 = Color(UIColor(cgColor: item.cover?.quaternaryTextColor ?? UIColor.gray.cgColor))
        self.id = item.id
        self.rating = item.rating
        self.genres = item.genres
        self.tags = item.tags
        self.sortGenre = item.sortGenre
        
    }

    func getRating() -> [String] {
        var stars = ["star", "star", "star", "star", "star"]
        for i in 0..<rating {
            stars[i] = "star.fill"
        }
        return stars
    }
    
}

