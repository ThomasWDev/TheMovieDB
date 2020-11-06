//
//  APIEndPoints.swift
//  TestApp
//
//  Created by Thomas Woodfin on 10/29/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK:- EmployeeData
enum GithubDataEndPoint: Endpoint {
    
    case getMovieDataList(pageCount: Int)
    case getPopularMovie(pageCount: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getMovieDataList, .getPopularMovie:
            return .get
        
        }
    }
    
    var path: String {
        switch self {
        case .getMovieDataList(let pageCount):
            let pageDetails = pageCount == 0 ? "undefined&api_key=55957fcf3ba81b137f8fc01ac5a31fb5" : "\(pageCount)&api_key=55957fcf3ba81b137f8fc01ac5a31fb5"
            return KBasePath + OauthPath.getMovieDataList.rawValue + pageDetails
        case .getPopularMovie(let pageCount):
            return KBasePath + OauthPath.getMoviePopular.rawValue + String(pageCount)
        }
    }
    
    var query: [String: Any]  {
        switch self {
        case .getMovieDataList, .getPopularMovie:
            return [String: Any]()
    
        }
    }
}
