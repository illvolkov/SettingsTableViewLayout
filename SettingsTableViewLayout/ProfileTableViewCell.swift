//
//  ProfileTableViewCell.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

//Конфигурация ячеек
struct SettingsProfileOption: Settings {
    let name: String
    let detailedTitle: String
    let profileImage: UIImage
    let handler: (() -> Void)
}

class ProfileTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    
    //Имя профиля
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        
        return nameLabel
    }()
    
    //Описание того что находится в настройках профиля
    private lazy var detailedLabel: UILabel = {
        let detailedLabel = UILabel()
        
        detailedLabel.font = .systemFont(ofSize: 12.5)
        detailedLabel.adjustsFontSizeToFitWidth = true
        
        return detailedLabel
    }()
    
    //Картинка профиля
    private lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        
        profileImage.contentMode = .scaleAspectFit
        profileImage.clipsToBounds = true
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 32.5
        profileImage.backgroundColor = .white
        
        return profileImage
    }()
    
    //Добавление вью в ячейку и установка ограничений
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailedLabel)
        contentView.addSubview(profileImage)
        accessoryType = .disclosureIndicator
        
        contentView.heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        profileImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.08).isActive = true
        
        detailedLabel.translatesAutoresizingMaskIntoConstraints = false
        detailedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        detailedLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15).isActive = true
        detailedLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.05).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Присваивание значений свойств к вью
    func configure(with model: SettingsProfileOption) {
        nameLabel.text = model.name
        detailedLabel.text = model.detailedTitle
        profileImage.image = model.profileImage
        
    }
    

}
