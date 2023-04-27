//
//  SoonCinemaCollectionViewCell.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 12.01.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        contentView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("lol")
    }
    
    var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    var forRatingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 10
        return label
    }()
    
    let categoryMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 10
        return label
    }()
    
    let aboutMovieStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 2

        return stack
    }()
    
    let starRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    func addSubviews() {
        contentView.addSubview(movieImage)
        contentView.addSubview(aboutMovieStackView)
        aboutMovieStackView.addArrangedSubview(nameMovieLabel)
        aboutMovieStackView.addArrangedSubview(categoryMovieLabel)
        
        contentView.addSubview(forRatingView)
        forRatingView.addSubview(starRating)
    }
    
    func setupConstraints(){
        movieImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.equalTo(contentView.frame.height/1.5)
        }
        
        aboutMovieStackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(movieImage.snp.bottom).offset(6)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
        
        forRatingView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(movieImage.snp.top).offset(8)
            make.left.equalTo(contentView).offset(10)
            make.height.equalTo(13)
            make.width.equalTo(37)
        }
    }
    
    func config(with movie: Movie, genres: [Genre]){
        if let movie = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(movie)" )
            movieImage.kf.setImage(with: url)
        }
        nameMovieLabel.text = movie.originalTitle
        categoryMovieLabel.text = getGenres(by: movie.genderIds, genres: genres)
        starRating.text = " ★\(movie.voteAverage) "
        if Double(movie.voteAverage) <= 7 {
            forRatingView.backgroundColor = .orange
        } else {
            forRatingView.backgroundColor = .systemGreen
        }
    }
    
    func getGenres(by ids: [Int], genres: [Genre]) -> String? {
        var array: [String] = []
        for id in ids {
            array.append(genres.first {$0.id == id}?.name ?? "")
        }
        return array.joined(separator: ", ")
    }
}

