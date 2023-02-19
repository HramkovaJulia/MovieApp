//
//  SoonMovieTableViewCell.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 11.01.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var identifierThird = "TableViewCell"
    
    var didSelectMovie: ((Movie) -> Void)?
    private var movies: [Movie] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    private var genres: [Genre] = []
    
    func config(movies: [Movie], genres: [Genre]){
        self.genres = genres
        self.movies = movies
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        layout.minimumLineSpacing = 6
        let category = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        category.register(CollectionViewCell.self, forCellWithReuseIdentifier: identifierThird)
        
        return category
    }()
    
    func setConstraints(){
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView).offset(6)
            make.right.equalTo(contentView).offset(-6)
        }
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectMovie?(movies[indexPath.row])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  Self.identifierThird, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        
        cell.config(with: movies[indexPath.row], genres: genres)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 121, height: collectionView.frame.height)
    }
}

struct Content {
    let headerTitle: String
    var movies: [Movie]
}


