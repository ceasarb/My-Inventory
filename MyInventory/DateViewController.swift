//
//  DateViewController.swift
//  MyInventory
//
//  Created by Ceasar Barbosa on 3/24/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.setDate(item.dateCreated, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date
    }
    
}
