//
//  CounterPopup.swift
//  FitFarm
//
//  Created by Zachary Espiritu on 1/31/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class CounterPopup: CCNode {
    
    weak var cardioCoins: CCLabelTTF!
    weak var steps: CCLabelTTF!
    weak var newCardioCoins: CCLabelTTF!
    
    var delegate: CounterPopupDelegate?
    
    func didLoadFromCCB() {
        cardioCoins.string = ""
        steps.string = ""
        newCardioCoins.string = ""
        print("test")
    }
    
    func calculateNewVariables() {
        NSTimer.schedule(delay: 2.0) { timer in
            self.cardioCoins.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins")) cardioCoins"
            
            let newSteps: Int!
            if NSUserDefaults.standardUserDefaults().integerForKey("oldSteps") == NSUserDefaults.standardUserDefaults().integerForKey("reallyOldSteps") {
                newSteps = 0
            }
            else {
                NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("oldSteps"), forKey: "reallyOldSteps")
                newSteps = NSUserDefaults.standardUserDefaults().integerForKey("oldSteps")
            }
            self.steps.string = "\(newSteps) steps"
            
            NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("oldSteps"), forKey: "reallyOldSteps")
            
            let newCoins = newSteps + NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins")
            
            self.newCardioCoins.string = "\(newCoins) cardioCoins"
            NSUserDefaults.standardUserDefaults().setInteger(newCoins, forKey: "cardioCoins")
        }
    }
    
    func exit() {
        delegate?.counterDidClose()
    }
}

protocol CounterPopupDelegate {
    func counterDidClose()
}