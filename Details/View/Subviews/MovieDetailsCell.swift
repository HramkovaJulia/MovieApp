//
//  MovieDetailsHeader.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 01.02.2023.
//

import UIKit

class MovieDetailsCell: UITableViewCell {

    let identifier = "TableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let aboutMovieStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 15

        return stack
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let dateReleaselLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFit
        image.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return image
    }()
    
    let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func addSubviews(){
        contentView.addSubview(aboutMovieStackView)
        movieImageView.addSubview(ratingLabel)
        aboutMovieStackView.addArrangedSubview(movieImageView)
        aboutMovieStackView.addArrangedSubview(movieNameLabel)
        aboutMovieStackView.addArrangedSubview(dateReleaselLabel)
        aboutMovieStackView.addArrangedSubview(movieDescriptionLabel)
    }
    
    func setConstraints(){
        aboutMovieStackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }
        
        ratingLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(movieImageView.snp.top).offset(10)
            make.left.equalTo(movieImageView.snp.left).offset(50)
        }
    }
    
    func setResours(movie: [MovieDetailsResponse]) {
        guard let movie = movie.first else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w200\(movie.backdropPath)")
        movieImageView.kf.setImage(with: url)
        movieNameLabel.text = movie.title
        dateReleaselLabel.text = movie.releaseDate
        movieDescriptionLabel.text = movie.overview
        ratingLabel.text = " ★ \(movie.voteAverage) "
        if Double(movie.voteAverage) <= 7 {
            ratingLabel.backgroundColor = .orange
        } else {
            ratingLabel.backgroundColor = .systemGreen
        }
    }
}
