//
//  AllMovieViewController.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 15.01.2023.
//

import UIKit

class AllMovieViewController: UIViewController {

    private let headerView = AllMovieHeaderView(reuseIdentifier: "AllMovieHeaderView")
   
    static let identifier = "AllMovieTableViewCell"
    
    private var movies: [Movie] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    func config(movies: [Movie]){
        self.movies = movies
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        view.addSubview(tableView)
        tableView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        tableView.tableHeaderView = headerView
        
        tableView.delegate = self
        tableView.dataSource = self
        //сделали запрос
        AlamofireNetworkService.shared.loadGenres { [ weak self ] genres in
            //пришел ответ и мы засетили данные в хедер
            self?.headerView.genres = genres
        }
        
        setupConstraints()
    }
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AllMovieTableViewCell.self, forCellReuseIdentifier: identifier)
        return tableView
    }()
    
    
    private func setupConstraints() {
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
}

extension AllMovieViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    Self.identifier,
                                                 for: indexPath) as! AllMovieTableViewCell
        cell.configCell(movie: movies[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width
    }
}





