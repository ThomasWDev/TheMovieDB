//
//  MovieDetailsVC.swift
//  TheMovieDB
//
//  Created by Thomas Woodfin on 11/6/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieReleaseDateLbl: UILabel!
    @IBOutlet weak var movieDetailsLbl: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    private func setData(){
        guard let data = movie else {return}
        let imageName = data.poster_path ?? ""
        let fullImageURL = Constants.imageURL + imageName
        moviePosterImageView.sd_setImage(with: URL(string: fullImageURL), placeholderImage: UIImage(named: "placeholder"))
        movieNameLbl.text = data.title ?? ""
        movieReleaseDateLbl.text = data.release_date ?? ""
        movieDetailsLbl.text = data.overview ?? ""
    }
    

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
