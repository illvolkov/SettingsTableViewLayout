//
//  AirplaneTableViewCell.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

struct SettingsAirplaneOption: Settings {
    let name: String
    let icon: UIImage
    let handler: (() -> Void)
}

class AirplaneTableViewCell: UITableViewCell {
    static let identifier = Strings.airplaneCellIdentifier
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: Sizes.nameLabelFontSize)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        return nameLabel
    }()
    
    //Иконка ячейки
    private lazy var iconAirplane: UIImageView = {
        let icon = UIImageView()
        
        icon.contentMode = .scaleAspectFit
        icon.backgroundColor = .white
        
        return icon
    }()
    
    //Селектор переключения режима
    private lazy var switchAirplane: UISwitch = {
        let switchAirplane = UISwitch()
        return switchAirplane
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconAirplane)
        contentView.addSubview(switchAirplane)
        
        iconAirplane.translatesAutoresizingMaskIntoConstraints = false
        iconAirplane.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: Offsets.iconAirplaneTopOffset).isActive = true
        iconAirplane.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                           constant: Offsets.iconAirplaneLeftOffset).isActive = true
        iconAirplane.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                            multiplier: Sizes.iconAirplaneWeightMultiplier).isActive = true
        iconAirplane.heightAnchor.constraint(equalTo: iconAirplane.widthAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: Offsets.nameLabelTopOffset).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: iconAirplane.rightAnchor,
                                        constant: Offsets.nameLabelLeftOffset).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor,
                                          multiplier: Sizes.nameLabelHeightMultiplier).isActive = true
        
        switchAirplane.translatesAutoresizingMaskIntoConstraints = false
        switchAirplane.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Offsets.switchAirplaneTopOffset).isActive = true
        switchAirplane.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                              constant: Offsets.switchAirplaneRightOffset).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with model: SettingsAirplaneOption) {
        nameLabel.text = model.name
        iconAirplane.image = model.icon
    }
}

extension AirplaneTableViewCell {
    enum Strings {
        static let airplaneCellIdentifier: String = "AirplaneTableViewCell"
    }
    
    enum Sizes {
        static let nameLabelFontSize: CGFloat = 17
        static let iconAirplaneWeightMultiplier: CGFloat = 0.08
        static let nameLabelHeightMultiplier: CGFloat = 0.06
    }
    
    enum Offsets {
        static let iconAirplaneTopOffset: CGFloat = 7.5
        static let iconAirplaneLeftOffset: CGFloat = 14
        static let nameLabelTopOffset: CGFloat = 11
        static let nameLabelLeftOffset: CGFloat = 14.5
        static let switchAirplaneTopOffset: CGFloat = 6.5
        static let switchAirplaneRightOffset: CGFloat = -22
    }
}
