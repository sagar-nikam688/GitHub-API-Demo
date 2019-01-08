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
        usernameTextField.text = "suhasDPatil"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
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
        self.showLoader()
        let clientId = "ed4000cb58fbfd9ebd7e"
        let clientSecret = "d8e477237c49da7857593e50904f0dd4f3ef0473"
        loggedInUserID = usernameTextField.text!
        let urlStr = "https://api.github.com/users/" + usernameTextField.text! + "?client_id=" + clientId + "&client_secret=" + clientSecret
        NetworkHelper.shareWithPars(parameter: nil,method: .get, url: urlStr, completion: { (result) in
        }, completionError:  { (error) in
            self.dismissLoader()
            let errorResponse = error as NSDictionary
            if errorResponse.value(forKey: "errorType") as! NSNumber == 1 {
                self.getLoginInfo()
                self.showAlert(message: kNoInterNetMessage, Title: KLoginFailed )
            } else if errorResponse.value(forKey: "errorType") as! NSNumber == 2 {
                self.showAlert(message: kSomethingGetWrong, Title: "Error")
            }
        }, completionLogin: {(result) in
            self.dismissLoader()
            let getLoginInfo = JSON(result)
            let response = result as NSDictionary
            if response["id"] != nil {
                //Navigate To next Screen On Sucess
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                vc.responseData = response
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.dismissLoader()
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

    

}
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
}
