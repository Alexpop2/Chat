//
//  Chat.swift
//  181215_Chat
//
//  Created by Рабочий on 15/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

struct Chat {
    let id: Int
    let user: User
    let messages: [UserMessage]
    
    var prettyDescription: String {
        return user.name + " " + (messages.last?.text ?? "")
    }
}

extension Chat: ChatTableViewCellModel {
    var userName: String {
        return user.name
    }
    
    var lastMessageTitle: String {
        return messages.last?.text ?? ""
    }
    
    // TODO: - Сконвертировать в нормальный формат
    
    var lastMessageDatePrettyPrinted: String {
        return messages.last?.date.description ?? ""
    }
    
    
}
