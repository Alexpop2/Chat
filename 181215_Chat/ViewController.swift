//
//  ViewController.swift
//  181215_Chat
//
//  Created by Рабочий on 15/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import UIKit

// MARK: - Properties & Lifecycle

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let kChatTableViewCellNib = UINib(nibName: "ChatTableViewCell", bundle: nil)
    private let kChatTableViewCellReuseIdentifier = "kChatTableViewCellNib"
    
    private var dataSource = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let chatFactory = ChatFactory()
        dataSource = chatFactory.fakeChats(number: 30)
        setUpUI()
    }


}

// MARK: - Set Up UI

extension ViewController {
    private func setUpUI() {
        tableView.register(kChatTableViewCellNib,
                           forCellReuseIdentifier: kChatTableViewCellReuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource Implementation

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier: kChatTableViewCellReuseIdentifier,
                                          for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = dataSource[indexPath.row]
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate Implementation

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToChat", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Prepare for segue

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChat" {
            guard let rowIndex = tableView.indexPathForSelectedRow?.row else {
                return
            }
            (segue.destination as! MessageViewController).chat = dataSource[rowIndex]
            (segue.destination as! MessageViewController).delegate = self
        }
    }
}

// MARK: - Update Chat

extension ViewController: MessageViewControllerDelegate {
    func updateChat(chat: Chat) {
        guard let chatIndex = dataSource.firstIndex( where: {$0.id == chat.id} ) else {
            return
        }
        dataSource.remove(at: chatIndex)
        dataSource.append(chat)
        dataSource.sort { $0.messages.last?.date ?? Date() > $1.messages.last?.date ?? Date() }
        tableView.reloadData()
    }
}
