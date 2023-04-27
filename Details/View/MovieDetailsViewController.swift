//
//  MovieDetailsViewController.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 12.01.2023.
//

import UIKit

protocol DetailsViewInput: AnyObject {
    func handObtainedDetails(_ details: [MovieDetailsResponse])
    func handObtainedCasts(_ casts: [Actors])
}

protocol DetailsViewOutput: AnyObject {
    func didLoadView()
    func didSelectCell(with: Int)
}

class MovieDetailsViewController: UIViewController {
    
    var output: DetailsViewOutput?
    var onCastDidSelect: ((Int) -> Void)?
    
    private var movieDetails: [MovieDetailsResponse] = []
    private var cast: [Actors] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
        output?.didLoadView()
    }
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        tableView.register(MovieDetailsTableViewCell.self, forCellReuseIdentifier: MovieDetailsTableViewCell.identifier)
        tableView.register(MovieDetailsCell.self, forCellReuseIdentifier: "TableViewCell")
        
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

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return tableView.frame.height/2
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! MovieDetailsCell
            cell.setResours(movie: movieDetails)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.identifier, for: indexPath) as! MovieDetailsTableViewCell
            cell.config(cast: cast)
            cell.didSelectCast = { [weak self] id in
                self?.output?.didSelectCell(with: id)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MovieDetailsViewController: DetailsViewInput {
    func handObtainedCasts(_ casts: [Actors]) {
        self.cast = casts
        self.tableView.reloadData()
    }
    
    func handObtainedDetails(_ details: [MovieDetailsResponse]) {
        self.movieDetails = details
        self.tableView.reloadData()
    }
}






