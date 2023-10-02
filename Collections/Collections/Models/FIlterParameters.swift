//
//  FIlterParameters.swift
//  Collections
//
//  Created by Aaron Geist on 7/7/23.
//

import Foundation

struct ParameterSet {
    var title: String
    var artists: [String]
    var genres: [String]
    var tags: [String]
    var rating: Int
    var ratingEquality: String
    var year: String
    var yearEquality: String // ">", "<", "="
    var format = DateFormatter()
    init(title: String = "", artists: [String] = [], genres: [String] = [], tags: [String] = [], rating: Int = -1, ratingEquality: String = "=", year: String = "", yearEquality: String = "=") {
        self.title = title
        self.artists = artists
        self.genres = genres
        self.tags = tags
        self.rating = rating
        self.ratingEquality = ratingEquality
        self.year = year
        self.yearEquality = yearEquality
        self.format.dateFormat = "yyyy"
    }
    
    func anySet() -> Bool {
        return !title.isEmpty || artists.count > 0 || genres.count > 0 || tags.count > 0 || rating >= 0 || !year.isEmpty
    }
    
    mutating func reset(){
        title = ""
        artists = []
        genres = []
        tags = []
        rating = -1
        ratingEquality = "="
        year = ""
        yearEquality = "="
    }
    
    func isMatch(with: LP) -> Bool {
        
        if !title.isEmpty {
            let withTitle = with.title.lowercased()
            let thisTitle = title.lowercased()
            if !withTitle.contains(thisTitle) {
                return false
            }
            
        }
        
        if artists.count > 0 {
            
            let withArtist = with.artist.toLowerOnlyLetters
            
            for artist in artists{
                
                let parameterArtist = artist.toLowerOnlyLetters
                
                if !withArtist.contains(parameterArtist) {
                    return false
                }
            }
            
        }
        
        if genres.count > 0 {
            
            var withGenres = [String]()
            
            for genre in with.genres {
                withGenres.append(genre.toLowerOnlyLetters)
            }
            
            for genre in genres {
                
                let parameterGenre = genre.toLowerOnlyLetters
                
                if !withGenres.contains(where: {$0.contains(parameterGenre)}) {
                    return false
                }
            }
        }
        
        if tags.count > 0 {
            for tag in tags {
                if !with.tags.contains(tag) {
                    return false
                }
            }
        }
        
        if !year.isEmpty {
            let albumYear = format.string(from: with.date)
            
            print("year - \(yearEquality)")
            switch yearEquality{
            case "=":
                if albumYear != year{
                    return false
                }
            case "<":
                if !(albumYear < year) {
                    return false
                }
            case "<=":
                if !(albumYear <= year) {
                    return false
                }
            case ">":
                if !(albumYear > year) {
                    return false
                }
            
            case ">=":
                if !(albumYear >= year) {
                    return false
                }
            default:
                return false
            }
            
        }
        
        if rating >= 0 {
            
            print("rating - \(ratingEquality)")
            switch ratingEquality{
            case "=":
                if with.rating != rating {
                    return false
                }
            case "<":
                if !(with.rating < rating) {
                    return false
                }
            case "<=":
                if !(with.rating <= rating) {
                    return false
                }
            case ">":
                if !(with.rating > rating) {
                    return false
                }
            
            case ">=":
                if !(with.rating >= rating) {
                    return false
                }
            default:
                return false
            }
            
        }
        
        return true
        
    }
    
}
