//
//  ItemsViewController.swift
//  Wannafix
//
//  Created by massimo on 6/27/14.
//  Copyright (c) 2014 Team84. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let operationQueue = NSOperationQueue()
    
    var items = [PFObject]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        refreshItems()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell") as! ItemTableViewCell
        
        let currentItem = items[indexPath.row]
        
        cell.itemImageView.image = UIImage(data: (currentItem.objectForKey("images").firstObject as? NSData)!)
        
        cell.ItemDescription.text = currentItem.objectForKey("name") as? String
        
        cell.itemCreatedAt.text = currentItem.createdAt.description
        
        return cell
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        UserModelManager.sharedManager.logout()
        items = [PFObject]()
        tableView.reloadData()
    }

    @IBAction func refresh(sender: AnyObject) {
        refreshItems()
    }
    
    private func refreshItems() {
        let getItemsOperation = GetUserItemsOperation {(items) -> Void in
            self.items = items
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        operationQueue.addOperation(getItemsOperation)
    }
}
