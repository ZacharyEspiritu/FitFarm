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