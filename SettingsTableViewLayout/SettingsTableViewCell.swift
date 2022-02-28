//
//  SettingsTableViewCell.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

struct SettingsOption: Settings {
    let name: String
    let icon: UIImage
    let handler: (() -> Void)
}

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: 17)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        return nameLabel
    }()
    
    private lazy var iconSettings: UIImageView = {
        let iconSettings = UIImageView()
        
        iconSettings.contentMode = .scaleAspectFit
        iconSettings.backgroundColor = .white
        
        return iconSettings
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconSettings)
        accessoryType = .disclosureIndicator
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11.5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: iconSettings.rightAnchor, constant: 14.5).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.06).isActive = true
        
        iconSettings.translatesAutoresizingMaskIntoConstraints = false
        iconSettings.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7.5).isActive = true
        iconSettings.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14).isActive = true
        iconSettings.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.09).isActive = true
        iconSettings.heightAnchor.constraint(equalTo: iconSettings.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with model: SettingsOption) {
        nameLabel.text = model.name
        iconSettings.image = model.icon
    }

}
