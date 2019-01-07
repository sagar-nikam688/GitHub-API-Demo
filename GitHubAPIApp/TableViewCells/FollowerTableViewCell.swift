//
//  FollowerTableViewCell.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 07/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var userIDLabel : UILabel!
    @IBOutlet var descLabel : UILabel!
    @IBOutlet var profileImgView : UIImageView!

    var userInfoObjectModel : UserInfoObjectModel? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(indexPath: IndexPath, userInfoModel : UserInfoObjectModel) {
        userInfoObjectModel = userInfoModel
        if userInfoObjectModel?.avatar_url != "" {
            if let postURL = URL(string: (userInfoModel.avatar_url)) {
                profileImgView.load(url: postURL )
            }
        } else {
            
        }
        nameLabel.text = userInfoObjectModel?.loginUserID != "" ? userInfoObjectModel?.loginUserID : "Not available"
        userIDLabel.text = userInfoObjectModel?.loginUserID != "" ? userInfoObjectModel?.loginUserID : "Not available"
        descLabel.text = "GitHub Url:" + (userInfoObjectModel?.html_url)! != "" ? (userInfoObjectModel?.html_url)! : "Not available"
    }
    
}
