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
    let profileImage: UIImage?
    let handler: (() -> Void)
}

class ProfileTableViewCell: UITableViewCell {
    static let identifier = Strings.profileCellIdentifier
    
    //Имя профиля
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: Sizes.nameLabelFontSize)
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        
        return nameLabel
    }()
    
    //Описание того что находится в настройках профиля
    private lazy var detailedLabel: UILabel = {
        let detailedLabel = UILabel()
        
        detailedLabel.font = .systemFont(ofSize: Sizes.detailedLabelFontSize)
        detailedLabel.adjustsFontSizeToFitWidth = true
        
        return detailedLabel
    }()
    
    //Картинка профиля
    private lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        
        profileImage.contentMode = .scaleAspectFit
        profileImage.clipsToBounds = true
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = contentView.frame.size.width * Sizes.profileImageCornerRadiusMultiplier
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
        
        contentView.heightAnchor.constraint(equalToConstant: Sizes.contentViewHeight).isActive = true
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: Offsets.profileImageTopLeftOffsets15).isActive = true
        profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                           constant: Offsets.profileImageTopLeftOffsets15).isActive = true
        profileImage.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                             multiplier: Sizes.profileImageWidthMultiplier).isActive = true
        profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: Offsets.nameLabelTopOffset).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor,
                                        constant: Offsets.nameLabelLeftOffset).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor,
                                          multiplier: Sizes.nameLabelHeightMultiplier).isActive = true
        
        detailedLabel.translatesAutoresizingMaskIntoConstraints = false
        detailedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                           constant: Offsets.detailedLabelTopOffset).isActive = true
        detailedLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor,
                                            constant: Offsets.detailedLabelLeftOffset).isActive = true
        detailedLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor,
                                              multiplier: Sizes.detailedLabelHeightMultiplier).isActive = true
        detailedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                             multiplier: Sizes.detailedLabelWidthMultiplier).isActive = true
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

extension ProfileTableViewCell {
    enum Strings {
        static let profileCellIdentifier = "ProfileTableViewCell"
    }
    
    enum Sizes {
        static let nameLabelFontSize: CGFloat = 24
        static let detailedLabelFontSize: CGFloat = 12.5
        static let contentViewHeight: CGFloat = 95
        static let profileImageWidthMultiplier: CGFloat = 0.2
        static let nameLabelHeightMultiplier: CGFloat = 0.08
        static let detailedLabelHeightMultiplier: CGFloat = 0.05
        static let detailedLabelWidthMultiplier: CGFloat = 0.67
        static let profileImageCornerRadiusMultiplier: CGFloat = 0.0935
    }
    
    enum Offsets {
        static let profileImageTopLeftOffsets15: CGFloat = 15
        static let nameLabelTopOffset: CGFloat = 23
        static let nameLabelLeftOffset: CGFloat = 15
        static let detailedLabelTopOffset: CGFloat = 4
        static let detailedLabelLeftOffset: CGFloat = 15
    }
}
