//
//  GameplayScrollView.swift
//  FitFarm
//
//  Created by Zachary Espiritu on 1/31/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

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