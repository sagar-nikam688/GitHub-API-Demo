//
//  ViewController.swift
//  GitHubAPIApp
//
//  Created by sagar.nikam on 04/01/19.
//  Copyright © 2019 sagar.nikam. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var signInButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = "sagar-nikam688"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }


    @IBAction func signInButtonAction(sender : AnyObject) {
        login()
    }
    
    
    func login() {
        let status = Reachability.isConnectedToNetwork()
        switch status {
        case .unknown,.offline:
            let alertController = UIAlertController(title: "Oops..", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert)
            let retryAction = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {
                alert -> Void in
                self.login()
            })
            alertController.addAction(retryAction)
            self.present(alertController, animated: true, completion: nil)
            break
        case .online(.wwan),.online(.wiFi):
            self.getLoginInfo()
            break
        }
    }
    
    /**
     * // MARK: - API Method : LoginInfo()
     */
    func getLoginInfo() {
        let clientId = "ed4000cb58fbfd9ebd7e"
        let clientSecret = "d8e477237c49da7857593e50904f0dd4f3ef0473"
        let params = ["scopes":"repo", "note": "dev", "client_id": clientId, "client_secret": clientSecret]
        
        let urlStr = "https://api.github.com/users/" + usernameTextField.text! + "?client_id=" + clientId + "&client_secret=" + clientSecret
        NetworkHelper.shareWithPars(parameter: nil,method: .get, url: urlStr, completion: { (result) in
        }, completionError:  { (error) in
            let errorResponse = error as NSDictionary
            if errorResponse.value(forKey: "errorType") as! NSNumber == 1 {
                self.getLoginInfo()
                self.showAlert(message: kNoInterNetMessage, Title: KLoginFailed )
            } else if errorResponse.value(forKey: "errorType") as! NSNumber == 2 {
                self.showAlert(message: kSomethingGetWrong, Title: "Error")
            }
        }, completionLogin: {(result) in
            let getLoginInfo = JSON(result)
            let response = result as NSDictionary
            if response["id"] != nil {
                //Navigate To next Screen On Sucess
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                vc.responseData = response
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                if let message = getLoginInfo["message"].string {
                    self.showAlert(message: message, Title: "Error")
                }
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

}

