//
//  TableHeaderView.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 26.01.2023.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    let identifierHeader = "TableHeaderView"
    
    var didTapButton: (() -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewForHeader: UIView = {
        let viewForHeader = UIView()
        return viewForHeader
    }()
    
    let labelForMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let buttonTapped: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" All ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget( nil, action: #selector(openAllMovieButton), for: .touchUpInside)
        return button
    }()
    
    let headerStackView: UIStackView = {
        let headerStackView = UIStackView()
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal
        headerStackView.distribution = .equalSpacing
        headerStackView.spacing = 15
        headerStackView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        headerStackView.clipsToBounds = true
        
        return headerStackView
    }()
    
    @objc func openAllMovieButton(){
        didTapButton?()
    }
    
    func addSubviews(){
        contentView.addSubview(headerStackView)
        headerStackView.addArrangedSubview(labelForMovie)
        headerStackView.addArrangedSubview(buttonTapped)
    }
    
    func setConstraints(){
        headerStackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-6)
            make.left.equalTo(contentView).offset(6)
            make.right.equalTo(contentView).offset(-6)
        }
    }
}
