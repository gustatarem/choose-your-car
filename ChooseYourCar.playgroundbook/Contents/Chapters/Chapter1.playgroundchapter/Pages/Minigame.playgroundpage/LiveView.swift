//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//

import PlaygroundSupport
import SpriteKit
import BookCore

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = GameLiveView(fileNamed: "GameLiveView") {
    // Set the scale mode
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
