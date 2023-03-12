//
//  ViewController.swift
//  body positivity
//
//  Created by Sophia Yang on 2023-03-11.
//
import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [Post]()
    let cellReuseIdentifier = "cell"
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let postsRef = Database.database().reference().child("posts")
        
        // The observer is what detects changes in the data
        postsRef.observe(.value, with: { snapshot in
            var newPosts = [Post]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let post = Post(snapshot: snapshot) {
                    newPosts.append(post)
                }
            }
            
            self.posts = newPosts
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let post = posts[indexPath.row]
        
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "Comments: \(post.comments?.count ?? 0)"
        
        return cell
    }

}

