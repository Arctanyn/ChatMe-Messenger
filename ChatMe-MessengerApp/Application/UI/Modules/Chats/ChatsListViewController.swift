//
//  ChatsListViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import UIKit

final class ChatsListViewController: CMBaseController, ViewModelable {
    
    typealias ViewModel = ChatsListViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.getChats()
            viewModel.chats.bind { [weak self] in
                self?.chatsTableView.reloadData()
            }
        }
    }
    
    //MARK: - Views
    
    private lazy var chatsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatsTableView.reloadData()
    }

    //MARK: - Methods
    
    override func configureAppearance() {
        super.configureAppearance()
        setupNavigationBar()
    }
    
    override func setupViews() {
        view.addSubview(chatsTableView, useConstraints: true)
        chatsTableView.dataSource = self
        chatsTableView.delegate = self
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            chatsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chatsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chatsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - Actions

@objc private extension ChatsListViewController {
    func createNewChat() {
        viewModel.startNewChat()
    }
}

//MARK: - Private methods

private extension ChatsListViewController {
    func setupNavigationBar() {
        title = Resources.Strings.TabBar.chats
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Resources.Images.squareAndPencil,
            style: .plain,
            target: self,
            action: #selector(createNewChat)
        )
    }
    
    func showAlertForDeleteChatWithUser(at indexPath: IndexPath) {
        let alert = UIAlertController(
            title: nil,
            message: Resources.Strings.toDeleteChat(with: viewModel.usernameForChat(at: indexPath)),
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: "Delete chat", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteChat(at: indexPath)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension ChatsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.chats.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.viewModel = self.viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ChatsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.goToChatWithUser(at: indexPath)
    }
    
    func swipeToDeleteCell(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            self?.showAlertForDeleteChatWithUser(at: indexPath)
            completion(true)
        }
        action.image = Resources.Images.trash
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = swipeToDeleteCell(at: indexPath)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
