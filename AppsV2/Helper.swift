//
//  File.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import Foundation
import UIKit

@objc(Helper)
class Helper {
    
    class func getTimeByTimeStr(time:String) -> String{
        var dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-ddeeeeeHH:mm:ssxxx"
        var date = dateFormat.dateFromString(time)
        dateFormat.dateFormat = "HH:mm:ss dd.MM.yyyy"
        return dateFormat.stringFromDate(date!)
    }
    
    class func getTimeByDate(date:NSDate) -> String{
        var dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "HH:mm:ss dd.MM.yyyy"
        
        return dateFormat.stringFromDate(date)
    }
    
    class func setKey(key:String?){
        NSUserDefaults.standardUserDefaults().setObject(key, forKey: "apiKey")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func getKey() -> AnyObject{
        return NSUserDefaults.standardUserDefaults().objectForKey("apiKey")!
    }
}