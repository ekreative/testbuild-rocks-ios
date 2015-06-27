//
//  AVAppsListController.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import UIKit

class AVAppsListController: AVParentViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var project:AVProject!
    var refresher:UIRefreshControl!
    
    lazy var fetchResults :NSFetchedResultsController = {
        
        let request = NSFetchRequest(entityName: AVApp.entityName())
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
//        request.predicate = NSPredicate(format: "projectId == %@", self.project.id!)
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        var error: NSError?
        
        fetchedResultsController.performFetch(&error)
        if let error = error {
            NSLog("Error %@, %@", error, error.userInfo ?? "")
            abort();
        }
        return fetchedResultsController
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResults.delegate = self
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addSubview(refresher)
        
        loadApps()
    }
    
    func refresh(sender:AnyObject){
        loadApps(refresh: true)
    }
    
    func loadApps(refresh:Bool = false){
        AVRequestHelper.getApps(project.id!.integerValue, success: { (operation, mappingResult) -> Void in
            println(mappingResult.dictionary())
            self.fetchResults.performFetch(nil)
            self.tableView.reloadData()
            println(self.fetchResults.fetchedObjects?.count)
            if refresh {
                self.refresher.endRefreshing()
            }
            }) { (operation, error) -> Void in
                SVProgressHUD.showErrorWithStatus("Network error")
        }
    }
    
    //MARK:- UITableView delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResults.fetchedObjects!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("appCell") as! AVAppCell
        
        var app = fetchResults.objectAtIndexPath(indexPath) as! AVApp
        
        var date = NSDate(timeIntervalSince1970: app.timeCreated!.doubleValue)
        
        cell.appDescription.text = app.name!
        cell.timeCreated.text = Helper.getTimeByDate(date)
        cell.appName.text = app.name!
        cell.app = app
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! AVAppCell
        
        if cell.openDescription {
            var fixedWidth: CGFloat = cell.appDescription!.frame.size.width
            var newSize: CGSize = cell.appDescription!.sizeThatFits(CGSizeMake(fixedWidth, CGFloat(FLT_MAX)))
            var newFrame: CGRect = cell.appDescription!.frame
            newFrame.size = CGSizeMake(fmax(newSize.width, fixedWidth), newSize.height)
            cell.openDescription = false
            cell.descriptionConstant.constant = newFrame.size.height
            
            var cellHeight = cell.frame.size.height+newFrame.size.height
            
            cell.frame.size = CGSizeMake(cell.frame.width, cellHeight)
        }
        else{
            cell.frame.size = CGSizeMake(cell.frame.width, cell.frame.height-cell.descriptionConstant.constant)
            cell.descriptionConstant.constant = 0
            cell.openDescription = true
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! AVAppCell
        
        cell.descriptionConstant.constant = 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
