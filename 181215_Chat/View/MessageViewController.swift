//
//  MessageViewController.swift
//  181215_Chat
//
//  Created by Рабочий on 21/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar
import InitialsImageView
import Fakery

// MARK: - Chat screen controller

class MessageViewController: MessagesViewController {
    
    var chat: Chat?
    @IBOutlet weak var label: UILabel!
    weak var delegate: MessageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = chat?.user.name ?? ""
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: false)
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(
                                                self.keyboardNotification(notification:)),
                                               name: UIResponder
                                                .keyboardWillChangeFrameNotification,
                                               object: nil)
    }
}

// MARK: - Change avatars

extension MessageViewController {
    func configureAvatarView(_ avatarView: AvatarView,
                             for message: MessageType,
                             at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) {
        avatarView.setImageForName(message.sender.displayName,
                                   circular: true,
                                   textAttributes: nil)
    }
}

// MARK: - Keyboard notification observer

extension MessageViewController {
    @objc func keyboardNotification(notification: NSNotification) {
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
}

// MARK: - Insert message

extension MessageViewController {
    func insertMessage(_ message: UserMessage) {
        chat?.messages.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([(chat?.messages.count ?? 0) - 1])
            if (chat?.messages.count ?? 0) >= 2 {
                messagesCollectionView.reloadSections([(chat?.messages.count ?? 0) - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
        guard let chatUnwrapped = chat else {
            return
        }
        delegate?.updateChat(chat: chatUnwrapped)
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard (chat?.messages.isEmpty ?? false) else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: (chat?.messages.count ?? 0) - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
}

// MARK: - MessagesDataSource

extension MessageViewController: MessagesDataSource {
    func currentSender() -> Sender {
        return Sender(id: "\(SelfUser.user.id)", displayName: SelfUser.user.name)
    }
    
    func messageForItem(at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        guard let message = chat?.messages[indexPath.section] else {
            fatalError("Не найдено сообщение")
        }
        return message
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return chat?.messages.count ?? 0
    }
    
    
}

extension MessageViewController: MessagesLayoutDelegate {
    
}

extension MessageViewController: MessagesDisplayDelegate {
    
}

// MARK: - MessageInputBarDelegate
extension MessageViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let faker = Faker(locale: "ru")
        
        for component in inputBar.inputTextView.components {
            
            if let str = component as? String {
                let message = UserMessage(id: faker.number.randomInt(),
                                          text: str,
                                          date: Date(),
                                          user: SelfUser.user)
                insertMessage(message)
            }
        }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
}
