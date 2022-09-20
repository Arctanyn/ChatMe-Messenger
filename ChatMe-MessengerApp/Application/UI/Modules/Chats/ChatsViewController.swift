//
//  ChatsViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import UIKit
import FirebaseDatabase

final class ChatsViewController: CMBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Resources.Strings.TabBar.chats
//
//        let database = Database.database().reference()
//
//        database.child("foo").setValue(["some": true])
    }
}
