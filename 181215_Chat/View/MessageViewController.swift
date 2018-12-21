//
//  MessageViewController.swift
//  181215_Chat
//
//  Created by Рабочий on 21/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    var chat: Chat?
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = chat?.user.name ?? ""
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
