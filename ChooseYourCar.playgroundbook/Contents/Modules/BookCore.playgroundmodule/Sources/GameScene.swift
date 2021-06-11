import SpriteKit
import PlaygroundSupport
import AVFoundation

public enum Cars: Int {
    case combustion
    case hybrid
    case electric
}

public class GameScene: SKScene {
    private var speedometer: SKSpriteNode!
    private var speedometerCircle: SKSpriteNode!
    private var speedometerPointer: SKSpriteNode!
    private var pedal: SKSpriteNode!
    
    public var editableCode: Cars = .combustion
    public var cars: [Cars] = []
    private var carPrefix: String!
    
    private var car: SKSpriteNode!
    private var isCarMoving: Bool = false
    private var isFirstClick: Bool = true
    
    private var acceleration: CGFloat = 0
    
    private var buttonPressed: Bool = false
    
    private var layers: [SKNode] = []
    private var backgroundWidth: CGFloat!
    private var sprite1: SKSpriteNode!
    private var sprite2: SKSpriteNode!
    
    override public func didMove(to view: SKView) {
        if editableCode == .combustion {
            carPrefix = "combustion"
        }
        if editableCode == .electric {
            carPrefix = "electric"
        }
        if editableCode == .hybrid {
            carPrefix = "hybrid"
        }
        
        car = SKSpriteNode(imageNamed: "\(carPrefix!)_car")
        car.position = CGPoint(x: -200, y: -400)
        car.zPosition = 8
        addChild(car)
        
        speedometer = SKSpriteNode(imageNamed: "speedometer")
        speedometer.position = CGPoint(x: 0, y: 300)
        speedometer.zPosition = 8
        addChild(speedometer)
        
        speedometerCircle = SKSpriteNode(imageNamed: "speedometer_circle")
        speedometerCircle.zPosition = 6
        speedometerCircle.position = CGPoint(x: 0, y: -68)
        speedometer.addChild(speedometerCircle)
        
        speedometerPointer = SKSpriteNode(imageNamed: "speedometer_pointer")
        speedometerPointer.zPosition = -1
        speedometerPointer.position = CGPoint(x: 0, y: 50)
        speedometerCircle.addChild(speedometerPointer)
        
        speedometerCircle.zRotation = 1.4
        
        pedal = SKSpriteNode(imageNamed: "pedal")
        pedal.position = CGPoint(x: 300, y: -380)
        pedal.scale(to: CGSize(width: 70, height: 139))
        pedal.zPosition = 10
        addChild(pedal)
        setupBackgroundAnimation()
        
        if case let .array(values) = PlaygroundKeyValueStore.current["ld"] {
            for case let .integer(value) in values {
                cars.append(Cars(rawValue: value)!)
            }
        }
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func setupBackgroundAnimation() {
        setupLayer(1)
        setupLayer(2)
        setupLayer(3)
    }
    
    func setupLayer(_ layer: Int) {
        sprite1 = SKSpriteNode(imageNamed: "\(layer)")
        sprite2 = SKSpriteNode(imageNamed: "\(layer)")
        
        sprite1.position = .zero
        sprite2.position = CGPoint(x: sprite1.size.width - 2, y: 0)
        
        let layerNode = SKNode()
        layerNode.addChild(sprite1)
        layerNode.addChild(sprite2)
        
        layerNode.zPosition = CGFloat(layer)
        layerNode.position = CGPoint(x: 0, y: 0)
        
        backgroundWidth = sprite1.size.width
        
        layers.append(layerNode)
        
        self.addChild(layerNode)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if pedal.contains(pos) {
            pedal.texture = SKTexture(imageNamed: "pressed_pedal")
            pedal.scale(to: CGSize(width: 60, height: 118))
            
            let carAnimation = SKAction.moveTo(x: 0, duration: 1)
            car.run(carAnimation)
            
            switch editableCode {
            case .combustion:
                GSAudio.sharedInstance.playSound(soundFileName: "combustion")
            case .hybrid:
                GSAudio.sharedInstance.playSound(soundFileName: "hybrid")
            case .electric:
                GSAudio.sharedInstance.playSound(soundFileName: "spaceship_goes_zoom")
            }
            
            if isFirstClick {
                switch editableCode {
                case .combustion:
                    if speedometerCircle.zRotation > 1.35 {
                        let speedometerAnimation = SKAction.rotate(byAngle: -0.1, duration: 1)
                        speedometerCircle.run(speedometerAnimation)
                        let backgroundColorAction = SKAction.colorize(with: UIColor.brown, colorBlendFactor: 1, duration: 1)
                        let carColorAction = SKAction.colorize(with: UIColor.brown, colorBlendFactor: 0.5, duration: 1)
                        for layerNode in layers {
                            for layer in layerNode.children {
                                layer.run(backgroundColorAction)
                            }
                        }
                        car.run(carColorAction)
                        PlaygroundPage.current.assessmentStatus = .fail(hints: ["This doesn't seem to be the best option for the environment... 😔"], solution: "Try the .hybrid or the .electric!")
                    }
                case .electric:
                    if speedometerCircle.zRotation > -1.35 {
                        let speedometerAnimation = SKAction.rotate(byAngle: -2.8, duration: 3)
                        speedometerCircle.run(speedometerAnimation)
                        
                    }
                case .hybrid:
                    if speedometerCircle.zRotation > 0.1 {
                        let speedometerAnimation = SKAction.rotate(byAngle: -1.4, duration: 2)
                        speedometerCircle.run(speedometerAnimation)
                        let backgroundColorAction = SKAction.colorize(with: UIColor.brown, colorBlendFactor: 0.4, duration: 1)
                        let carColorAction = SKAction.colorize(with: UIColor.brown, colorBlendFactor: 0.3, duration: 1)
                        for layerNode in layers {
                            for layer in layerNode.children {
                                layer.run(backgroundColorAction)
                            }
                        }
                        car.run(carColorAction)
                        PlaygroundPage.current.assessmentStatus = .fail(hints: ["That seems a lot better than the combustion one but there's still a gap..."], solution: "Try changing to the .electric!")
                    }
                }
            }
            isCarMoving = true
            buttonPressed = true
            isFirstClick = false
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if buttonPressed == true {
            pedal.texture = SKTexture(imageNamed: "pedal")
            pedal.scale(to: CGSize(width: 70, height: 139))
            buttonPressed = false
        }
        
        GSAudio.sharedInstance.stopAll()
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
        if buttonPressed {
            acceleration = min(1, acceleration * 1.2 + 0.01)
        }
        
        if !buttonPressed {
            acceleration = max(0, acceleration - 0.01)
        }
        
        if acceleration == 0 {
            isCarMoving = false
        }
        
        if isCarMoving {
            car.texture = SKTexture(imageNamed: "moving_\(carPrefix!)_car")
        } else {
            car.texture = SKTexture(imageNamed: "\(carPrefix!)_car")
        }
        
        for (index, layer) in layers.enumerated() {
            let offset = CGFloat(index + 1 + index) * 5 * acceleration
            layer.position = CGPoint(x: layer.position.x - offset, y: layer.position.y)
            if layer.position.x < -backgroundWidth {
                layer.position = CGPoint(x: layer.position.x + backgroundWidth, y: layer.position.y)
            }
        }
    }
    
}

