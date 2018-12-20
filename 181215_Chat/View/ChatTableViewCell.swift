//
//  ChatTableViewCell.swift
//  181215_Chat
//
//  Created by Рабочий on 15/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import UIKit
import InitialsImageView

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastMessageTextLabel: UILabel!
    @IBOutlet weak var lastMessageDateLabel: UILabel!
    
    var viewModel: ChatTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            avatarImageView.setImageForName(viewModel.userName,
                                            circular: true,
                                            textAttributes: nil)
            userNameLabel.text = viewModel.userName
            lastMessageDateLabel.text = viewModel.lastMessageDatePrettyPrinted
            lastMessageTextLabel.text = viewModel.lastMessageTitle
        }
    }
}

