//
//  HeaderTableViewCell.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 07/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet var profileImgView : UIImageView!
    @IBOutlet var userNamelabel : UILabel!
    @IBOutlet var userIDLabel : UILabel!
    @IBOutlet var reposLabel : UILabel!
    @IBOutlet var followersLabel : UILabel!
    @IBOutlet var followeingLabel : UILabel!

    var userInfoObjectModel : UserInfoObjectModel? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(userInfoModel : UserInfoObjectModel) {
        userInfoObjectModel = userInfoModel
        if userInfoObjectModel?.avatar_url != "" {
            if let postURL = URL(string: (userInfoObjectModel?.avatar_url)!) {
                profileImgView.load(url: postURL )
            }
        } else {
            
        }
        userNamelabel.text  = userInfoObjectModel?.userName != "" ?  (userInfoObjectModel?.userName) : ""
        userIDLabel.text  = userInfoObjectModel?.loginUserID != "" ?  (userInfoObjectModel?.loginUserID) : ""
        reposLabel.text  = String(describing: userInfoObjectModel?.public_repos) != "" ?  String(describing: (userInfoObjectModel?.public_repos)!) : "0"
        followersLabel.text  = String(describing: userInfoObjectModel?.followers) != "" ?  String(describing: (userInfoObjectModel?.followers)!) : "0"
        followeingLabel.text  = String(describing: userInfoObjectModel?.following) != "" ?  String(describing: (userInfoObjectModel?.following)!) : "0"
    }
}
