//
//  SecondViewController.swift
//  body positivity
//
//  Created by Sophia Yang on 2023-03-11.
//

import UIKit
import Firebase

class SecondViewController: UIViewController {

    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func submitPost(_ sender: Any) {
        guard let postText = postTextField.text else {
            return
        }
        
        let postID = UUID().uuidString
        let postDict: [String: Any] = ["postID": postID, "text": postText]
        
        let postsRef = Database.database().reference().child("posts")
        let newPostRef = postsRef.childByAutoId()
        newPostRef.setValue(postDict) { [weak self] (error, ref) in
            if let error = error {
                print("Failed to create new post: \(error.localizedDescription)")
            } else {
                newPostRef.observeSingleEvent(of: .value) { (snapshot) in
                    if let postSnapshot = snapshot.children.allObjects.first as? DataSnapshot {
                        if let newPost = Post(snapshot: postSnapshot) {
                            // Analyze the sentiment of the message/story provided by the user
                            analyzeSentiment(postText: newPost.text, apiKey: "It4xndmyI28QBE8E3lhbNiNNjUxaPxYqd8b0RnD0") { sentiment in
                                if let sentiment = sentiment, sentiment == "negative" {
                                    // Delete the post if the Sentiment Analysis detects negativity
                                    newPostRef.removeValue()
                                } else {
                                    //self?.navigationController?.popViewController(animated: true)
                                }
                            }
                        } else {
                            
                        }
                    }
                }
            }
        }
    }
}









