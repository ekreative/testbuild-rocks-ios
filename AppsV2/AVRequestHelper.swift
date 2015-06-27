//
//  AVRequestHelper.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import Foundation
import UIKit

class AVRequestHelper: NSObject {
    
    class func getObjectAtPath(path:String ,parameters:[NSObject : AnyObject]?, success: (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void, failure:(operation: RKObjectRequestOperation!, error: NSError!) -> Void) -> Void
    {
        RKObjectManager.sharedManager().getObjectsAtPath(path, parameters: parameters, success: {(operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void in
            success(operation: operation, mappingResult: mappingResult)
            }, failure: {(operation: RKObjectRequestOperation!, error: NSError!) -> Void in
                if(operation.HTTPRequestOperation.response.statusCode == 403){
                    AVUser.logout()
                }
                else{
                    failure(operation: operation, error: error)
                }
                
        })
        
    }
    
    class func getObjectAPathWithRoute(routeName:String, object:[NSObject : AnyObject]?, parameters:[NSObject : AnyObject]?, success: (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void, failure:(operation: RKObjectRequestOperation!, error: NSError!) -> Void) -> Void{
        
        RKObjectManager.sharedManager().getObjectsAtPathForRouteNamed(routeName, object: object, parameters: parameters, success: { (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void in
            success(operation: operation, mappingResult: mappingResult)
        }, failure: {(operation: RKObjectRequestOperation!, error: NSError!) -> Void in
            if(operation.HTTPRequestOperation.response.statusCode == 403){
                AVUser.logout()
            }
            else{
                failure(operation: operation, error: error)
            }
        })
    }
    
    class func postObject(object: AnyObject!, path:String, parameters:[NSObject : AnyObject]?, success: (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void, failure:(operation: RKObjectRequestOperation!, error: NSError!) -> Void) -> Void
    {
        
        RKObjectManager.sharedManager().postObject(object, path: path, parameters: parameters, success:  {(operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void in
            success(operation: operation, mappingResult: mappingResult)
            
            }, failure: {(operation: RKObjectRequestOperation!, error: NSError!) -> Void in
                if(operation.HTTPRequestOperation.response.statusCode == 403){
                    AVUser.logout()
                }
                else{
                    failure(operation: operation, error: error)
                }
        })
    }
    
    class func login(login:String, pass:String, success: (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void, failure:(operation: RKObjectRequestOperation!, error: NSError!) -> Void) -> Void{
        
        let parameters = NSMutableDictionary()
        parameters.setValue(login, forKey: "username")
        parameters.setValue(pass, forKey: "password")
        
        let postParam = NSMutableDictionary()
        postParam.setValue(parameters, forKey: "login")
        
        AVRequestHelper.postObject(nil, path: "login", parameters: postParam as [NSObject : AnyObject], success: { (operation, mappingResult) -> Void in
            success(operation: operation, mappingResult: mappingResult)
        }) { (operation, error) -> Void in
            failure(operation: operation, error: error)
        }
        
    }
    
    class func getProjectList(success: (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void, failure:(operation: RKObjectRequestOperation!, error: NSError!) -> Void) -> Void{
        
        AVRequestHelper.getObjectAtPath("api/projects.json", parameters: nil, success: { (operation, mappingResult) -> Void in
            success(operation: operation, mappingResult: mappingResult)
        }) { (operation, error) -> Void in
            failure(operation: operation, error: error)
        }
    }
    
    class func getApps(projectId:Int, success: (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void, failure:(operation: RKObjectRequestOperation!, error: NSError!) -> Void) -> Void{
        
        AVRequestHelper.getObjectAPathWithRoute("api/builds/:id/ios", object: ["id":"\(projectId)"], parameters: nil, success: { (operation, mappingResult) -> Void in
            success(operation: operation, mappingResult: mappingResult)
        }) { (operation, error) -> Void in
            failure(operation: operation, error: error)
        }
    }
}