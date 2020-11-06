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
    
    private var pageCount = 10
    private var pageNo = 1
    private var isDataLoading = false
    
    private lazy var paginationManager: HorizontalPaginationManager = {
        let manager = HorizontalPaginationManager(scrollView: self.clcView)
        manager.delegate = self
        return manager
    }()
    
    private var isDragging: Bool {
        return self.clcView.isDragging
    }
    
    private let viewModel = DashboardVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MOVIEBOX"
        self.clcView.alwaysBounceHorizontal = true
        self.setupPagination()
        getData(pageCount: 0)
    }
    
    private func getData(pageCount: Int){
        viewModel.getMoviesData(pageCount: pageCount) { (success) in
            if success{
                self.viewModel.getPopularMoviesData(isShowLoader: false, pageCount: self.pageNo) { (success) in
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

            print("scrollViewDidEndDragging")
            if ((tblView.contentOffset.y + tblView.frame.size.height) >= tblView.contentSize.height)
            {
                if !isDataLoading{
                    isDataLoading = true
                    self.pageNo = self.pageNo + 1
                    self.viewModel.getPopularMoviesData(isShowLoader: true, pageCount: self.pageNo) { (success) in
                        if success{
                            self.tblView.reloadData()
                        }
                    }

                }
            }


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

extension DashboardVC: HorizontalPaginationManagerDelegate {
    
    private func setupPagination() {
        self.paginationManager.refreshViewColor = .clear
        self.paginationManager.loaderColor = .white
    }
    
    private func fetchItems() {
        self.paginationManager.initialLoad()
    }
    
    func refreshAll(completion: @escaping (Bool) -> Void) {
        delay(2.0) {
            
            self.clcView.reloadData()
            completion(true)
        }
    }
    
    func loadMore(completion: @escaping (Bool) -> Void) {
        delay(2.0) {
            self.getData(pageCount: self.pageCount)
            self.clcView.reloadData()
            self.pageCount += 10
            completion(true)
        }
    }
    
}

public func delay(_ delay: Double, closure: @escaping () -> Void) {
    let deadline = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(
        deadline: deadline,
        execute: closure
    )
}


