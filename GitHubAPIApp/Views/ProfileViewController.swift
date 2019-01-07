//
//  ProfileViewController.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 04/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileViewController: UIViewController {
    
    @IBOutlet var followersAndsearchUserSegment : UISegmentedControl!
    @IBOutlet var tableview : UITableView!
    
    
    var responseData : NSDictionary? = [:]
    var userInfoObjectModel : UserInfoObjectModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        self.tableview.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        //To display tabs De-Selected
        let jsonObject = JSON(responseData as Any)
        self.userInfoObjectModel = UserInfoObjectModel(modelJSON: jsonObject)
        setUpViewCall()
    }
    func setUpViewCall(){
        self.tableview.separatorColor = UIColor.clear
        tableview.reloadData()
    }
    
    
    @IBAction func segmentTypeValueChangeAction(_ sender: Any) {
        if followersAndsearchUserSegment.selectedSegmentIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
            vc.userID = (self.userInfoObjectModel?.loginUserID)!
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        headerCell.contentView.backgroundColor = UIColor.black
        headerCell.setupCell(userInfoModel: self.userInfoObjectModel!)
        return headerCell.contentView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoTableViewCell = tableview.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        cell.setupCell(indexPath: indexPath,userInfoModel: self.userInfoObjectModel!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell: InfoTableViewCell = tableview.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell

        switch (indexPath.row) {
            
        case 0:
            return userInfoObjectModel?.bio != "" ? AppUtility.heightForView(text: (userInfoObjectModel?.bio)!, width: cell.descLabel.bounds.width) + 20 : 40
        case 1:
            return userInfoObjectModel?.location != "" ? AppUtility.heightForView(text: (userInfoObjectModel?.location)!,  width: cell.descLabel.bounds.width) + 16 : 36
        case 2:
            return userInfoObjectModel?.email != "" ? AppUtility.heightForView(text: (userInfoObjectModel?.email)!, width: cell.descLabel.bounds.width) + 16 : 36
        case 3:
            return userInfoObjectModel?.company != "" ? AppUtility.heightForView(text: (userInfoObjectModel?.company)!, width: cell.descLabel.bounds.width) + 16 : 36
        case 4:
            return userInfoObjectModel?.updated_at != "" ? AppUtility.heightForView(text: (userInfoObjectModel?.updated_at)!,width: cell.descLabel.bounds.width) + 16 : 36
        default:
            return 50
        }

    }

}

class UserInfoObjectModel {
    var loginUserID : String
    var id: String
    var node_id: String
    var avatar_url : String
    var url : String
    var html_url: String
    var followers_url : String
    var following_url : String
    var gists_url : String
    var starred_url: String
    var subscriptions_url : String
    var organizations_url : String
    var repos_url : String
    var events_url : String
    var received_events_url : String
    var userName : String
    var company: String
    var bio  : String
    var location   : String
    var email  : String
    var blog : String
    var public_repos: NSNumber
    var public_gists   : NSNumber
    var followers: NSNumber
    var following   : NSNumber
    var updated_at : String
    
    init(modelJSON: JSON ) {
        loginUserID = modelJSON["login"].string == nil ? "" :  modelJSON["login"].string!
        id = modelJSON["id"].string == nil ? "" :  modelJSON["id"].string!
        node_id = modelJSON["node_id"].string == nil ? "" :  modelJSON["node_id"].string!
        avatar_url = modelJSON["avatar_url"].string == nil ? "" :  modelJSON["avatar_url"].string!
        url = modelJSON["url"].string == nil ? "" :  modelJSON["url"].string!
        html_url = modelJSON["html_url"].string == nil ? "" :  modelJSON["html_url"].string!
        followers_url = modelJSON["followers_url"].string == nil ? "" :  modelJSON["followers_url"].string!
        following_url = modelJSON["following_url"].string == nil ? "" :  modelJSON["following_url"].string!
        gists_url = modelJSON["gists_url"].string == nil ? "" :  modelJSON["gists_url"].string!
        starred_url = modelJSON["starred_url"].string == nil ? "" :  modelJSON["starred_url"].string!
        subscriptions_url = modelJSON["subscriptions_url"].string == nil ? "" :  modelJSON["subscriptions_url"].string!
        organizations_url = modelJSON["organizations_url"].string == nil ? "" :  modelJSON["organizations_url"].string!
        repos_url = modelJSON["repos_url"].string == nil ? "" :  modelJSON["repos_url"].string!
        events_url = modelJSON["events_url"].string == nil ? "" :  modelJSON["events_url"].string!
        received_events_url = modelJSON["received_events_url"].string == nil ? "" :  modelJSON["received_events_url"].string!
        userName = modelJSON["name"].string == nil ? "" :  modelJSON["name"].string!
        company = modelJSON["company"].string == nil ? "" :  modelJSON["company"].string!
        blog = modelJSON["blog"].string == nil ? "" :  modelJSON["blog"].string!
        location = modelJSON["location"].string == nil ? "" :  modelJSON["location"].string!
        bio = modelJSON["bio"].string == nil ? "" :  modelJSON["bio"].string!
        email = modelJSON["email"].string == nil ? "" :  modelJSON["email"].string!
        public_repos = modelJSON["public_repos"].number == nil ? 0 :  modelJSON["public_repos"].number!
        public_gists = modelJSON["public_gists"].number == nil ? 0 :  modelJSON["public_gists"].number!
        followers = modelJSON["followers"].number == nil ? 0 :  modelJSON["followers"].number!
        following = modelJSON["following"].number == nil ? 0 :  modelJSON["following"].number!
        updated_at = modelJSON["updated_at"].string == nil ? "" :  modelJSON["updated_at"].string!
    }
}


