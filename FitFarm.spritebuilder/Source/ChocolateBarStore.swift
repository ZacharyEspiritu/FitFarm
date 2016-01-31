//
//  ChocolateBarStore.swift
//  FitFarm
//
//  Created by Zachary Espiritu on 1/31/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class ChocolateBarStore: CCNode {
    var delegate: ChocolateBarStoreDelegate?
    
    func makePurchase() {
        let error = UIAlertView()
        error.title = "Confirm Your In-App Purchase"
        error.message = "Do you want to buy one ChocoBar for $1337.00?"
        error.addButtonWithTitle("Cancel")
        error.addButtonWithTitle("Buy")
        error.show()
    }
    
    func exitShop() {
        delegate?.chocoStoreDidClose()
    }
}

protocol ChocolateBarStoreDelegate {
    func chocoStoreDidClose()
}