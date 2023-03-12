//
//  Post.swift
//  body positivity
//
//  Created by Sophia Yang on 2023-03-11.
//

import Foundation
import Firebase

struct Post {
    let postID: String
    let text: String
    var comments: [Comment]?
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
              let postID = dict["postID"] as? String,
              let text = dict["text"] as? String else {
            return nil
        }
        self.postID = postID
        self.text = text
        
        if let commentsDict = dict["comments"] as? [String: Any] {
            var commentsArray = [Comment]()
            for (_, value) in commentsDict {
                if let commentDict = value as? [String: Any],
                   let comment = Comment(dict: commentDict, postID: postID) {
                    commentsArray.append(comment)
                }
            }
            self.comments = commentsArray
        }
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "postID": postID,
            "text": text
        ]
        if let comments = comments {
            var commentsDictionary = [String: Any]()
            for (index, comment) in comments.enumerated() {
                commentsDictionary["comment\(index+1)"] = comment.toDictionary()
            }
            dictionary["comments"] = commentsDictionary
        }
        return dictionary
    }
}
