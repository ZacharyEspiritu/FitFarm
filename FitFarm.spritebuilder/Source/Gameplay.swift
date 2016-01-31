//
//  Gameplay.swift
//  FitFarm
//
//  Created by Zachary Espiritu on 1/31/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation
import HealthKit

class Gameplay: CCNode {
    
    var healthStore: HKHealthStore?
    var heartRateUnit: HKUnit?
    weak var scrollView: CCScrollView!
    
    weak var cardioCoins: CCLabelTTF!
    weak var cardioCoinsCount: CCLabelTTF!
    weak var chocolateBars: CCLabelTTF!
    weak var chocolateBarsCount: CCLabelTTF!
    
    weak var username: CCLabelTTF!
    
    weak var grayOut: CCNodeColor!
    weak var store: Store!
    weak var chocolateBarStore: ChocolateBarStore!
    
    weak var counterPopup: CounterPopup!
    var healthKitInteractor: HealthKitInteractor = HealthKitInteractor()
    
    var counterIsViewed: Bool = true
    
    
    func didLoadFromCCB() {
        store.delegate = self
        chocolateBarStore.delegate = self
        healthKitInteractor.initHKData()
        healthKitInteractor.delegate = self
        healthKitInteractor.getSamples()
        
//        OALSimpleAudio.sharedInstance().playBg("")
        
        cardioCoinsCount.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins"))"
        chocolateBarsCount.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount")) [+]"
        counterPopup.calculateNewVariables()
        openCounter()
        self.userInteractionEnabled = true
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if counterIsViewed {
            counterIsViewed = false
            grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0))
            counterPopup.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 0.5, y: -313))))
        }
    }
    
    func openCounter() {
        grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0.7))
        counterPopup.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 0.5, y: 13.5))))
    }
    
    func openMenu() {
        grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0.7))
        store.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 0.5, y: 0))))
    }
    
    func buyChocoBars() {
        grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0.7))
        chocolateBarStore.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 284, y: 309))))
    }
    
    func getSamples() {
        HealthKitInteractor.sharedInstance.getSamples()
//        scrollView.addNewPanda()
        openMenu()
    }
}

extension Gameplay: CounterPopupDelegate {
    func counterDidClose() {
        grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0))
        store.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 0.5, y: -313))))
    }
}

extension Gameplay: StoreDelegate {
    func didClose() {
        grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0))
        store.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 0.5, y: -300))))
    }
    func buyRabbit() {
        let scrollNode = scrollView.contentNode as! GameplayScrollView
        scrollNode.rabbit.visible = true
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "rabbit")
    }
    func buyPanda() {
        let scrollNode = scrollView.contentNode as! GameplayScrollView
        scrollNode.panda.visible = true
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "panda")
    }
    func buyCorn() {
        let scrollView = self.scrollView.contentNode as! GameplayScrollView
        scrollView.buyCorn()
    }
    func buyWheat() {
        let scrollNode = scrollView.contentNode as! GameplayScrollView
        scrollNode.buyWheat()
    }
}

extension Gameplay: ChocolateBarStoreDelegate {
    func chocoStoreDidClose() {
        grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0))
        chocolateBarStore.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 284, y: 615))))
    }
}

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

class GameplayScrollView: CCNode {
    
    weak var panda: CCButton!
    weak var rabbit: CCButton!
    
    weak var corn1: CCSprite!
    weak var corn2: CCSprite!
    weak var corn3: CCSprite!
    weak var corn4: CCSprite!
    weak var corn5: CCSprite!
    weak var corn6: CCSprite!
    
    weak var wheat1: CCSprite!
    weak var wheat2: CCSprite!
    weak var wheat3: CCSprite!
    weak var wheat4: CCSprite!
    weak var wheat5: CCSprite!
    
