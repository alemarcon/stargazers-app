//
//  StargazerTableViewCell.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import UIKit
import SDWebImage

class StargazerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var starredAt: UILabel!
    
    static let IDENTIFIER = "stargazer_cell"
    static let XIB_NAME = "StargazerCell"
    static let DEFAULT_HEIGHT: CGFloat = 87.0

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override func prepareForReuse() {
        userImage.image = UIImage(named: "default_user")
        username.text = ""
        starredAt.text = ""
    }
    
    func bind(stargazer: Stargazer) {
        self.isUserInteractionEnabled = false
        
        if let imageUrl = URL(string: stargazer.avatarUrl) {
            let roundTrasformer = SDImageRoundCornerTransformer(radius: 30, corners: .allCorners, borderWidth: 0, borderColor: nil)
            userImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "default_user"), options: [.progressiveLoad], context: [.imageTransformer:roundTrasformer])
        }
        
        username.text = stargazer.username
        starredAt.text = stargazer.starredAt
    }

}
