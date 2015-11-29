//
//  itemsFetchOperation.swift
//  Wannafix
//
//  Created by massimo on 29/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit

class ItemsFetchOperation: Operation {
    var completionHandler: [PFObject]->Void
    
    init(completionHandler: [PFObject]->Void) {
        self.completionHandler = completionHandler
        super.init()
    }
    
    
    override func execute() {
        let fetchItemsQuery = UserModelManager.sharedManager.currentUser()?.relationForKey("items").query()
        fetchItemsQuery?.orderByDescending("createdAt")
        fetchItemsQuery?.findObjectsInBackgroundWithBlock({ (items, error) -> Void in
            self.completionHandler((items as? [PFObject])!)
            self.finish()
        })
    }
}
