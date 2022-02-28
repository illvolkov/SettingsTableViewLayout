//
//  ViewController.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

protocol Settings {
    var name: String { get }
    var handler: (() -> Void) { get }
}

struct Section {
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case profileCell(model: SettingsProfileOption)
    case airplaneCell(model: SettingsAirplaneOption)
    case networkCell(model: SettingsNetworkOption)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Views
    
    private lazy var searchView: UISearchController = {
        let searchView = UISearchController(searchResultsController: nil)
        
        searchView.searchBar.tintColor = .systemBlue
        searchView.searchBar.placeholder = "Поиск"
        searchView.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        
        return searchView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(AirplaneTableViewCell.self, forCellReuseIdentifier: AirplaneTableViewCell.identifier)
        tableView.register(NetworkTableViewCell.self, forCellReuseIdentifier: NetworkTableViewCell.identifier)
        
        return tableView
    }()
    
    var models = [Section]()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHiearchy()
        setupLayout()
        setupView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpNavigationBar()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    //MARK: - Settings
    
    private func setupHiearchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    //MARK: - Functions

    private func setUpNavigationBar() {
        navigationItem.title = "Настройки"
        navigationItem.searchController = searchView
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(rgb: 0xF2F1F7)
        appearance.shadowColor = UIColor(rgb: 0xF2F1F7)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configure() {
        models.append(Section(options: [
            .profileCell(model: SettingsProfileOption(name: "Илья Волков",
                                                      detailedTitle: "Apple ID, iCloud, контент и покупки",
                                                      profileImage: (UIImage(named: "profile.image") ?? UIImage()),
                                                      handler: { print("Нажата ячейка Профиль") }))]))
        
        models.append(Section(options: [
            .airplaneCell(model: SettingsAirplaneOption(name: "Авиарежим",
                                                      icon: UIImage(named: "airplane.mode") ?? UIImage(),
                                                      handler: { print("Нажата ячейка Авиарежим") })),
            .networkCell(model: SettingsNetworkOption(name: "Wi-Fi",
                                                      icon: UIImage(named: "wifi") ?? UIImage(),
                                                      informer: "Не подключено",
                                                      handler: { print("Нажата ячейка Wi-Fi") })),
            .networkCell(model: SettingsNetworkOption(name: "Bluetooth",
                                                      icon: UIImage(named: "bluetooth") ?? UIImage(),
                                                      informer: "Выкл.",
                                                      handler: { print("Нажата ячейка Bluetooth") })),
            .networkCell(model: SettingsNetworkOption(name: "VPN",
                                                      icon: UIImage(named: "vpn") ?? UIImage(),
                                                      informer: "Не подключено",
                                                      handler: { print("Нажата ячейка VPN") }))]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model {
        case .profileCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileTableViewCell.identifier,
                for: indexPath
            ) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .airplaneCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AirplaneTableViewCell.identifier,
                for: indexPath) as? AirplaneTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .networkCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NetworkTableViewCell.identifier,
                for: indexPath) as? NetworkTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && red <= 255, "Invalid green component")
        assert(blue >= 0 && red <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF,
                  green: (rgb >> 8) & 0xFF,
                  blue: rgb & 0xFF)
    }
}

