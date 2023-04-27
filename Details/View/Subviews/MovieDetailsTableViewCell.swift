//
//  MovieDetailsTableViewCell.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 16.01.2023.
//

import UIKit

//protocol CastCellDelegate {
//    func didSelectCast(with castId: Int)
//}

class MovieDetailsTableViewCell: UITableViewCell {
    
    var didSelectCast: ((Int) -> Void)?
    
//    var castCellDelegate: CastCellDelegate?
    
    static var identifier = "cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        let category = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        category.register(MovieDetailsCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        return category
    }()
    
    private var cast: [Actors] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    func config(cast: [Actors]){
        self.cast = cast
    }
    
    func addSubview(){
        contentView.addSubview(castLabel)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func  setConstraints(){
        castLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(6)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView)
            
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(castLabel.snp.bottom)
            make.bottom.equalTo(contentView).offset(-6)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.greaterThanOrEqualTo(170)
        }
    }
}

extension MovieDetailsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        castCellDelegate?.
        didSelectCast?(cast[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 115)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath) as? MovieDetailsCollectionViewCell else {return UICollectionViewCell()}
        cell.configCell(cast: cast[indexPath.item])
        return cell
        
    }
}



