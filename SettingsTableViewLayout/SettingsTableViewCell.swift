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
    static let identifier = Strings.settingsCellIdentifier
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: Sizes.nameLabelFontSize)
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
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: Offsets.nameLabelTopOffset).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: iconSettings.rightAnchor,
                                        constant: Offsets.nameLabelLeftOffset).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor,
                                          multiplier: Sizes.nameLabelHeightMultiplier).isActive = true
        
        iconSettings.translatesAutoresizingMaskIntoConstraints = false
        iconSettings.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: Offsets.iconSettingsTopOffset).isActive = true
        iconSettings.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                           constant: Offsets.iconSettingsLeftOffset).isActive = true
        iconSettings.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                            multiplier: Sizes.iconSettingsWidthMultiplier).isActive = true
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

extension SettingsTableViewCell {
    enum Strings {
        static let settingsCellIdentifier: String = "SettingsTableViewCell"
    }
    
    enum Sizes {
        static let nameLabelFontSize: CGFloat = 17
        static let nameLabelHeightMultiplier: CGFloat = 0.06
        static let iconSettingsWidthMultiplier: CGFloat = 0.09
    }
    
    enum Offsets {
        static let nameLabelTopOffset: CGFloat = 11.5
        static let nameLabelLeftOffset: CGFloat = 14.5
        static let iconSettingsTopOffset: CGFloat = 7.5
        static let iconSettingsLeftOffset: CGFloat = 14
    }
}
