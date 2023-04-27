//
//  ViewController.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 11.01.2023.
//

import UIKit
import SnapKit

protocol MoviesViewInput: AnyObject {
    func handleObtainedTrendingMovies(movies: [Movie])
    func handleObtainedTodayMovies(movies: [Movie])
    func handleObtainedSoonMovies(movies: [Movie])
    func handleObtainedGenres(genres: [Genre])
}

protocol MoviesViewOutput: AnyObject {
    func didLoadView()
    func didSelectCell(with movieId: Int)
}

class HomeViewController: UIViewController {

    private var networkManager = AlamofireNetworkService.shared

    private var genres: [Genre] = []
    
    var output: MoviesViewOutput?
    
    private var tempContent = [
        Content(headerTitle: "Today at the cinema", movies: []),
        Content(headerTitle: "Soon at the cinema", movies: []),
        Content(headerTitle: "Trending movies", movies: [])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        setupConstraints()
        view.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        output?.didLoadView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableHeaderView")
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifierThird)
        return tableView
    }()
    
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tempContent.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderView") as! TableHeaderView
        headerView.labelForMovie.text = tempContent[section].headerTitle
        headerView.didTapButton = { [weak self] in
            let vc = AllMovieViewController()
            vc.config(movies: (self?.tempContent[0].movies)!)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifierThird, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.config(movies: tempContent[indexPath.section].movies, genres: genres)
        cell.onMovieDidSelect = { [weak self] movie in
            print("WORK")
            self?.output?.didSelectCell(with: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension HomeViewController: MoviesViewInput {
   
    func handleObtainedTrendingMovies(movies: [Movie]) {
        tempContent[0].movies = movies
        self.tableView.reloadData()
    }
    
    func handleObtainedTodayMovies(movies: [Movie]) {
        tempContent[1].movies = movies
        self.tableView.reloadData()
    }
    
    func handleObtainedSoonMovies(movies: [Movie]) {
        tempContent[2].movies = movies
        self.tableView.reloadData()
    }
    
    func handleObtainedGenres(genres: [Genre]) {
        self.genres = genres
        self.tableView.reloadData()
    }
}
