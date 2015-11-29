//
//  FetchUserItemsOperation.swift
//  Wannafix
//
//  Created by massimo on 28/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit

class GetUserItemsOperation: Operation {

    var internalQueue = NSOperationQueue()
    var completionHandler: [PFObject]->Void
    
    override func execute() {
        let loginOperation = LoginOperation()
        let fetchItemsOperation = ItemsFetchOperation { (items) -> Void in
            self.completionHandler(items)
            self.finish()
        }
        
        fetchItemsOperation.addDependency(loginOperation)
        self.internalQueue.addOperations([loginOperation, fetchItemsOperation], waitUntilFinished: false)
    }
    
    init(completionHandler: [PFObject]->Void) {
        self.completionHandler = completionHandler
        super.init()
    }
    
    
    
}