    func buyWheat() {
        if NSUserDefaults.standardUserDefaults().boolForKey("wheat4") {
            wheat5.visible = true
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("wheat3") {
            wheat4.visible = true
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("wheat2") {
            wheat3.visible = true
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("wheat1") {
            wheat2.visible = true
        }
        else {
            wheat1.visible = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "wheat1")
        }
    }
    
    func buyCorn() {
        if NSUserDefaults.standardUserDefaults().boolForKey("corn5") {
            corn6.visible = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "corn6")
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("corn4") {
            corn5.visible = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "corn5")
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("corn3") {
            corn4.visible = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "corn4")
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("corn2") {
            corn3.visible = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "corn3")
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("corn1") {
            corn2.visible = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "corn2")
        }
        else {
            corn1.visible = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "corn1")
        }
    }
    
    func buyPanda() {
        
    }
    
    func buyRabbit() {
        
    }
    
    func didLoadFromCCB() {
        panda.visible = false
        rabbit.visible = false
        corn1.visible = false
        corn2.visible = false
        corn3.visible = false
        corn4.visible = false
        corn5.visible = false
        corn6.visible = false
        wheat1.visible = false
        wheat2.visible = false
        wheat3.visible = false
        wheat4.visible = false
        wheat5.visible = false
        
        let pandaBool = NSUserDefaults.standardUserDefaults().boolForKey("panda")
        let rabbitBool = NSUserDefaults.standardUserDefaults().boolForKey("rabbit")
        let wheat1Bool = NSUserDefaults.standardUserDefaults().boolForKey("wheat1")
        let wheat2Bool = NSUserDefaults.standardUserDefaults().boolForKey("wheat2")
        let wheat3Bool = NSUserDefaults.standardUserDefaults().boolForKey("wheat3")
        let wheat4Bool = NSUserDefaults.standardUserDefaults().boolForKey("wheat4")
        let wheat5Bool = NSUserDefaults.standardUserDefaults().boolForKey("wheat5")
        let corn1Bool = NSUserDefaults.standardUserDefaults().boolForKey("corn1")
        let corn2Bool = NSUserDefaults.standardUserDefaults().boolForKey("corn2")
        let corn3Bool = NSUserDefaults.standardUserDefaults().boolForKey("corn3")
        let corn4Bool = NSUserDefaults.standardUserDefaults().boolForKey("corn4")
        let corn5Bool = NSUserDefaults.standardUserDefaults().boolForKey("corn5")
        let corn6Bool = NSUserDefaults.standardUserDefaults().boolForKey("corn6")
        
        if pandaBool {
            panda.visible = true
        }
        if rabbitBool {
            rabbit.visible = true
        }
        if wheat1Bool {
            wheat1.visible = true
        }
        if wheat2Bool {
            wheat2.visible = true
        }
        if wheat3Bool {
            wheat3.visible = true
        }
        if wheat4Bool {
            wheat4.visible = true
        }
        if wheat5Bool {
            wheat5.visible = true
        }
        if corn1Bool {
            corn1.visible = true
        }
        if corn2Bool {
            corn2.visible = true
        }
        if corn3Bool {
            corn3.visible = true
        }
        if corn4Bool {
            corn4.visible = true
        }
        if corn5Bool {
            corn5.visible = true
        }
        if corn6Bool {
            corn6.visible = true
        }
    }
}

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

protocol Animal {
    var nickname: String { get set }
    var price: Int { get }
    var gender: String { get set }
    
    func createNewInstance() -> CCSprite
    
    func buyAnimal()
    func sellAnimal()
    func slaughterAnimal()
}


extension Gameplay: HealthKitInteractorProtocol {
    func didAccessNewStepData(healthStore: HealthKitInteractor, newSteps: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(newSteps, forKey: "oldSteps")
        
    }
}

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

class Panda: CCSprite, Animal {
    
    var nickname: String = ""
    var price: Int = 1000
    var gender: String = ""
    
    func createNewInstance() -> CCSprite {
        return self
    }
    
    func buyAnimal() {
        print("buy")
    }
    
    func sellAnimal() {
        print("sell")
    }
    
    func slaughterAnimal() {
        print("murder the innocent creature")
    }
}