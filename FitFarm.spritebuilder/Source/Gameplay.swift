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
    weak var scrollView: GameplayScrollView!
    
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
    
    
    func didLoadFromCCB() {
        store.delegate = self
        chocolateBarStore.delegate = self
        healthKitInteractor.initHKData()
        healthKitInteractor.delegate = self
        healthKitInteractor.getSamples()
        
//        OALSimpleAudio.sharedInstance().playBg("")
        
        cardioCoinsCount.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins"))"
        chocolateBarsCount.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("chocolateBarsCount"))"
        counterPopup.calculateNewVariables()
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
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

extension Gameplay: StoreDelegate {
    func didClose() {
        grayOut.runAction(CCActionFadeTo(duration: 0.7, opacity: 0))
        store.runAction(CCActionEaseSineIn(action: CCActionMoveTo(duration: 0.7, position: CGPoint(x: 0.5, y: -300))))
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
    func panda() {
        
    }
}

class Store: CCNode {
    
    var delegate: StoreDelegate?
    
    func exit() {
        delegate?.didClose()
    }
}

protocol StoreDelegate {
    func didClose()
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
    
    func didLoadFromCCB() {
        print("test")
    }
    
    func calculateNewVariables() {
        HealthKitInteractor.sharedInstance.getSamples()
        cardioCoins.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins")) cardioCoins"
        steps.string = "\(NSUserDefaults.standardUserDefaults().integerForKey("oldSteps")) steps"
        
        var newCoins = NSUserDefaults.standardUserDefaults().integerForKey("oldSteps") + NSUserDefaults.standardUserDefaults().integerForKey("cardioCoins")
        
        newCardioCoins.string = "\(newCoins) cardioCoins"
        NSUserDefaults.standardUserDefaults().setInteger(newCoins, forKey: "cardioCoins")
    }
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