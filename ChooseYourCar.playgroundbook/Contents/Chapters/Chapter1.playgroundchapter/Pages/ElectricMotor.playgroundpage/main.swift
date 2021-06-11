/*:
 # The Electric Motor

 It's important to know that a "motor" and an "engine" are two different things:
 * The **motor** is a machine that converts energy into mechanical energy;
 * The **engine** does the same thing but specifically using thermal energy, so every engine is a motor but not every motor is an engine.

 Electric motors can be found in most of our everyday devices. The motors used in smaller mechanisms and in electric cars share the same concept, but to power a vehicle the motor needs to be more powerful and reliable, so it uses a different approach.

 Inside an electric car motor we have two major parts: the stator and the rotor. The difference between them is very simple, the stator is **static** and the rotor **rotates**. The stator uses the energy supplied by the battery pack to generate a magnetic field, which turns the rotor and spins the wheels!

 - Experiment: Tap **Run My Code** and try turning on the toggle button to power the electric motor!

 Hybrid cars also use electric motors alongside the combustion engine to reduce fuel consumption and optimize power efficiency (especially at low speeds).

 Note that there are no gases involved on the process, so in theory the electric/hybrid cars are a lot better for the environment since they pollute a lot less or even nothing! This may look like a perfect scenario, but it's not there yet.

 A lot of companies that produce electric vehicles end up polluting the environment in the car manufacturing, especially in the battery production, but this problem can be solved by decarbonizing electricity generation. 😉
 
 - Experiment: Go to the [next page](@next)!
*/

//#-hidden-code
import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
if let scene = ElectricScene(fileNamed: "ElectricScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
