//
//  ViewController.swift
//  SettingsTableViewLayout
//
//  Created by Ilya Volkov on 28.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
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
        
        return tableView
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHiearchy()
        setupLayout()
        setupView()
        
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

