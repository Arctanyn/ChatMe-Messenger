//
//  UsersSearchResultsViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import UIKit

final class UsersSearchResultsViewController: CMBaseController, ViewModelable {

    typealias ViewModel = UsersSearchResultsViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            usersTableView.reloadData()
        }
    }
    
    //MARK: - Views
    
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    //MARK: - Methods
    
    override func setupViews() {
        view.addSubview(usersTableView, useConstraints: true)
        usersTableView.dataSource = self
        usersTableView.delegate = self
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func configureAppearance() {
        view.backgroundColor = .systemBackground
    }
}

//MARK: - UITableViewDataSource

extension UsersSearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.numberOfResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension UsersSearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}
