//
//  MainVC.swift
//  FireApp
//
//  Created by KO on 23.08.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit
import FirebaseDatabase
class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
 var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        DataService.ds.REF_POSTS.observe(.value, with:{ (snapshot) in
            self.posts = [] 
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
            
        })
        // Do any additional setup after loading the view.
    }

  
}
extension MainVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? TableViewCell {
            
            cell.configureCell(post: post)
            return cell
        } else {
            return TableViewCell()
        }
    }
    
    
}
extension MainVC : UITableViewDelegate {
    
}
