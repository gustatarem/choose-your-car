import SpriteKit
import PlaygroundSupport
import AVFoundation

public class ElectricScene: SKScene {
    
    private var background: SKSpriteNode!
    
    private var motor: SKNode!
    private var base: SKSpriteNode!
    private var disc: SKSpriteNode!
    private var line: SKSpriteNode!
    private var axle: SKSpriteNode!
    
    private var button: SKSpriteNode!
    private var buttonState: ButtonStates = .turnedOff
    
    override public func didMove(to view: SKView) {
        button = childNode(withName: "on_off_btn") as? SKSpriteNode
        
        background = childNode(withName: "bg") as? SKSpriteNode
        motor = background.childNode(withName: "motor")
        base = motor.childNode(withName: "base") as? SKSpriteNode
        disc = motor.childNode(withName: "disc") as? SKSpriteNode
        line = disc.childNode(withName: "line") as? SKSpriteNode
        axle = motor.childNode(withName: "axle") as? SKSpriteNode
    }

    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        if button.contains(pos) {
            switch buttonState {
            case .turnedOff:
                button.texture = SKTexture(imageNamed: "on_btn")
                let rotation = SKAction.rotate(byAngle: 360, duration: 0.6)
                let action = SKAction.repeatForever(rotation)
                disc.run(action)
                GSAudio.sharedInstance.playSound(soundFileName: "electric_motor", loops: true)
                buttonState = .turnedOn
            case .turnedOn:
                button.texture = SKTexture(imageNamed: "off_btn")
                disc.removeAllActions()
                GSAudio.sharedInstance.stopAll()
                buttonState = .turnedOff
            }
        }
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
    
    enum ButtonStates {
        case turnedOn
        case turnedOff
    }
}

