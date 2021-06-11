/*:
 # Choose Your Car
 
 ---
 
 Hi, my name is Gustavo! I heard you are looking to buy a new vehicle and want something that is good for the environment... I'm here to help you CHOOSE YOUR CAR! Take a seat and let's begin our journey!

 First let's talk about what do we have available on the market:

 - Experiment: Tap **Run My Code** and start swiping left to see the car models as we go through the explanation, you can also tap on the "i" icon on the bottom right to see where the car parts that we are talking about are located, when you're done reading go to the [next page](@next)!

 ## Combustion Engine Cars

 Those cars have three main components:

 * **Combustion Engine**: powers the car;
 * **Transmission**: converts the power coming from the engine to momentum which drives the wheels;
 * **Differential**: allows the wheels to rotate in different speeds so the car makes turns more easily.

 It is the most popular type of car in the world... but not the most appropriate for the environment as we are going to see next!

 ## Electric Motor Cars

 They also have three main components:

 * **Electric Motor**: powers the car;
 * **Battery Pack**: is a set of identical batteries that store charge so the car can turn on;
 * **Differential**: has the same functionality of the combustion engine one but it's attatched to the motor.

 Different from the combustion engine cars, the electric ones have a much more power efficient design and don't rely on non-renewable energy.

 ## Hybrid Cars

 Those cars combine at least one **electric motor** and a **combustion engine**. Sometimes it's the electric motor that does most of the work, sometimes it's the combustion engine and sometimes they work together! This type of car is more power efficient than the single combustion engine one because of the electric motor that helps it and has better fuel economy.
*/

//#-hidden-code
import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
if let scene = IntroScene(fileNamed: "IntroScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
