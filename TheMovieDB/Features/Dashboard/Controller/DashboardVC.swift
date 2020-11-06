//
//  DashboardVC.swift
//  TestProject
//
//  Created by Thomas Woodfin on 10/29/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak private var tblView: UITableView!
    @IBOutlet weak private var clcView: UICollectionView!

    private let viewModel = DashboardVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MOVIEBOX"
        self.clcView.alwaysBounceHorizontal = true
        getData(pageCount: 0)
    }
    
    private func getData(pageCount: Int){
        viewModel.getMoviesData(pageCount: pageCount) { (success) in
            if success{
                self.viewModel.getPopularMoviesData(isShowLoader: false, pageCount: 1) { (success) in
                    if success{
                        self.tblView.reloadData()
                        self.clcView.reloadData()
                    }
                }
                
            }
        }
    }
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.movieList?.count == 0{
            Helper.emptyMessageInTableView(tableView, "No data available")
        }
        return viewModel.popularMovieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.selectionStyle = .none
        cell.configureCell(vm: viewModel, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK:- Need to show Movie Details View code here
    }
        
}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.movieList?.count == 0{
            Helper.emptyMessageInCollectionView(collectionView, "No data available")
        }else{
            collectionView.backgroundView = nil
        }
        return viewModel.movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifire, for: indexPath) as! MoviePosterCell
        cell.configureCell(vm: viewModel, index: indexPath.row)
        return cell
    }
    
    
}



