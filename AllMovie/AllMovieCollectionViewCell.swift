//
//  AllMovieCollectionViewCell.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 15.01.2023.
//

import UIKit

class AllMovieCollectionViewCell: UICollectionViewCell {

    let styleFilm: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 7
        label.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("lol")
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(styleFilm)
        styleFilm.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left).offset(5)
            make.right.equalTo(contentView.snp_rightMargin).offset(-5)
        }
    }
}
