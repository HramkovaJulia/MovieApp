//
//  AllMovieHeaderView.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 15.01.2023.
//

import UIKit

class AllMovieHeaderView: UITableViewHeaderFooterView {

    var genres: [Genre] = [] {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    let photoIdent = "photoCell"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(categoryCollectionView)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 0
        let category = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.backgroundColor = #colorLiteral(red: 0.02594686672, green: 0.1197223291, blue: 0.2357809544, alpha: 1)
        category.register(AllMovieCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        
        return category
    }()
    
    private func setupConstraints() {
        categoryCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(50)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
    }
}

extension AllMovieHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? AllMovieCollectionViewCell else {
            return UICollectionViewCell()}
   
        cell.styleFilm.text = genres[indexPath.item].name
        return cell
    }
}

extension AllMovieHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 270, height: 45)
    }
}


