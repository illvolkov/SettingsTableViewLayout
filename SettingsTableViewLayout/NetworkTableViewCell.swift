//
//  NetworkTableViewCell.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

struct SettingsNetworkOption: Settings {
    let name: String
    let icon: UIImage
    let informer: String
    let handler: (() -> Void)
    
}

class NetworkTableViewCell: UITableViewCell {
    static let identifier = "NetworkTableViewCell"

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.font = .systemFont(ofSize: 17)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        return nameLabel
    }()

    private lazy var iconNetwork: UIImageView = {
        let iconNetwork = UIImageView()
        
        iconNetwork.contentMode = .scaleAspectFit
        iconNetwork.backgroundColor = .white
        
        return iconNetwork
    }()
    
    private lazy var informerLabel: UILabel = {
        let informerLabel = UILabel()
        
        informerLabel.font = .systemFont(ofSize: 17)
        informerLabel.adjustsFontSizeToFitWidth = true
        informerLabel.alpha = 0.6
        informerLabel.textAlignment = .right
        
        return informerLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconNetwork)
        contentView.addSubview(nameLabel)
        contentView.addSubview(informerLabel)
        accessoryType = .disclosureIndicator
        
        iconNetwork.translatesAutoresizingMaskIntoConstraints = false
        iconNetwork.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7.5).isActive = true
        iconNetwork.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14).isActive = true
        iconNetwork.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.09).isActive = true
        iconNetwork.heightAnchor.constraint(equalTo: iconNetwork.widthAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11.5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: iconNetwork.rightAnchor, constant: 14.5).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.06).isActive = true
        
        informerLabel.translatesAutoresizingMaskIntoConstraints = false
        informerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11.5).isActive = true
        informerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7).isActive = true
        informerLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.06).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with model: SettingsNetworkOption) {
        nameLabel.text = model.name
        iconNetwork.image = model.icon
        informerLabel.text = model.informer
    }

}
