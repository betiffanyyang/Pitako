//
//  Comment.swift
//  body positivity
//
//  Created by Sophia Yang on 2023-03-11.
//

import Foundation
import Firebase

struct Comment {
    let id: String
    let text: String
    let postID: String
    
    init?(dict: [String: Any], postID: String) {
        guard let id = dict["id"] as? String,
              let text = dict["text"] as? String else {
            return nil
        }
        
        self.id = id
        self.text = text
        self.postID = postID
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "text": text,
            "postID": postID
        ]
    }
}
