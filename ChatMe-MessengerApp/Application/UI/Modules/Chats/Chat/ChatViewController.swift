//
//  ChatViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}

final class ChatViewController: MessagesViewController, ViewModelable {

    typealias ViewModel = ChatViewModel
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.fetchMessages()
            viewModel.messages.bind { [weak self] in
                guard let self else { return }
                self.messagesCollectionView.reloadData()
            }
        }
    }

    //MARK: - View Controller Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.recipientName
        setupViews()
    }
}

//MARK: - Private methods

private extension ChatViewController {
    func setupViews() {
        view.backgroundColor = Resources.Colors.background
        scrollsToLastItemOnKeyboardBeginsEditing = true
        showMessageTimestampOnSwipeLeft = true
        
        setupMessagesCollectionView()
        setupInputBar()
    }
    
    func setupMessagesCollectionView() {
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
    }
    
    func isCurrentSender(_ sender: SenderType) -> Bool {
        return sender.senderId == currentSender().senderId
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
        messagesCollectionView.scrollToLastItem()
    }
}
