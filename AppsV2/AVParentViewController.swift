//
//  AVParentViewController.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import UIKit
import Foundation

class AVParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navbar"), forBarMetrics: UIBarMetrics.Default)
        
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "back_button"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        UIBarButtonItem.appearance().title = ""
    }
}
