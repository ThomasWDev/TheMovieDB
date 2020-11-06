//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Thomas Woodfin Mahmud on 11/3/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet weak private var circularProgressView: CircularProgressView!
    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var movieNameLbl: UILabel!
    @IBOutlet weak private var releaseDateLbl: UILabel!
    @IBOutlet weak private var durationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(vm: DashboardVM, index: Int){
        let name = vm.popularMovieList?[index].title ?? ""
        let releaseDate = vm.popularMovieList?[index].release_date ?? ""
        let voteCount = vm.popularMovieList?[index].vote_count ?? 0.0
        let voteAvg = vm.popularMovieList?[index].vote_average ?? 0.0
        
        let imageUrl = vm.popularMovieList?[index].poster_path ?? ""
        
        let fullImageURL = Constants.imageURL + imageUrl
        
        movieNameLbl.text = name
        releaseDateLbl.text = releaseDate
        durationLbl.text = "Vote: \(voteCount)"
   
        movieImageView.sd_setImage(with: URL(string: fullImageURL), placeholderImage: UIImage(named: "placeholder"))
        setCircularPercentage(voteAvg: voteAvg)
    }
    
    private func setCircularPercentage(voteAvg: Double){
        let avg = (voteAvg * 100)/10
        let count = voteAvg/10
        circularProgressView.setProgressWithAnimation(duration: 0.1, value: Float(count))
        
        circularProgressView.trackClr =  UIColor.DeepGreen!
        circularProgressView.progressClr = avg > 50 ? UIColor.systemGreen : UIColor.systemYellow

    }

}
