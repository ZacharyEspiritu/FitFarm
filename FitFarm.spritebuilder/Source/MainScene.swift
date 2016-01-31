import Foundation
import HealthKit

class MainScene: CCNode {
    
    var healthStore: HKHealthStore?
    var heartRateUnit: HKUnit?
    
    weak var backgroundNode : CCNode!
    
    weak var background1 : CCSprite!
    weak var background2 : CCSprite!
    var backgrounds = [CCSprite]()  // initializes an empty array
    

    func didLoadFromCCB() {
        userInteractionEnabled = true
        backgrounds.append(background1)
        backgrounds.append(background2)
        
        HealthKitInteractor.sharedInstance.initHKData()
        NSUserDefaults.standardUserDefaults().setInteger(17825, forKey: "cardioCoins")
        NSUserDefaults.standardUserDefaults().setInteger(24, forKey: "chocolateBarsCount")
    }
    
    func test() {
        play()
    }
    
    func play() {
        let gameplayScene = CCBReader.load("Gameplay") as! Gameplay
        
        let scene = CCScene()
        scene.addChild(gameplayScene)
        
        let transition = CCTransition(fadeWithDuration: 0.5)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
    
    override func update(delta: CCTime) {
        backgroundNode.position = ccp(backgroundNode.position.x - 50 * CGFloat(delta), backgroundNode.position.y)
        for ground in backgrounds {
            let groundWorldPosition = backgroundNode.convertToWorldSpace(ground.position)
            let groundScreenPosition = convertToNodeSpace(groundWorldPosition)
            if groundScreenPosition.x <= (-ground.contentSize.width) {
                ground.position = ccp(ground.position.x + ground.contentSize.width * 2, ground.position.y)
            }
        }
    }
}
