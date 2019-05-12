//
//  CurrentUser.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/9/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

struct CurrentUser {
   
    //let uid: String
    let name: String
    let email: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        //self.uid = uid
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
}
