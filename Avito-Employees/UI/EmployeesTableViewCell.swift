//
//  EmployeesTableViewCell.swift
//  Avito-Employees
//
//  Created by Artem Martirosyan on 26.10.2022.
//

import Foundation
import UIKit

class EmployeesTableViewCell: UITableViewCell {
    
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initCell(name: String, phoneNumber: String, skills: [String]) {
        nameLabel.text = name
        phoneLabel.text = phoneNumber
        skillsLabel.text = "Skills: " + skills.joined(separator: ", ")
        personImageView.tintColor = .randomColor
    }
    
    private func configureCell() {
        contentView.addSubview(personImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(skillsLabel)
        
        let personImageHeightWidthConstant: CGFloat = 75
        let cellMarginConstant: CGFloat = 10
        
        NSLayoutConstraint.activate([
            personImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            personImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImageView.widthAnchor.constraint(equalToConstant: personImageHeightWidthConstant),
            personImageView.heightAnchor.constraint(equalToConstant: personImageHeightWidthConstant),
            
            nameLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: cellMarginConstant),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellMarginConstant),
            
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            skillsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            skillsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellMarginConstant),
            skillsLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: cellMarginConstant),
            skillsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -cellMarginConstant),
        ])
    }
}
