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
        searchView.searchBar.placeholder = Strings.searchBarPlaceholder
        searchView.searchBar.setValue(Strings.searchBarCancelButtonTitle, forKey: Strings.searchBarCancelButtonKey)
        
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
        navigationItem.title = Strings.navigationBarTitle
        navigationItem.searchController = searchView
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Color.navigationItemColor
        appearance.shadowColor = Color.navigationItemColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    //Функция добавления ячеек в таблицу
    private func configure() {
        models.append(Section(options: [
            .profileCell(model: SettingsProfileOption(name: Strings.profileName,
                                                      detailedTitle: Strings.profileDetailedTitle,
                                                      profileImage: (UIImage(named: Icons.profileIcon) ?? UIImage()),
                                                      handler: { print("Нажата ячейка Профиль") }))]))
        
        models.append(Section(options: [
            .airplaneCell(model: SettingsAirplaneOption(name: Strings.airplaneCellTitle,
                                                        icon: UIImage(named: Icons.airplaneIcon) ?? UIImage(),
                                                      handler: { print("Нажата ячейка Авиарежим") })),
            .networkCell(model: SettingsNetworkOption(name: Strings.wifiCellTitle,
                                                      icon: UIImage(named: Icons.wifiIcon) ?? UIImage(),
                                                      informer: Strings.informerTitleNotConnected,
                                                      handler: { print("Нажата ячейка Wi-Fi") })),
            .networkCell(model: SettingsNetworkOption(name: Strings.bluetoothCellTitle,
                                                      icon: UIImage(named: Icons.bluetoothIcon) ?? UIImage(),
                                                      informer: Strings.bluetoothInformerTitle,
                                                      handler: { print("Нажата ячейка Bluetooth") })),
            .settingsCell(model: SettingsOption(name: Strings.cellularCellTitle,
                                                icon: UIImage(named: Icons.cellularIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Сотовая связь") })),
            .settingsCell(model: SettingsOption(name: Strings.modemCellTitle,
                                                icon: UIImage(named: Icons.modemIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Режим модема") })),
            .networkCell(model: SettingsNetworkOption(name: Strings.vpnCellTitle,
                                                      icon: UIImage(named: Icons.vpnIcon) ?? UIImage(),
                                                      informer: Strings.informerTitleNotConnected,
                                                      handler: { print("Нажата ячейка VPN") }))]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: Strings.notificationsCellTitle,
                                                icon: UIImage(named: Icons.notificationsIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Уведомления") })),
            .settingsCell(model: SettingsOption(name: Strings.soundsCellTitle,
                                                icon: UIImage(named: Icons.soundsIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Звуки") })),
            .settingsCell(model: SettingsOption(name: Strings.focusCellTitle,
                                                icon: UIImage(named: Icons.focusIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Фокусирование") })),
            .settingsCell(model: SettingsOption(name: Strings.screenTimeCellTitle,
                                                icon: UIImage(named: Icons.screenTimeIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Экранное время") }))
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: Strings.mainCellTitle,
                                                icon: UIImage(named: Icons.mainIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Основные") })),
            .settingsCell(model: SettingsOption(name: Strings.commandCenterCellTitle,
                                                icon: UIImage(named: Icons.commandCenterIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Пункт управления") })),
            .settingsCell(model: SettingsOption(name: Strings.brightnessCellTitle,
                                                icon: UIImage(named: Icons.brightnessIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Экран и яркость") })),
            .settingsCell(model: SettingsOption(name: Strings.screenHomeCellTitle,
                                                icon: UIImage(named: Icons.screenHomeIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Экран «Домой»") })),
            .settingsCell(model: SettingsOption(name: Strings.universalAccessCellTitle,
                                                icon: UIImage(named: Icons.universalAccessIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Универсальный доступ") })),
            .settingsCell(model: SettingsOption(name: Strings.wallpaperCellTitle,
                                                icon: UIImage(named: Icons.wallpaperIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Обои") })),
            .settingsCell(model: SettingsOption(name: Strings.siriCellTitle,
                                                icon: UIImage(named: Icons.siriIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Siri и Поиск") })),
            .settingsCell(model: SettingsOption(name: Strings.faceIDCellTitle,
                                                icon: UIImage(named: Icons.faceIDIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Face ID и код-пароль") })),
            .settingsCell(model: SettingsOption(name: Strings.sosCellTitle,
                                                icon: UIImage(named: Icons.sosICon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Экстренный вызов -- SOS") })),
            .settingsCell(model: SettingsOption(name: Strings.contactCellTitle,
                                                icon: UIImage(named: Icons.contactIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Уведомления о контакте") })),
            .settingsCell(model: SettingsOption(name: Strings.batteryCellTitle,
                                                icon: UIImage(named: Icons.batteryIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Аккумулятор") })),
            .settingsCell(model: SettingsOption(name: Strings.confidentialityCellTitle,
                                                icon: UIImage(named: Icons.confidentialityIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Конфиденциальность") })),
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: Strings.appstoreCellTitle,
                                                icon: UIImage(named: Icons.appstoreIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка App Store") })),
            .settingsCell(model: SettingsOption(name: Strings.walletCellTitle,
                                                icon: UIImage(named: Icons.walletIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Wallet и Apple Pay") }))
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: Strings.passwordsCellTitle,
                                                icon: UIImage(named: Icons.passwordsIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Пароли") })),
            .settingsCell(model: SettingsOption(name: Strings.mailCellTitle,
                                                icon: UIImage(named: Icons.mailIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Почта") })),
            .settingsCell(model: SettingsOption(name: Strings.contactsCellTitle,
                                                icon: UIImage(named: Icons.contactsIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Контакты") })),
            .settingsCell(model: SettingsOption(name: Strings.calendarCellTitle,
                                                icon: UIImage(named: Icons.calendarIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Календарь") })),
            .settingsCell(model: SettingsOption(name: Strings.notesCellTitle,
                                                icon: UIImage(named: Icons.notesIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Заметки") })),
            .settingsCell(model: SettingsOption(name: Strings.remindersCellTitle,
                                                icon: UIImage(named: Icons.remindersIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Напоминания") })),
            .settingsCell(model: SettingsOption(name: Strings.recorderCellTitle,
                                                icon: UIImage(named: Icons.recorderIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Диктофон") })),
            .settingsCell(model: SettingsOption(name: Strings.phoneCellTitle,
                                                icon: UIImage(named: Icons.phoneIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Телефон") })),
            .settingsCell(model: SettingsOption(name: Strings.messageCellTitle,
                                                icon: UIImage(named: Icons.messageIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Сообщения") })),
            .settingsCell(model: SettingsOption(name: Strings.faceTimeCellTitle,
                                                icon: UIImage(named: Icons.faceTimeIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка FaceTime") })),
            .settingsCell(model: SettingsOption(name: Strings.safariCellTitle,
                                                icon: UIImage(named: Icons.safariIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Safari") })),
            .settingsCell(model: SettingsOption(name: Strings.stockCellTitle,
                                                icon: UIImage(named: Icons.stockIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Акции") })),
            .settingsCell(model: SettingsOption(name: Strings.weatherCellTitle,
                                                icon: UIImage(named: Icons.weatherIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Погода") })),
            .settingsCell(model: SettingsOption(name: Strings.translateCellTitle,
                                                icon: UIImage(named: Icons.translateIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Перевод") })),
            .settingsCell(model: SettingsOption(name: Strings.mapsCellTitle,
                                                icon: UIImage(named: Icons.mapsIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Карты") })),
            .settingsCell(model: SettingsOption(name: Strings.compassCellTitle,
                                                icon: UIImage(named: Icons.compassIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Компас") })),
            .settingsCell(model: SettingsOption(name: Strings.rouletteCellTitle,
                                                icon: UIImage(named: Icons.rouletteIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Рулетка") })),
            .settingsCell(model: SettingsOption(name: Strings.quickCommandsCellTitle,
                                                icon: UIImage(named: Icons.quickCommandsIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Быстрые команды") })),
            .settingsCell(model: SettingsOption(name: Strings.healtCellTitle,
                                                icon: UIImage(named: Icons.healthIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Здоровье") })),
        ]))
        
        models.append(Section(options: [
            .settingsCell(model: SettingsOption(name: Strings.musicCellTitle,
                                                icon: UIImage(named: Icons.musicIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Музыка") })),
            .settingsCell(model: SettingsOption(name: Strings.tvCellTitle,
                                                icon: UIImage(named: Icons.tvIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка TV") })),
            .settingsCell(model: SettingsOption(name: Strings.photoCellTitle,
                                                icon: UIImage(named: Icons.photoIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Фото") })),
            .settingsCell(model: SettingsOption(name: Strings.cameraCellTitle,
                                                icon: UIImage(named: Icons.cameraIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Камера") })),
            .settingsCell(model: SettingsOption(name: Strings.bookCellTitle,
                                                icon: UIImage(named: Icons.bookIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Книги") })),
            .settingsCell(model: SettingsOption(name: Strings.podcastsCellTitle,
                                                icon: UIImage(named: Icons.podcastsIcon) ?? UIImage(),
                                                handler: { print("Нажата ячейка Подкасты") })),
            .settingsCell(model: SettingsOption(name: Strings.gameCenterCellTitle,
                                                icon: UIImage(named: Icons.gameCenterIcon) ?? UIImage(),
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
    
    //Нажатие на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type {
        case .profileCell(let model):
            model.handler()
        case .airplaneCell(let model):
            model.handler()
        case .networkCell(let model):
            model.handler()
        case .settingsCell(let model):
            model.handler()
        }
    }
}

extension ViewController {
    enum Strings {
        static let searchBarPlaceholder: String = "Поиск"
        static let searchBarCancelButtonTitle: String = "Отменить"
        static let searchBarCancelButtonKey: String = "cancelButtonText"
        static let navigationBarTitle: String = "Настройки"
        
        static let profileName: String = "Илья Волков"
        static let profileDetailedTitle: String = "Apple ID, iCloud, контент и покупки"
        static let airplaneCellTitle: String = "Авиарежим"
        static let wifiCellTitle: String = "Wi-Fi"
        static let informerTitleNotConnected: String = "Не подключено"
        static let bluetoothCellTitle: String = "Bluetooth"
        static let bluetoothInformerTitle: String = "Выкл."
        static let cellularCellTitle: String = "Сотовая связь"
        static let modemCellTitle: String = "Режим модема"
        static let vpnCellTitle: String = "VPN"
        
        static let notificationsCellTitle: String = "Уведомления"
        static let soundsCellTitle: String = "Звуки, тактильные сигналы"
        static let focusCellTitle: String = "Фокусирование"
        static let screenTimeCellTitle: String = "Экранное время"
        
        static let mainCellTitle: String = "Основные"
        static let commandCenterCellTitle: String = "Пункт управления"
        static let brightnessCellTitle: String = "Экран и яркость"
        static let screenHomeCellTitle: String = "Экран «Домой»"
        static let universalAccessCellTitle: String = "Универсальный доступ"
        static let wallpaperCellTitle: String = "Обои"
        static let siriCellTitle: String = "Siri и Поиск"
        static let faceIDCellTitle: String = "Face ID и код-пароль"
        static let sosCellTitle: String = "Экстренный вызов -- SOS"
        static let contactCellTitle: String = "Уведомления о контакте"
        static let batteryCellTitle: String = "Аккумулятор"
        static let confidentialityCellTitle: String = "Конфиденциальность"
        
        static let appstoreCellTitle: String = "App Store"
        static let walletCellTitle: String = "Wallet и Apple Pay"
        
        static let passwordsCellTitle: String = "Пароли"
        static let mailCellTitle: String = "Почта"
        static let contactsCellTitle: String = "Контакты"
        static let calendarCellTitle: String = "Календарь"
        static let notesCellTitle: String = "Заметки"
        static let remindersCellTitle: String = "Напоминания"
        static let recorderCellTitle: String = "Диктофон"
        static let phoneCellTitle: String = "Телефон"
        static let messageCellTitle: String = "Сообщения"
        static let faceTimeCellTitle: String = "FaceTime"
        static let safariCellTitle: String = "Safari"
        static let stockCellTitle: String = "Акции"
        static let weatherCellTitle: String = "Погода"
        static let translateCellTitle: String = "Перевод"
        static let mapsCellTitle: String = "Карты"
        static let compassCellTitle: String = "Компас"
        static let rouletteCellTitle: String = "Рулетка"
        static let quickCommandsCellTitle: String = "Быстрые команды"
        static let healtCellTitle: String = "Здоровье"
        
        static let musicCellTitle: String = "Музыка"
        static let tvCellTitle: String = "TV"
        static let photoCellTitle: String = "Фото"
        static let cameraCellTitle: String = "Камера"
        static let bookCellTitle: String = "Книги"
        static let podcastsCellTitle: String = "Подкасты"
        static let gameCenterCellTitle: String = "Game Center"
    }
    
    enum Icons {
        static let profileIcon: String = "profile.image"
        static let airplaneIcon: String = "airplane.mode"
        static let wifiIcon: String = "wifi"
        static let bluetoothIcon: String = "bluetooth"
        static let cellularIcon: String = "cellular"
        static let modemIcon: String = "modem"
        static let vpnIcon: String = "vpn"
        
        static let notificationsIcon: String = "notifications"
        static let soundsIcon: String = "sounds"
        static let focusIcon: String = "focus"
        static let screenTimeIcon: String = "screen.time"
        
        static let mainIcon: String = "main"
        static let commandCenterIcon: String = "command.center"
        static let brightnessIcon: String = "screen.and.brightness"
        static let screenHomeIcon: String = "screen.home"
        static let universalAccessIcon: String = "universal.access"
        static let wallpaperIcon: String = "wallpaper"
        static let siriIcon: String = "siri"
        static let faceIDIcon: String = "faceid"
        static let sosICon: String = "SOS"
        static let contactIcon: String = "contact"
        static let batteryIcon: String = "battery"
        static let confidentialityIcon: String = "confidentiality"
        
        static let appstoreIcon: String = "appstore"
        static let walletIcon: String = "wallet"
        
        static let passwordsIcon: String = "passwords"
        static let mailIcon: String = "mail"
        static let contactsIcon: String = "contacts"
        static let calendarIcon: String = "calendar"
        static let notesIcon: String = "notes"
        static let remindersIcon: String = "reminders"
        static let recorderIcon: String = "recorder"
        static let phoneIcon: String = "telephone"
        static let messageIcon: String = "message"
        static let faceTimeIcon: String = "facetime"
        static let safariIcon: String = "safari"
        static let stockIcon: String = "stock"
        static let weatherIcon: String = "weather"
        static let translateIcon: String = "translate"
        static let mapsIcon: String = "maps"
        static let compassIcon: String = "compass"
        static let rouletteIcon: String = "roulette"
        static let quickCommandsIcon: String = "quick.commands"
        static let healthIcon: String = "health"
        
        static let musicIcon: String = "music"
        static let tvIcon: String = "tv"
        static let photoIcon: String = "photo"
        static let cameraIcon: String = "camera"
        static let bookIcon: String = "books"
        static let podcastsIcon: String = "podcasts"
        static let gameCenterIcon: String = "game.center"
    }
    
    enum Color {
        static let navigationItemColor = UIColor(rgb: 0xF2F1F7)
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

