//
//  Store.swift
//  FitFarm
//
//  Created by Zachary Espiritu on 1/31/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class Store: CCNode {
    
    var coins: CCLabelTTF!
    var choco: CCLabelTTF!
    
    func didLoadFromCCB() {
        NSTimer.schedule(delay: 2.2) { timer in
            self.coins.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins"))"
            self.choco.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount"))"
        }
    }
    
    var delegate: StoreDelegate?
    
    func exit() {
        delegate?.didClose()
    }
    
    func pandaCoin() {
        delegate?.buyPanda()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins") - 200, forKey: "cardioCoins")
        self.coins.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins"))"
    }
    func pandaChoco() {
        delegate?.buyPanda()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount") - 10, forKey: "cardioCoins")
        self.choco.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount"))"
    }
    func rabbitCoin() {
        delegate?.buyRabbit()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins") - 100, forKey: "cardioCoins")
        self.coins.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins"))"
    }
    func rabbitChoco() {
        delegate?.buyRabbit()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount") - 5, forKey: "cardioCoins")
        self.choco.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount"))"
    }
    func wheatCoin() {
        delegate?.buyWheat()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins") - 100, forKey: "cardioCoins")
        self.coins.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins"))"
    }
    func wheatChoco() {
        delegate?.buyWheat()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount") - 5, forKey: "cardioCoins")
        self.choco.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount"))"
    }
    func cornCoin() {
        delegate?.buyCorn()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins") - 10000, forKey: "cardioCoins")
        self.coins.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins"))"
    }
    func cornChoco() {
        delegate?.buyCorn()
        NSUserDefaults.standardUserDefaults().setInteger(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount") - 100, forKey: "cardioCoins")
        self.choco.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount"))"
    }
}

protocol StoreDelegate {
    func didClose()
    func buyPanda()
    func buyRabbit()
    func buyWheat()
    func buyCorn()
}