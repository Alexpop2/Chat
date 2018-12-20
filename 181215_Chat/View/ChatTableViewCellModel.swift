//
//  ChatTableViewCellModel.swift
//  181215_Chat
//
//  Created by Рабочий on 15/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

protocol ChatTableViewCellModel {
    var userName: String { get }
    var lastMessageTitle: String { get }
    var lastMessageDatePrettyPrinted: String { get }
}
