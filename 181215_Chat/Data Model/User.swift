//
//  User.swift
//  181215_Chat
//
//  Created by Рабочий on 15/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let name: String
}

class SelfUser {
    static let user = User(id: 0, name: "Aleksey Poponin")
}
