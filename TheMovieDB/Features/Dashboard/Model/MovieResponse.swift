//
//  MovieResponse.swift
//  GMTest
//
//  Created by Thomas Woodfin on 11/6/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieResponse: Mappable{
    
    var movieList: [Movie]?
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        movieList <- map["results"]
    }
}

struct Movie: Mappable{
    
    var popularity: Double?
    
    var vote_count: Double?
    var video: Bool?
    var poster_path: String?
    var id: Int?
    var adult: Bool?
    
    var backdrop_path: String?
    var original_language: String?
    var original_title: String?
    var title: String?
    
    var vote_average: Double?
    var overview: String?
    var release_date: String?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        popularity <- map["popularity"]
        vote_count <- map["vote_count"]
        video <- map["video"]
        poster_path <- map["poster_path"]
        id <- map["id"]
        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        title <- map["title"]
        vote_average <- map["vote_average"]
        overview <- map["overview"]
        release_date <- map["release_date"]
    }
}
