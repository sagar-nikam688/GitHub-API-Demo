//
//  FollowersViewController.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 07/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import UIKit
import SwiftyJSON

class FollowersViewController: UIViewController {
    
    @IBOutlet var tableview : UITableView!
    var userID : String = ""
    var followersArray = [UserInfoObjectModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Followers"
        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tableview.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowerTableViewCell")
        // Do any additional setup after loading the view.
        self.getFollowers(userID:userID)
    }
    
    func getFollowers(userID : String) {
        showLoader()
        let urlStr = "https://api.github.com/users/" + "userID" + "/followers" + "?client_id=ed4000cb58fbfd9ebd7e&client_secret=d8e477237c49da7857593e50904f0dd4f3ef0473"
        NetworkHelper.shareWithPars(parameter: nil,method: .get, url: urlStr, completion: { (result) in
            self.dismissLoader()
            let getLoginInfo = JSON(result)
            let response = result
            if response.count > 1 {
                print(response)
                for responseData  in response {
                    let jsonObject = JSON(responseData as Any)
                    self.followersArray.append(UserInfoObjectModel(modelJSON: jsonObject))
                }
                self.tableview.reloadData()
            } else {
                if let message = getLoginInfo["message"].string {
                    self.showAlert(message: message, Title: "Error")
                }
            }
        }, completionError:  { (error) in
            self.dismissLoader()
            let errorResponse = error as NSDictionary
            if errorResponse.value(forKey: "errorType") as! NSNumber == 1 {
                self.showAlert(message: kNoInterNetMessage, Title: KLoginFailed )
            } else if errorResponse.value(forKey: "errorType") as! NSNumber == 2 {
                self.showAlert(message: kSomethingGetWrong, Title: "Error")
            }
        }, completionLogin: { (result) in
            self.dismissLoader()
            let getLoginInfo = JSON(result)
            if let message = getLoginInfo["message"].string {
                self.showAlert(message: message, Title: "Error")
            }
        })
    }
    
    func  showAlert(message: String = "", Title: String = "") {
        let alertController = UIAlertController(title: Title, message: message, preferredStyle: UIAlertController.Style.alert)
        let retryAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {
            alert -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(retryAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoader(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissLoader() {
        self.dismiss(animated: false, completion: nil)
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

extension FollowersViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowerTableViewCell = tableview.dequeueReusableCell(withIdentifier: "FollowerTableViewCell", for: indexPath) as! FollowerTableViewCell
        cell.setupCell(indexPath: indexPath,userInfoModel: self.followersArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
