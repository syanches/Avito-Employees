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
        imageView.tintColor = UIColor.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
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
    }
    
    private func configureCell() {
        contentView.addSubview(personImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(skillsLabel)
                
        NSLayoutConstraint.activate([
            personImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            personImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImageView.widthAnchor.constraint(equalToConstant: 75),
            personImageView.heightAnchor.constraint(equalToConstant: 75),
            
            nameLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            skillsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            skillsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            skillsLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            skillsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
