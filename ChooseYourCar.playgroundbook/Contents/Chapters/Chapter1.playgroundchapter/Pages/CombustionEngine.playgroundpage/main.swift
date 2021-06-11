/*:
 # The Combustion Engine

 Let's talk about how each of these motors work!
 
 ## Glossary (using images!)
 * Piston
 
 ![Piston](pistaomd.png)
 
 * Valve
 
 ![Valve](valve.png)

 ---
 
 In short, combustion engines work because of a chemical process of releasing energy from a fuel and air mixture, so let's see how it works on practice!

 - Experiment: Tap **Run My Code** to see the internals of a working combustion engine!

 You can see that the pistons go up and down, that is called a "four-stroke" cycle, it means that four piston strokes are needed to complete the cycle, the processes involved in this cycle are:

 * **Intake**: when air and fuel are mixed;
 * **Compression**: when the piston compresses the mixture;
 * **Power**: when a spark ignites the mixture, causing an explosion and pushing the piston down;
 * **Exhaust**: when the piston pushes out the burned gases.

 Those four processes are what generates power to move the car... but wait! Have you seen that little smoke!?

 ![Smoke](smoke.png)

 That smoke comes from the burned gases and are ejected from the car exhaust.
 
 ![Exhaust](exhaust.png)
 
 It contains some substances that contribute to the air pollution, such as Nitrogen Oxides (NOx) and Carbon Monoxide (CO)! That is why, even though it's the most popular model, combustion engine cars are a problem to the environment!
 
 - Experiment: Go to the [next page](@next)!
 
*/

//#-hidden-code
import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
if let scene = CombustionScene(fileNamed: "CombustionScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
