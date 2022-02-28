//
//  ViewController.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

//Интерфейс для конфигурации ячеек
protocol Settings {
    var name: String { get }
    var handler: (() -> Void) { get }
}

//Секция с типами ячеек
struct Section {
    let options: [SettingsOptionType]
}

//Типы ячеек
enum SettingsOptionType {
    case profileCell(model: SettingsProfileOption)
    case airplaneCell(model: SettingsAirplaneOption)
    case networkCell(model: SettingsNetworkOption)
    case settingsCell(model: SettingsOption)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Views
    
    //Создание строки поиска
    private lazy var searchView: UISearchController = {
        let searchView = UISearchController(searchResultsController: nil)
        
        searchView.searchBar.tintColor = .systemBlue
        searchView.searchBar.placeholder = "Поиск"
        searchView.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        
        return searchView
    }()
    
    //Создание таблицы
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(AirplaneTableViewCell.self, forCellReuseIdentifier: AirplaneTableViewCell.identifier)
        tableView.register(NetworkTableViewCell.self, forCellReuseIdentifier: NetworkTableViewCell.identifier)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        
        return tableView
    }()
    
    //Здесь хранятся ячейки разбитые по секциям
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

    //Конфигурация navigation bar
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
    
    //Функция добавления ячеек в таблицу
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
            .settingsCell(model: SettingsOption(name: "Сотовая связь",
                                                icon: UIImage(named: "cellular") ?? UIImage(),
                                                handler: { print("Нажата ячейка сотовая связь") })),
            .settingsCell(model: SettingsOption(name: "Режим модема",
                                                icon: UIImage(named: "modem") ?? UIImage(),
                                                handler: { print("Нажата ячейка режим модема") })),
            .networkCell(model: SettingsNetworkOption(name: "VPN",
                                                      icon: UIImage(named: "vpn") ?? UIImage(),
                                                      informer: "Не подключено",
                                                      handler: { print("Нажата ячейка VPN") }))]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: "Уведомления",
                                                icon: UIImage(named: "notifications") ?? UIImage(),
                                                handler: { print("Нажата ячейка уведомления") })),
            .settingsCell(model: SettingsOption(name: "Звуки, тактильные сигналы",
                                                icon: UIImage(named: "sounds") ?? UIImage(),
                                                handler: { print("Нажата ячейка звуки") })),
            .settingsCell(model: SettingsOption(name: "Фокусирование",
                                                icon: UIImage(named: "focus") ?? UIImage(),
                                                handler: { print("Нажата ячейка фокусирование") })),
            .settingsCell(model: SettingsOption(name: "Экранное время",
                                                icon: UIImage(named: "screen.time") ?? UIImage(),
                                                handler: { print("Нажата ячейка экранное время") }))
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: "Основные",
                                                icon: UIImage(named: "main") ?? UIImage(),
                                                handler: { print("Нажата ячейка Настройки") })),
            .settingsCell(model: SettingsOption(name: "Пункт управления",
                                                icon: UIImage(named: "command.center") ?? UIImage(),
                                                handler: { print("Нажата ячейка Пункт управления") })),
            .settingsCell(model: SettingsOption(name: "Экран и яркость",
                                                icon: UIImage(named: "screen.and.brightness") ?? UIImage(),
                                                handler: { print("Нажата ячейка Экран и яркость") })),
            .settingsCell(model: SettingsOption(name: "Экран «Домой»",
                                                icon: UIImage(named: "screen.home") ?? UIImage(),
                                                handler: { print("Нажата ячейка Экран «Домой»") })),
            .settingsCell(model: SettingsOption(name: "Универсальный доступ",
                                                icon: UIImage(named: "universal.access") ?? UIImage(),
                                                handler: { print("Нажата ячейка Универсальный доступ") })),
            .settingsCell(model: SettingsOption(name: "Обои",
                                                icon: UIImage(named: "wallpaper") ?? UIImage(),
                                                handler: { print("Нажата ячейка Обои") })),
            .settingsCell(model: SettingsOption(name: "Siri и Поиск",
                                                icon: UIImage(named: "siri") ?? UIImage(),
                                                handler: { print("Нажата ячейка Siri и Поиск") })),
            .settingsCell(model: SettingsOption(name: "Face ID и код-пароль",
                                                icon: UIImage(named: "faceid") ?? UIImage(),
                                                handler: { print("Нажата ячейка Face ID и код-пароль") })),
            .settingsCell(model: SettingsOption(name: "Экстренный вызов -- SOS",
                                                icon: UIImage(named: "SOS") ?? UIImage(),
                                                handler: { print("Нажата ячейка Экстренный вызов -- SOS") })),
            .settingsCell(model: SettingsOption(name: "Уведомления о контакте",
                                                icon: UIImage(named: "contact") ?? UIImage(),
                                                handler: { print("Нажата ячейка Уведомления о контакте") })),
            .settingsCell(model: SettingsOption(name: "Аккумулятор",
                                                icon: UIImage(named: "battery") ?? UIImage(),
                                                handler: { print("Нажата ячейка Аккумулятор") })),
            .settingsCell(model: SettingsOption(name: "Конфиденциальность",
                                                icon: UIImage(named: "confidentiality") ?? UIImage(),
                                                handler: { print("Нажата ячейка Конфиденциальность") })),
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: "App Store",
                                                icon: UIImage(named: "appstore") ?? UIImage(),
                                                handler: { print("Нажата ячейка App Store") })),
            .settingsCell(model: SettingsOption(name: "Wallet и Apple Pay",
                                                icon: UIImage(named: "wallet") ?? UIImage(),
                                                handler: { print("Нажата ячейка Wallet и Apple Pay") }))
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: "Пароли",
                                                icon: UIImage(named: "passwords") ?? UIImage(),
                                                handler: { print("Нажата ячейка Пароли") })),
            .settingsCell(model: SettingsOption(name: "Почта",
                                                icon: UIImage(named: "mail") ?? UIImage(),
                                                handler: { print("Нажата ячейка Почта") })),
            .settingsCell(model: SettingsOption(name: "Контакты",
                                                icon: UIImage(named: "contacts") ?? UIImage(),
                                                handler: { print("Нажата ячейка Контакты") })),
            .settingsCell(model: SettingsOption(name: "Календарь",
                                                icon: UIImage(named: "calendar") ?? UIImage(),
                                                handler: { print("Нажата ячейка Календарь") })),
            .settingsCell(model: SettingsOption(name: "Заметки",
                                                icon: UIImage(named: "notes") ?? UIImage(),
                                                handler: { print("Нажата ячейка Заметки") })),
            .settingsCell(model: SettingsOption(name: "Напоминания",
                                                icon: UIImage(named: "reminders") ?? UIImage(),
                                                handler: { print("Нажата ячейка Напоминания") })),
            .settingsCell(model: SettingsOption(name: "Диктофон",
                                                icon: UIImage(named: "recorder") ?? UIImage(),
                                                handler: { print("Нажата ячейка Диктофон") })),
            .settingsCell(model: SettingsOption(name: "Телефон",
                                                icon: UIImage(named: "telephone") ?? UIImage(),
                                                handler: { print("Нажата ячейка Телефон") })),
            .settingsCell(model: SettingsOption(name: "Сообщения",
                                                icon: UIImage(named: "message") ?? UIImage(),
                                                handler: { print("Нажата ячейка Сообщения") })),
            .settingsCell(model: SettingsOption(name: "FaceTime",
                                                icon: UIImage(named: "facetime") ?? UIImage(),
                                                handler: { print("Нажата ячейка FaceTime") })),
            .settingsCell(model: SettingsOption(name: "Safari",
                                                icon: UIImage(named: "safari") ?? UIImage(),
                                                handler: { print("Нажата ячейка Safari") })),
            .settingsCell(model: SettingsOption(name: "Акции",
                                                icon: UIImage(named: "stock") ?? UIImage(),
                                                handler: { print("Нажата ячейка Акции") })),
            .settingsCell(model: SettingsOption(name: "Погода",
                                                icon: UIImage(named: "weather") ?? UIImage(),
                                                handler: { print("Нажата ячейка Погода") })),
            .settingsCell(model: SettingsOption(name: "Перевод",
                                                icon: UIImage(named: "translate") ?? UIImage(),
                                                handler: { print("Нажата ячейка Перевод") })),
            .settingsCell(model: SettingsOption(name: "Карты",
                                                icon: UIImage(named: "maps") ?? UIImage(),
                                                handler: { print("Нажата ячейка Карты") })),
            .settingsCell(model: SettingsOption(name: "Компас",
                                                icon: UIImage(named: "compass") ?? UIImage(),
                                                handler: { print("Нажата ячейка Компас") })),
            .settingsCell(model: SettingsOption(name: "Рулетка",
                                                icon: UIImage(named: "roulette") ?? UIImage(),
                                                handler: { print("Нажата ячейка Рулетка") })),
            .settingsCell(model: SettingsOption(name: "Быстрые команды",
                                                icon: UIImage(named: "quick.commands") ?? UIImage(),
                                                handler: { print("Нажата ячейка Быстрые команды") })),
            .settingsCell(model: SettingsOption(name: "Здоровье",
                                                icon: UIImage(named: "health") ?? UIImage(),
                                                handler: { print("Нажата ячейка Здоровье") })),
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: "Музыка",
                                                icon: UIImage(named: "music") ?? UIImage(),
                                                handler: { print("Нажата ячейка Музыка") })),
            .settingsCell(model: SettingsOption(name: "TV",
                                                icon: UIImage(named: "tv") ?? UIImage(),
                                                handler: { print("Нажата ячейка TV") })),
            .settingsCell(model: SettingsOption(name: "Фото",
                                                icon: UIImage(named: "photo") ?? UIImage(),
                                                handler: { print("Нажата ячейка Фото") })),
            .settingsCell(model: SettingsOption(name: "Камера",
                                                icon: UIImage(named: "camera") ?? UIImage(),
                                                handler: { print("Нажата ячейка Камера") })),
            .settingsCell(model: SettingsOption(name: "Книги",
                                                icon: UIImage(named: "books") ?? UIImage(),
                                                handler: { print("Нажата ячейка Книги") })),
            .settingsCell(model: SettingsOption(name: "Подкасты",
                                                icon: UIImage(named: "podcasts") ?? UIImage(),
                                                handler: { print("Нажата ячейка Подкасты") })),
            .settingsCell(model: SettingsOption(name: "Game Center",
                                                icon: UIImage(named: "game.center") ?? UIImage(),
                                                handler: { print("Нажата ячейка Game Center") }))]))
    }
    
    //Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    //Количество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].options.count
    }
    
    //Переопределение ячеек к кастомным
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
        case .settingsCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath) as? SettingsTableViewCell else {
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

