//
//  AVAppCell.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import UIKit

class AVAppCell: UITableViewCell, UIAlertViewDelegate {
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var timeCreated: UILabel!
    @IBOutlet weak var appDescription: UITextView!
    @IBOutlet weak var descriptionConstant: NSLayoutConstraint!
    
    var app:AVApp!
    var openDescription = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionConstant.constant = 0
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    @IBAction func installApp(sender: AnyObject) {
        
        var alert = UIAlertView(title: "Testbuild.Rocks!", message:INSTALL_ALERT_MESSAGE , delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            var urlApp:NSString = app.plist!
            urlApp = "https://s3-eu-west-1.amazonaws.com/ek-appshare/59/d3b32d54b1c1ec8fb0cbf8779352442a.plist"
            var installUrl = NSURL(string: NSString(format: "itms-services://?action=download-manifest&url=%@", urlApp.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!) as String)
            UIApplication.sharedApplication().openURL(installUrl!)
        }
    }
}
