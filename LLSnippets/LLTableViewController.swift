//
//  LLTableViewController.swift
//  LLSnippets
//
//  Created by Lauren Lee on 3/17/16.
//  Copyright © 2016 Lauren Lee. All rights reserved.
//

import Foundation
import UIKit

class LLTableViewController : UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var snippets = Snippets()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        snippetNames.append("Let it go")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToTextVC" {
            if let textViewController = segue.destinationViewController as? LLTextViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    textViewController.snippet = snippets.snippetAtIndex(indexPath.row)
                }
            }
        }
    }
}

extension LLTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snippets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("snippetCell", forIndexPath: indexPath)
        let snippet = snippets.snippetAtIndex(indexPath.row)
        
        cell.textLabel?.text = snippet.name
        
        return cell
    }
}