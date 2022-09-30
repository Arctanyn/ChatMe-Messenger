//
//  ChatsViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import UIKit

final class ChatsViewController: CMBaseController, ViewModelable {
    
    typealias ViewModel = ChatsViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.getChats {
                
            }
        }
    }
    
    //MARK: - Views
    
    private lazy var chatsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        return tableView
    }()

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

@objc private extension ChatsViewController {
    func createNewChat() {
        viewModel.startNewChat()
    }
}

//MARK: - Private methods

private extension ChatsViewController {
    func setupNavigationBar() {
        title = Resources.Strings.TabBar.chats
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Resources.Images.squareAndPencil,
            style: .plain,
            target: self,
            action: #selector(createNewChat)
        )
    }
}

//MARK: - UITableViewDataSource

extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension ChatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
