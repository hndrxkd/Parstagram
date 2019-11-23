//
//  FeedView.swift
//  Parstagram
//
//  Created by Kevin Denis on 11/15/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//
// TODO: Change add a comment cell to model instead the instagram app
// TODO: Add likes feature
// TODO: Commenting in seperate view
// TODO: Big one, create DMs, modeling a chat app


import UIKit
import Parse
import Alamofire
import MessageInputBar

class FeedView: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate{

    @IBOutlet weak var postTable: UITableView!
    var Posts = [PFObject]()
    var ShowsCommmentBar = false
    let CommentBar = MessageInputBar()
    var selectedPost: PFObject!
    
  // MARK: - Configuring table view and cells
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author" , "comments" , "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, Error) in
            if (posts != nil) {
                self.Posts = posts!
                self.postTable.reloadData()
            } else {
                print("Error: \(Error?.localizedDescription as Optional)")
            }
    }
        
}
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataRequest.addAcceptableImageContentTypes(["application/octet-stream"])
        postTable.dataSource = self
        postTable.delegate = self
        postTable.reloadData()
        
        CommentBar.inputTextView.placeholder = "Post"
        CommentBar.delegate = self
        
        
        postTable.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = Posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = Posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let user = post["author"] as! PFUser
        cell.authorLabel.text = user.username
        cell.commentLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.postPicView.af_setImage(withURL: url)
            
        return cell
        }else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            let comment = comments[indexPath.row - 1]
            cell.CommentLabel.text = comment["text"] as? String
            
            let user = comment["author"] as! PFUser
            cell.CommentAuthorLabel.text = user.username
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddComment")!
            return cell
        }
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let post = Posts[indexPath.row]
            let comments = (post["comments"] as? [PFObject]) ?? []
            
            print(indexPath.row)
            print(comments.count)
            if indexPath.row == comments.count + 1{
                ShowsCommmentBar = true
                becomeFirstResponder()
                CommentBar.inputTextView.becomeFirstResponder()
                selectedPost = post
                
            }
        }

    
    
    // MARK:- Configuring Buttons
    
    @IBAction func onLogOut(_ sender: Any) {
         let main = UIStoryboard(name: "Main", bundle: nil)
        
         let LoginViewController = main.instantiateViewController(identifier: "LoginViewController")
         let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
         delegate.window?.rootViewController = LoginViewController
         
         PFUser.logOut()
         
     }
    
   



// MARK: - InputBar Configuration
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let comment = PFObject(className: "comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()
        selectedPost.add(comment, forKey: "comments")
        selectedPost.saveInBackground { (success, Error) in
        if(success){
            print("Comment saved!")
        }else{
            print("Error saving comment.")
            print("Error: \(Error?.localizedDescription as Optional)")
        }
            
        self.postTable.reloadData()
            
        self.CommentBar.inputTextView.text = nil
        self.ShowsCommmentBar = false
        self.becomeFirstResponder()
    }
}
    
    @objc func keyboardWillBeHidden(note: Notification){
           CommentBar.inputTextView.text = nil
           ShowsCommmentBar = false
           becomeFirstResponder()
       }
    
    override var inputAccessoryView: UIView?{
        return CommentBar
    }

    override var canBecomeFirstResponder: Bool{
        return ShowsCommmentBar
    }
}
