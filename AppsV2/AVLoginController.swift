//
//  AVLoginController.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import UIKit

class AVLoginController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var loginName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var submitButton: AVLoginButton!
    
    var loginEmpty = true
    var passEmpty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginName.rac_textSignal().subscribeNext { (next: AnyObject!) -> Void in
            if let text = next as? String {
                if count(text) == 0 {
                    self.loginEmpty = true
                }
                else{
                    self.loginEmpty = false
                }
            }
        }
        
        self.password.rac_textSignal().subscribeNext { (next: AnyObject!) -> Void in
            if let text = next as? String {
                if count(text) == 0{
                    self.passEmpty = true
                }
                else{
                    self.passEmpty = false
                }
            }
        }
    }
    
    @IBAction func letRockAction(sender: AnyObject) {
        /*var alert = UIAlertView(title: "app", message: "some mess", delegate: self, cancelButtonTitle: "Ok", otherButtonTitles: "")
        
        alert.show()*/
        if !loginEmpty && !passEmpty{
            SVProgressHUD.show()
            AVRequestHelper.login(loginName.text, pass: password.text, success: { (operation, mappingResult) -> Void in
                
                SVProgressHUD.dismiss()
                AVProject.removeAllProjects()
                var user = mappingResult.array().last as! AVUser
                RKObjectManager.sharedManager().HTTPClient.setDefaultHeader(HEADER_TOKEN_KEY, value: user.apiKey!)
                AVUser.logIn(user.apiKey!)
                
                let storyBoard = UIStoryboard(name: "AppsList", bundle: NSBundle.mainBundle())
                let listVC = storyBoard.instantiateViewControllerWithIdentifier("appslist") as! UINavigationController
                self.presentViewController(listVC, animated: true, completion: nil)
                
            }, failure: { (operation, error) -> Void in
                SVProgressHUD.showErrorWithStatus("network error")
            })
        }
        else{
            if loginEmpty {
                SVProgressHUD.showErrorWithStatus("Login cannot be empty")
            }
            else if passEmpty {
                SVProgressHUD.showErrorWithStatus("Password cannot be empty")
            }
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            var urlApp:NSString = "https://s3-eu-west-1.amazonaws.com/ek-appshare/108/8f55a8ced5083157fde163ceb2a623b2.plist"
            var installUrl = NSURL(string: NSString(format: "itms-services://?action=download-manifest&url=%@", urlApp.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!) as String)
            UIApplication.sharedApplication().openURL(installUrl!)
        }
    }

}
