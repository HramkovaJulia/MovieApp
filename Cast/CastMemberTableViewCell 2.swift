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
        label.numberOfLines = 2
        label.text = "Name"
        return label
    }()
    
    let actorBithdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Birthday"
        return label
    }()
    
    let actorDepartmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.text = "Department"
        return label
    }()
    
    let actorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    let actorBithday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    var actorDepartment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 1
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
        stack.distribution = .fillEqually
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
        NSLayoutConstraint.activate([
            aboutActorFullStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            aboutActorFullStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            actorBiographyLabel.topAnchor.constraint(equalTo: aboutActorFullStackView.bottomAnchor, constant: 16),
            actorBiographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actorBiographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            actorBiographyDescription.topAnchor.constraint(equalTo: actorBiographyLabel.bottomAnchor, constant: 16),
            actorBiographyDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actorBiographyDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func config(actor: Cast){
        actorName.text = actor.name
        actorBithday.text = actor.birthday
        actorDepartment.text = actor.department
        actorPhotoImage.image = UIImage(named: actor.image)
        actorBiographyDescription.text = actor.biography
    }
}
