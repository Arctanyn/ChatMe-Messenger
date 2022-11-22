//
//  ChatViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

final class ChatViewController: MessagesViewController, ViewModelable {
    
    typealias ViewModel = ChatViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.fetchMessages()
            viewModel.messages.bind { [weak self] in
                DispatchQueue.main.async {
                    self?.messagesCollectionView.reloadData()
                    self?.messagesCollectionView.scrollToLastItem()
                }
            }
        }
    }
    
    private var isChatDisplayed = false {
        didSet {
            self.messagesCollectionView.isHidden = false
        }
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    
    //MARK: - Views
    
    private lazy var chatTitleView = ChatTitleView()
    
    private lazy var attachButton: InputBarButtonItem = {
        let button = InputBarButtonItem(type: .system)
        button.image = Resources.Images.paperclip
        button.tintColor = Resources.Colors.active
        button.setSize(CGSize(width: 40, height: 40), animated: false)
        button.addTarget(self, action: #selector(attachButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - View Controller Lyfecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.backToChats()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        setupViews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let messagesCount = viewModel.messages.value.count
        
        guard
            collectionView.numberOfSections == messagesCount,
            indexPath.section == 0,
            !isChatDisplayed
        else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.messagesCollectionView.scrollToItem(
                at: IndexPath(
                    item: 0,
                    section: messagesCount - 1
                ),
                at: .bottom,
                animated: false
            )
            self?.isChatDisplayed = true
        }
        
    }
}

//MARK: - Actions

@objc private extension ChatViewController {
    func attachButtonTapped() {
        present(imagePickerController, animated: true)
    }
}

//MARK: - Private methods

private extension ChatViewController {
    func setupViews() {
        view.backgroundColor = Resources.Colors.background
        showMessageTimestampOnSwipeLeft = true
        
        chatTitleView.configure(
            username: viewModel.recipientName,
            profileImage: UIImage.profileImage(from: viewModel.recipientProfileImageData)
        )
        navigationItem.titleView = chatTitleView
        
        setupMessagesCollectionView()
        setupInputBar()
    }
    
    func setupMessagesCollectionView() {
        messagesCollectionView.isHidden = true
        messagesCollectionView.backgroundColor = Resources.Colors.background
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    func setupInputBar() {
        messageInputBar.backgroundView.backgroundColor = Resources.Colors.secondary
        messageInputBar.delegate = self
        
        messageInputBar.sendButton.image = Resources.Images.send
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.makeSystem()
        
        messageInputBar.setLeftStackViewWidthConstant(to: 40, animated: false)
        messageInputBar.setStackViewItems([attachButton], forStack: .left, animated: false)
    }
    
    func isCurrentSender(_ sender: SenderType) -> Bool {
        return sender.senderId == currentSender().senderId
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ChatViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        viewModel.sendMessage(kind: .photo(
            Media(
                placeholderImage: image,
                size: image.chatSize
            )
        ))
        picker.dismiss(animated: true)
    }
}

//MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource {
    func currentSender() -> MessageKit.SenderType {
        Sender(senderId: viewModel.senderId, displayName: viewModel.senderName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        viewModel.messages.value[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        viewModel.messages.value.count
    }
    
}

//MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: messagesCollectionView.bounds.width, height: 10)
    }
}

//MARK: - MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isCurrentSender(message.sender) ? Resources.Colors.active : Resources.Colors.secondary
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if isCurrentSender(message.sender) {
            avatarView.image = UIImage.profileImage(from: viewModel.senderProfileImageData)
        } else {
            avatarView.image = UIImage.profileImage(from: viewModel.recipientProfileImageData)
        }
    }
}

//MARK: - InputBarAccessoryViewDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        messageInputBar.inputTextView.text = nil
        viewModel.sendMessage(kind: .text(text.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
}
