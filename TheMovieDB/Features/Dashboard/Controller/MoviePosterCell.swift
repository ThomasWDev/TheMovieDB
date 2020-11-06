//
//  MoviePosterCell.swift
//  GMTest
//
//  Created by Thomas Woodfin on 11/6/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import UIKit
import SDWebImage

class MoviePosterCell: UICollectionViewCell {
    
    static let identifire = "MoviePosterCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configureCell(vm: DashboardVM, index: Int){
        let imageName = vm.movieList?[index].poster_path ?? ""
        let fullImageURL = Constants.imageURL + imageName
        posterImageView.sd_setImage(with: URL(string: fullImageURL), placeholderImage: UIImage(named: "placeholder"))
        
    }
    
}
