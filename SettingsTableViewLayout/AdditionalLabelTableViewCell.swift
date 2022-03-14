//
//  NetworkTableViewCell.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

struct SettingsAdditionalLabelOption: Settings {
    let name: String
    let icon: UIImage?
    let informer: String?
    let handler: (() -> Void)
    let indicatorBadge: String?
    let isAdditionalLabelDefault: Bool
}

class AdditionalLabelTableViewCell: UITableViewCell {
    static let identifier = Strings.additionalLabelCellIdentifier

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: Sizes.labelFontSize)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        return nameLabel
    }()

    private lazy var iconNetwork: UIImageView = {
        let iconNetwork = UIImageView()
        
        iconNetwork.contentMode = .scaleAspectFit
        iconNetwork.backgroundColor = .white
        
        return iconNetwork
    }()
    
    //Информация о состоянии сети
    private lazy var informerLabel: UILabel = {
        let informerLabel = UILabel()
        
        informerLabel.font = .systemFont(ofSize: Sizes.labelFontSize)
        informerLabel.adjustsFontSizeToFitWidth = true
        informerLabel.alpha = Display.informerLabelAlpha
        informerLabel.textAlignment = .right
        
        return informerLabel
    }()
    
    private lazy var indicatorBadge: UILabel = {
        let indicatorBadge = UILabel()
        
        indicatorBadge.backgroundColor = .red
        indicatorBadge.textColor = .white
        indicatorBadge.textAlignment = .center
        indicatorBadge.adjustsFontSizeToFitWidth = true
        indicatorBadge.layer.cornerRadius = contentView.frame.size.width * Sizes.indicatorBadgeCornerRadiusMultiplier
        indicatorBadge.layer.masksToBounds = true
        
        return indicatorBadge
    }()
    
    private func addDifferentAdditionalLabels(with model: SettingsAdditionalLabelOption) {
        if model.isAdditionalLabelDefault == true {
            contentView.addSubview(informerLabel)
            informerLabel.translatesAutoresizingMaskIntoConstraints = false
            informerLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Offsets.labelTopOffset).isActive = true
            informerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                 constant: Offsets.informerLabelRightOffset).isActive = true
            informerLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor,
                                                  multiplier: Sizes.informerLabelHeightMultiplier).isActive = true
            informerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                                 multiplier: Sizes.informerLabelWidthMultiplier).isActive = true
        } else {
            contentView.addSubview(indicatorBadge)
            indicatorBadge.translatesAutoresizingMaskIntoConstraints = false
            indicatorBadge.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: Offsets.indicatorBadgeTopOffset).isActive = true
            indicatorBadge.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                  constant: Offsets.indicatorBadgeRightOffset).isActive = true
            indicatorBadge.heightAnchor.constraint(equalTo: contentView.widthAnchor,
                                                   multiplier: Sizes.indicatorBadgeHeightMultiplier).isActive = true
            indicatorBadge.widthAnchor.constraint(equalTo: indicatorBadge.heightAnchor).isActive = true
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconNetwork)
        contentView.addSubview(nameLabel)
        accessoryType = .disclosureIndicator
        
        iconNetwork.translatesAutoresizingMaskIntoConstraints = false
        iconNetwork.topAnchor.constraint(equalTo: contentView.topAnchor,
                                         constant: Offsets.iconNetworkTopOffset).isActive = true
        iconNetwork.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                          constant: Offsets.iconNetworkLeftOffset).isActive = true
        iconNetwork.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                           multiplier: Sizes.iconNetworkWidthMultiplier).isActive = true
        iconNetwork.heightAnchor.constraint(equalTo: iconNetwork.widthAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: Offsets.labelTopOffset).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: iconNetwork.rightAnchor,
                                        constant: Offsets.nameLabelLeftOffset).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor,
                                          multiplier: Sizes.nameLabelHeightMultiplier).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with model: SettingsAdditionalLabelOption) {
        nameLabel.text = model.name
        iconNetwork.image = model.icon
        informerLabel.text = model.informer
        indicatorBadge.text = model.indicatorBadge
        addDifferentAdditionalLabels(with: model)
    }

}

extension AdditionalLabelTableViewCell {
    enum Strings {
        static let additionalLabelCellIdentifier: String = "AdditionalLabelTableViewCell"
    }
    
    enum Sizes {
        static let labelFontSize: CGFloat = 16
        static let iconNetworkWidthMultiplier: CGFloat = 0.09
        static let nameLabelHeightMultiplier: CGFloat = 0.06
        static let informerLabelHeightMultiplier: CGFloat = 0.06
        static let informerLabelWidthMultiplier: CGFloat = 0.6
        static let indicatorBadgeHeightMultiplier: CGFloat = 0.07
        static let indicatorBadgeCornerRadiusMultiplier: CGFloat = 0.032
    }
    
    enum Offsets {
        static let iconNetworkTopOffset: CGFloat = 7.5
        static let iconNetworkLeftOffset: CGFloat = 14
        static let labelTopOffset: CGFloat = 11.5
        static let nameLabelLeftOffset: CGFloat = 14.5
        static let informerLabelRightOffset: CGFloat = -7
        static let indicatorBadgeTopOffset: CGFloat = 11
        static let indicatorBadgeRightOffset: CGFloat = -17
    }
    
    enum Display {
        static let informerLabelAlpha: CGFloat = 0.6
    }
}
