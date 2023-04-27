//
//  MovieDetailsCollectionViewCell.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 13.01.2023.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
        
    let actorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var actorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let aboutCastStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
//        stack.distribution = .equalSpacing
//        stack.spacing = 5

        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("lol")
    }
    
    private func setupConstraints() {
        contentView.addSubview(aboutCastStackView)
        aboutCastStackView.addArrangedSubview(actorImage)
        aboutCastStackView.addArrangedSubview(actorName)
        aboutCastStackView.addArrangedSubview(actorLabel)

        aboutCastStackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(6)
            make.left.equalTo(contentView).offset(6)
            make.right.equalTo(contentView).offset(-6)
        }
    }
    
    public func configCell(cast: Actors) {
        if let cast = cast.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(cast)")
            actorImage.kf.setImage(with: url)
        }
        actorName.text = cast.name
        actorLabel.text = cast.knownForDepartment
    }
}

