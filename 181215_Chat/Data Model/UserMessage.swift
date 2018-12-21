//
//  UserMessage.swift
//  181215_Chat
//
//  Created by Рабочий on 15/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation
import MessageKit

struct UserMessage {
    let id: Int
    let text: String
    let date: Date
    let user: User
}

extension UserMessage: MessageType {
    var sender: Sender {
        return Sender(id: "\(user.id)", displayName: user.name)
    }
    
    var messageId: String {
        return "\(id)"
    }
    
    var sentDate: Date {
        return date
    }
    
    var kind: MessageKind {
        return MessageKind.text(text)
    }
    
    
}
