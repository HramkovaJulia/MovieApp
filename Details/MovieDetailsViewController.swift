//
//  MovieDetailsViewController.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 12.01.2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private let movieId: Int

    private let alamofireService: AlamofireNetworkService
    private var movieDetails: MovieDetailsResponse?
    
    private var cast: [Actors] = []

    init(movieId: Int, detailsService: AlamofireNetworkService){
        self.movieId = movieId
        self.alamofireService = detailsService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
        alamofireService.getMovieDetails(
            with: movieId,
            completion: { [weak self] MovieDetailsResponse in
                self?.movieDetails = MovieDetailsResponse
                self?.tableView.reloadData()
            }
        )
        alamofireService.getMovieCredits(
            with: movieId,
            completion: { [weak self] Actors in
                self?.cast = Actors
                self?.tableView.reloadData()
            }
        )
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
            if let movieDetails = movieDetails {
                cell.setResours(movie: movieDetails)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.identifier, for: indexPath) as! MovieDetailsTableViewCell
            cell.config(cast: cast)
            cell.didSelectCast = { id in
                let castViewController = CastMemberViewController(castId: id, alamofireService: AlamofireNetworkService.shared)
                self.navigationController?.pushViewController(castViewController, animated: true)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}









