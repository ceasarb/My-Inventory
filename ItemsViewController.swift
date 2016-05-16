//
//  ItemsViewController.swift
//  MyInventory
//
//  Created by Ceasar Barbosa on 3/15/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class ItemsViewController : UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        // Sets the table view below the status bar
        
//        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
//        
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
//        tableView.scrollIndicatorInsets = insets
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    // MARK: Delegate/Data Source Methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        // Update height cell dynamically
        cell.updateLabels()
        
        let item = itemStore.allItems[indexPath.row]
        
        // changing color of value label giving the amount
        cell.updateValueLabel(item.valueInDollars)
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // If tableview is asking to commit a delete command
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            let alert = UIAlertController(title: "Delete \(item.name)", message: "Are you sure you want to delete this item?", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
                
                // Remove item from store
                self.itemStore.removeItem(item)
                
                // Remove item's image from imageStore
                self.imageStore.deleteImageForKey(item.itemKey)
                
                // Also remove that row from the tableview with animation
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            
            alert.addAction(deleteAction)
            presentViewController(alert, animated: true, completion: nil)
        
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        // update the model
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    
    // Changing title of delete button
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        return "Remove"
    }
    
    
    //MARK: Action Functions
    
    @IBAction func addNewItem(sender: AnyObject) {
        // Create new item and add it to the ItemStore
        let newItem = itemStore.createItem()

        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
        
        // Insert new row to the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        
    }
    
//    @IBAction func toggleEditingMode(sender: AnyObject) {
//        
//        // If you are currently in editing mode...
//        if editing {
//            
//            // Change text of button to inform user of state
//            sender.setTitle("Edit", forState: .Normal)
//            
//            // turn off editing mode
//            setEditing(false, animated: true)
//        }
//        else {
//            
//            // Change text of button to inform user of state
//            sender.setTitle("Done", forState: .Normal)
//            
//            // Enter editing mode
//            setEditing(true, animated: true)
//        }
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // if triggered segue is ShowItem segue
        if segue.identifier == "ShowItem" {
            // figure out what row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with that row and pass it along
                let item = itemStore.allItems[row]
                let itemDetailViewController = segue.destinationViewController as! ItemDetailViewController
                itemDetailViewController.item = item
                itemDetailViewController.imageStore = imageStore
            }
        }
    }
    
    
    
        
}
