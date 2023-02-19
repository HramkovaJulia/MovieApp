//
//  AllMovieTableViewCell.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 15.01.2023.
//

import UIKit
import Kingfisher

class AllMovieTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
        
        contentView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let movieListImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var dateMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    let aboutMovieStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5

        return stack
    }()
    
    var nameMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    var ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var starRating: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.textColor = .white
        return label
    }()
    
    func addSubviews(){
        contentView.addSubview(movieListImage)
        contentView.addSubview(ratingView)
        ratingView.addSubview(starRating)
        contentView.addSubview(aboutMovieStackView)
        aboutMovieStackView.addArrangedSubview(nameMovieLabel)
        aboutMovieStackView.addArrangedSubview(dateMovieLabel)
        
    }
    
    func setConstraints(){
        starRating.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(ratingView.snp.top).offset(16)
            make.left.equalTo(ratingView.snp.left).offset(16)
            make.width.equalTo(39)
            make.height.equalTo(20)
        }
        
        ratingView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(movieListImage)
            make.bottom.equalTo(movieListImage)
            make.left.equalTo(movieListImage)
            make.right.equalTo(movieListImage)
        }
        movieListImage.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
            make.left.equalTo(contentView.snp.left).offset(30)
            make.right.equalTo(contentView.snp.right).offset(-30)
        }
        aboutMovieStackView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(ratingView.snp.centerX)
            make.centerY.equalTo(ratingView.snp.centerY)
            
        }
    }
    
    public func configCell(movie: Movie) {
        if let movie = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(movie)")
            movieListImage.kf.setImage(with: url)
        }
        nameMovieLabel.text = movie.originalTitle
        dateMovieLabel.text = movie.releaseDate
        starRating.text = "★ \(movie.voteAverage) "
        if Double(movie.voteAverage) <= 7 {
            starRating.backgroundColor = .orange
        } else {
            starRating.backgroundColor = .systemGreen
        }
    }
    
    
    
    
    
}

