//
//  IntroLiveView.swift
//  BookCore
//
//  Created by Gustavo Tatarem on 19/04/21.
//

import Foundation
import PlaygroundSupport
import SpriteKit

public class IntroLiveView: SKScene {
    
    public var logo : SKSpriteNode!
   
   override public func didMove(to view: SKView) {
    logo = childNode(withName: "logo") as? SKSpriteNode
    let fadeInOut = SKAction.sequence([.fadeIn(withDuration: 1.8),
                                      .fadeOut(withDuration: 1.8)])
    logo.run(.repeatForever(fadeInOut))
    
        
   }
   
   @objc public static override var supportsSecureCoding: Bool {
       get {
           return true
       }
   }
   
   func touchDown(atPoint pos : CGPoint) {
   }
   
   func touchMoved(toPoint pos : CGPoint) {

   }
   
   func touchUp(atPoint pos : CGPoint) {
   }
   
   override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       for t in touches { touchDown(atPoint: t.location(in: self)) }
   }
   
   override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       for t in touches { touchMoved(toPoint: t.location(in: self)) }
   }
   
   override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       for t in touches { touchUp(atPoint: t.location(in: self)) }
   }
   
   override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       for t in touches { touchUp(atPoint: t.location(in: self)) }
   }
   
   override public func update(_ currentTime: TimeInterval) {
       // Called before each frame is rendered
   }
}
