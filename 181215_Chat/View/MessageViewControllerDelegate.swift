//
//  MessageViewControllerDelegate.swift
//  181215_Chat
//
//  Created by Рабочий on 21/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

// MARK: - Callback for chats updating

protocol MessageViewControllerDelegate: class {
    func updateChat(chat: Chat)
}
