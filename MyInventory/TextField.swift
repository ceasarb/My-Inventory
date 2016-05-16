//
//  TextField.swift
//  MyInventory
//
//  Created by Ceasar Barbosa on 3/23/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        self.borderStyle = .Line
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        self.borderStyle = .RoundedRect
        return true
    }
    
}
