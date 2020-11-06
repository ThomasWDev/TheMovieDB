//
//  UrlManager.swift
//  TestApp
//
//  Created by Thomas Woodfin on 10/29/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//
import Foundation

#if DEVELOPMENT

let KBasePath = "https://api.themoviedb.org/3/movie" // Staging Server
#else

let KBasePath = "https://api.themoviedb.org/3/movie" // Production Server

#endif

enum OauthPath: String {
    
    case getMovieDataList     = "/now_playing?language=en-US&page="
    case getMoviePopular      = "/popular?api_key=55957fcf3ba81b137f8fc01ac5a31fb5&language=en-US&page="
}
