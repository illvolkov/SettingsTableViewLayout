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
    static let identifier = "AirplaneTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: 17)
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
        iconAirplane.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7.5).isActive = true
        iconAirplane.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14).isActive = true
        iconAirplane.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.08).isActive = true
        iconAirplane.heightAnchor.constraint(equalTo: iconAirplane.widthAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: iconAirplane.rightAnchor, constant: 14.5).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.06).isActive = true
        
        switchAirplane.translatesAutoresizingMaskIntoConstraints = false
        switchAirplane.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6.5).isActive = true
        switchAirplane.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with model: SettingsAirplaneOption) {
        nameLabel.text = model.name
        iconAirplane.image = model.icon
    }
}

