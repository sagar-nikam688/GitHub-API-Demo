//
//  InfoTableViewCell.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 07/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var descLabel : UILabel!
    
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
        
        switch (indexPath.row) {
        case 0:
            titleLabel.text = "Bio:"
            descLabel.text = userInfoObjectModel?.bio != "" ? userInfoObjectModel?.bio : "Not available"
            break
        case 1:
            titleLabel.text = "Location:"
            descLabel.text = userInfoObjectModel?.location != "" ? userInfoObjectModel?.location : "Not available"

            break
        case 2:
            titleLabel.text = "Email:"
            descLabel.text = userInfoObjectModel?.email  != "" ? userInfoObjectModel?.email : "Not available"

            break
        case 3:
            titleLabel.text = "Company:"
            descLabel.text = userInfoObjectModel?.company  != "" ? userInfoObjectModel?.company : "Not available"
            break
        case 4:
            titleLabel.text = "Updated at:"
            descLabel.text = userInfoObjectModel?.updated_at  != "" ? userInfoObjectModel?.updated_at : "Not available"
            break
        default:
            break
        }
        

        
    }
    
}
