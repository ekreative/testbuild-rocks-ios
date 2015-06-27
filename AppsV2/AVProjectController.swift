//
//  AVProjectController.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import UIKit

class AVProjectController: AVParentViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var refresher:UIRefreshControl!
    var selectedProject:AVProject!
    
    lazy var fetchResults :NSFetchedResultsController = {
        
        let request = NSFetchRequest(entityName: AVProject.entityName())
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
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
        
        loadProjects()
        
        var barButton = UIBarButtonItem(title: "Log out", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
        self.navigationItem.rightBarButtonItem = barButton
        
        self.navigationController
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refresher)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func logout(){
        AVUser.logout()
    }

    func loadProjects(isRefresher:Bool = false){
        AVRequestHelper.getProjectList({ (operation, mappingResult) -> Void in
            self.fetchResults.performFetch(nil)
            self.tableView.reloadData()
            if isRefresher {
                self.refresher.endRefreshing()
            }
        }, failure: { (operation, error) -> Void in
            SVProgressHUD.showErrorWithStatus("Network error")
        })
    }
    
    func refresh(sender:AnyObject){
        loadProjects(isRefresher: true)
    }
    
    // MARK:- UITableView Delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchResults.fetchedObjects?.count > 0{
            return fetchResults.fetchedObjects!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let project = fetchResults.objectAtIndexPath(indexPath) as! AVProject
        
        var cell = tableView.dequeueReusableCellWithIdentifier("projectCell") as! AVProjectCell
        
        cell.projectName.text = project.name?.uppercaseString
        cell.createdTime.text = Helper.getTimeByTimeStr(project.created!).uppercaseString
        cell.iconProject.sd_setImageWithURL(NSURL(string: API_BASE_URL+"/image.png")!, placeholderImage: UIImage(named: "project_placeholder"))
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showApps" {
            let selectedRow = self.tableView.indexPathForCell(sender as! AVProjectCell)
            let appsListVC = segue.destinationViewController as! AVAppsListController
            var project = fetchResults.objectAtIndexPath(selectedRow!) as! AVProject
            appsListVC.project = project
        }
    }


}
