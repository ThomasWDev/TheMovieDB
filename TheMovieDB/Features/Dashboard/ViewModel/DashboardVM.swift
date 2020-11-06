//
//  DashboardVM.swift
//  GMTest
//
//  Created by Thomas Woodfin Mahmud on 11/3/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import Foundation
import SVProgressHUD
import SwiftyJSON
import ObjectMapper

class DashboardVM{
    
    var movieList: [Movie]?
    var popularMovieList: [Movie]?
    
    func getMoviesData(pageCount: Int, completion: @escaping (_ success: Bool) -> Void){
        SVProgressHUD.show()
        APIClient.shared.objectAPICall(apiEndPoint: GithubDataEndPoint.getMovieDataList(pageCount: pageCount), modelType: MovieResponse.self) { (response) in
            switch response {
            case .success(let value):
                let list = value.movieList
                self.movieList = list?.sorted(by: { (movie1, movie2) -> Bool in
                    return (movie1.popularity ?? 0.0) > (movie2.popularity ?? 0.0)
                })
                completion(true)
            case .failure((let code, let data, let err)):
                SVProgressHUD.dismiss()
                print("code = \(code)")
                print("data = \(String(describing: data))")
                print("error = \(err.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func getPopularMoviesData(isShowLoader: Bool, pageCount: Int, completion: @escaping (_ success: Bool) -> Void){
        if isShowLoader{
            SVProgressHUD.show()
        }
        APIClient.shared.objectAPICall(apiEndPoint: GithubDataEndPoint.getPopularMovie(pageCount: pageCount), modelType: MovieResponse.self) { (response) in
            switch response {
            case .success(let value):
                SVProgressHUD.dismiss()
                let list = value.movieList
                self.popularMovieList = list?.sorted(by: { (movie1, movie2) -> Bool in
                    return (movie1.popularity ?? 0.0) > (movie2.popularity ?? 0.0)
                })
                completion(true)
            case .failure((let code, let data, let err)):
                SVProgressHUD.dismiss()
                print("code = \(code)")
                print("data = \(String(describing: data))")
                print("error = \(err.localizedDescription)")
                completion(false)
            }
        }
    }
    
}
