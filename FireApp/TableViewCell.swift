//
//  TableViewCell.swift
//  FireApp
//
//  Created by KO on 23.08.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit
import  FirebaseDatabase
import  FirebaseStorage
class TableViewCell: UITableViewCell {

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var imageViewP: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    var post: Post!
    var likesRef: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        self.roundView.layer.cornerRadius = 10.0
        self.infoView.layer.cornerRadius = 5.0
        self.imageViewP.layer.cornerRadius = self.imageViewP.bounds.width / 2
        self.infoView.layer.borderWidth = 2.0
        self.infoView.layer.borderColor = UIColor.yellow.cgColor
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
        self.postLabel.text = post.text
        self.likesLabel.text = "\(post.likes)"
        imageViewP.downloadedFrom(link: post.imageUrl)
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
