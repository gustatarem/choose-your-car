/*:
  - Note: For a better experience use this Playground in split landscape
 # Choose Your Car
 
 Now that we know a lot more about what types of cars exist and how they affect or not the environment it's time for you to choose your car!
 
 All the choices you make from now on are going to affect the environment, so be careful!
 
 Try typing one of these car models:
 * callout(Cars):
 
    `.combustion`\
    `.hybrid`\
    `.electric`
 
 
 Change the variable value and then click **Run My Code**!
 
 Press the pedal on the bottom right of the screen and see what happens!
*/
//#-hidden-code
import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore
//#-end-hidden-code
var myCar : Cars = /*#-editable-code*/.combustion/*#-end-editable-code*/

//#-hidden-code
// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode
    scene.scaleMode = .aspectFit
    scene.editableCode = myCar

    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//#-end-hidden-code
