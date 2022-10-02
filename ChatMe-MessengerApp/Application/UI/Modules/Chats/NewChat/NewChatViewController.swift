//
//  NewChatViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import UIKit

final class NewChatViewController: CMBaseController, ViewModelable {

    typealias ViewModel = NewChatViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel!
    
    //MARK: - Views
    
    private lazy var usersSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: UsersSearchResultsViewController())
        searchController.searchBar.tintColor = .label
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.pageDidClose()
    }
    
    //MARK: - Methods
    
    override func configureAppearance() {
        setupNavigationBar()
        view.backgroundColor = .systemBackground
    }
    
    override func setupViews() {
        usersSearchController.searchBar.delegate = self
    }
}

//MARK: - Actions

@objc private extension NewChatViewController {
    func closeButtonPressed() {
        viewModel.closePage()
    }
}

//MARK: - Private methods

private extension NewChatViewController {
    func setupNavigationBar() {
        title = "Start Chatting"
        navigationController?.navigationBar.tintColor = .darkGray
        navigationItem.searchController = usersSearchController
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Resources.Images.xMark, style: .plain, target: self, action: #selector(closeButtonPressed))
    }
}

extension NewChatViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedSearchText.isEmpty,
              trimmedSearchText.count >= 2
        else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.viewModel.searchUser(query: searchText) {
                guard let searchResultsController = self?.usersSearchController.searchResultsController as? UsersSearchResultsViewController else { return }
                searchResultsController.viewModel = self?.viewModel.createSearchResultsViewModel()
            }
        }
    }
}
