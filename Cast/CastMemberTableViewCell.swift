//
//  CastMemberTableViewCell.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 13.01.2023.
//

import UIKit

class CastMemberTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
        contentView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let actorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Name"
        return label
    }()
    
    let actorBithdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Birthday"
        return label
    }()
    
    let actorDepartmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Department"
        return label
    }()
    
    let actorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let actorBithday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    var actorDepartment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    var actorPhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    let actorBiographyDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let actorBiographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = "Biography"
        return label
    }()
    
    let aboutActorStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 5
        
        return stack
    }()
    
    let aboutActorFullStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    func addSubviews(){
        contentView.addSubview(aboutActorStackView)
        aboutActorStackView.addArrangedSubview(actorNameLabel)
        aboutActorStackView.addArrangedSubview(actorName)
        aboutActorStackView.addArrangedSubview(actorBithdayLabel)
        aboutActorStackView.addArrangedSubview(actorBithday)
        aboutActorStackView.addArrangedSubview(actorDepartmentLabel)
        aboutActorStackView.addArrangedSubview(actorDepartment)
        contentView.addSubview(aboutActorFullStackView)
        aboutActorFullStackView.addArrangedSubview(actorPhotoImage)
        aboutActorFullStackView.addArrangedSubview(aboutActorStackView)
        contentView.addSubview(actorBiographyLabel)
        contentView.addSubview(actorBiographyDescription)
    }
    
    func setConstraints(){
        aboutActorFullStackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_topMargin)
            make.left.equalTo(contentView.snp_leftMargin).offset(10)
        }
        
        actorBiographyLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(aboutActorFullStackView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.snp_leftMargin).offset(16)
            make.right.equalTo(contentView.snp_rightMargin).offset(-16)
        }
        actorBiographyDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(actorBiographyLabel.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.snp_leftMargin).offset(16)
            make.right.equalTo(contentView.snp_rightMargin).offset(-16)
            make.bottom.equalTo(contentView.snp_bottomMargin).offset(-16)
        }
    }
    
    func config(actor: CastDetailEntity){
        actorName.text = actor.name
        actorBithday.text = "\(actor.birthday), \(actor.placeOfBirth ?? "\(actor.birthday)")"
        actorDepartment.text = actor.knownForDepartment
        actorBiographyDescription.text = actor.biography
        if let actor = actor.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(actor)")
            actorPhotoImage.kf.setImage(with: url)
        }
    }
}
