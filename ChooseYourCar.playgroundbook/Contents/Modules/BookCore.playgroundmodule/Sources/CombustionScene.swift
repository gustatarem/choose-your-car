import SpriteKit
import PlaygroundSupport
import AVFoundation

public class CombustionScene: SKScene {

    private var pistao1: SKNode? {
        return self.childNode(withName: "pistao1")
    }
    private var pistao2: SKNode? {
        return self.childNode(withName: "pistao2")
    }
    private var pistao3: SKNode? {
        return self.childNode(withName: "pistao3")
    }
    private var pistao4: SKNode? {
        return self.childNode(withName: "pistao4")
    }
    private var candletouchArea: SKNode? {
        return self.childNode(withName: "sparkTouchArea")
    }
    private var fire: SKNode? {
        return self.childNode(withName: "fire")
    }
    private var fire2: SKNode? {
        return self.childNode(withName: "fire2")
    }
    
    private var hasIgnited: Bool = false
    private var step: TimeInterval = 0
    private var lastUpdate: TimeInterval = 0
    private var gameState: GameStates = .intro
    private var isFirstClick: Bool = true
    
    private var fireAnimation: SKAction!
    
    override public func didMove(to view: SKView) {
        fire?.alpha = 0
        fire2?.alpha = 0
        setupFireAnimation()
    }

    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        if gameState != .waitingForClick {
            return
        }
        let _: () = nodes(at: pos).filter {
            $0.name == "sparkTouchArea"
        }.forEach { _ in
            hasIgnited = true
            fire?.alpha = 1
            fire2?.alpha = 1
            if isFirstClick {
                fire?.run(fireAnimation) {
                    self.fire?.alpha = 0
                    self.gameState = .finalLoop
                    PlaygroundPage.current.assessmentStatus = .pass(message: "Nice job! Read the text on the left to learn more about what just happened here!")
                }
                fire2?.run(fireAnimation) {
                    self.fire2?.alpha = 0
                }
                GSAudio.sharedInstance.playSound(soundFileName: "engine_sound", loops: true)
            }
           isFirstClick = false
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
        
    }

    func touchUp(atPoint pos : CGPoint) {

    }
    
    func setupFireAnimation() {
        var fireTextures: [SKTexture] = []
        for i in 1...11 {
            fireTextures.append(SKTexture(imageNamed: "fire\(i)"))
            
        }
        for i in 1...11 {
            fireTextures.append(SKTexture(imageNamed: "smoke\(i)"))
        }
        
        let animateFire = SKAction.animate(with: fireTextures,
                                                 timePerFrame: 0.12,
                                                 resize: true,
                                                 restore: false)
                
        fireAnimation = SKAction.repeat(animateFire, count: 1)
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if lastUpdate == 0 {
            lastUpdate = currentTime
            return
        }
        let deltaTime = currentTime - lastUpdate
        lastUpdate = currentTime
        
        switch gameState {
        case .intro:
            updateEngine(deltaTime: deltaTime)
        case .waitingForClick:
            break
        case .finalLoop:
            updateEngine(deltaTime: deltaTime)
        }
    }
    
    func updateEngine(deltaTime: TimeInterval) {
        switch gameState {
        case .intro:
            if step > 1.5 {
                gameState = .waitingForClick
                PlaygroundPage.current.assessmentStatus = .pass(message: "Click on the valves to generate a spark!")
            }
        case .waitingForClick:
            return
        case .finalLoop:
            break
        }
        
        step += deltaTime
        let amplitude: Double = 30
        let frequency: Double = 5
        let phase: Double = .pi
        let deltaY1 = sin(step * frequency) * amplitude - amplitude
        let deltaY2 = sin(step * frequency + phase) * amplitude - amplitude
        pistao1?.position.y = CGFloat(deltaY1 - 80)
        pistao2?.position.y = CGFloat(deltaY2 - 80)
        pistao3?.position.y = CGFloat(deltaY2 - 80)
        pistao4?.position.y = CGFloat(deltaY1 - 80)
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
    
    enum GameStates {
        case intro
        case waitingForClick
        case finalLoop
    }
}

