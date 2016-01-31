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
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
    }
    
    func getSamples() {
        HealthKitInteractor.sharedInstance.getSamples()
//        scrollView.addNewPanda()
    }
}

class GameplayScrollView: CCNode {
    func addNewPanda() {
        let newPanda = CCBReader.load("Panda") as! Panda
        self.addChild(newPanda)
    }
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