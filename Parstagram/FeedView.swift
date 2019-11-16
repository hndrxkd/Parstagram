//
//  FeedView.swift
//  Parstagram
//
//  Created by Kevin Denis on 11/15/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class FeedView: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var postTable: UITableView!
    var Posts = [PFObject]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, Error) in
            if (posts != nil){
                self.Posts = posts!
                self.postTable.reloadData()
            }else{
                print("Error: \(Error?.localizedDescription)")
            }
    }
       
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

    DataRequest.addAcceptableImageContentTypes(["application/octet-stream"])
        postTable.dataSource = self
        postTable.delegate = self
        postTable.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = Posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.authorLabel.text = user.username
        cell.commentLabel.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url as! String
        let url = URL(string: urlString)!
        
        cell.postPicView.af_setImage(withURL: url)
        
        return cell
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
