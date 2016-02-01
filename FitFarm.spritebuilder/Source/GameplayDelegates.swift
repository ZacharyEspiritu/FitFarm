//
//  GameplayDelegates.swift
//  FitFarm
//
//  Created by Zachary Espiritu on 1/31/16.
//  Copyright © 2016 Zachary Espiritu. All rights reserved.
//

import Foundation

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

extension Gameplay: HealthKitInteractorProtocol {
    func didAccessNewStepData(healthStore: HealthKitInteractor, newSteps: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(newSteps, forKey: "oldSteps")
    }
}