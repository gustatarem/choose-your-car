import SpriteKit
import PlaygroundSupport

public class IntroScene: SKScene {
    
    private var pages: SKNode!
    
    private var page1: SKNode!
    private var combustionCarInfo: SKSpriteNode!
    private var combustionCarInfoIcon: SKSpriteNode!
    private var combustionCarButtonState: Bool = false
    
    private var page2: SKNode!
    private var electricCarInfo: SKSpriteNode!
    private var electricCarInfoIcon: SKSpriteNode!
    private var electricCarButtonState: Bool = false
    
    private var page3: SKNode!
    private var hybridCarInfo: SKSpriteNode!
    private var hybridCarInfoIcon: SKSpriteNode!
    private var hybridCarButtonState: Bool = false
    
    private var touchX: CGFloat!
    private var startPageX: CGFloat!
    private var buttonState: Bool = false
    private var dragging: Bool = false
    
    override public func didMove(to view: SKView) {
        pages = childNode(withName: "pages")! as SKNode
        page1 = pages.childNode(withName: "page1")
        page2 = pages.childNode(withName: "page2")
        page3 = pages.childNode(withName: "page3")
        
        combustionCarInfo = page1.childNode(withName: "combustion_car_info") as? SKSpriteNode
        combustionCarInfoIcon = page1.childNode(withName: "combustion_car_info_icon") as? SKSpriteNode

        electricCarInfo = page2.childNode(withName: "electric_car_info") as? SKSpriteNode
        electricCarInfoIcon = page2.childNode(withName: "electric_car_info_icon") as? SKSpriteNode

        hybridCarInfo = page3.childNode(withName: "hybrid_car_info") as? SKSpriteNode
        hybridCarInfoIcon = page3.childNode(withName: "hybrid_car_info_icon") as? SKSpriteNode

        combustionCarInfo!.alpha = 0
        electricCarInfo!.alpha = 0
        hybridCarInfo!.alpha = 0
    }

    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        if combustionCarInfoIcon.contains(convert(pos, from: page1)) {
            if combustionCarButtonState == true {
                combustionCarInfo.run(SKAction.fadeOut(withDuration: 1))
                combustionCarButtonState = false
            } else {
                combustionCarInfo.run(SKAction.fadeIn(withDuration: 1))
                combustionCarButtonState = true
            }
            return
        }

        if electricCarInfoIcon.contains(convert(pos, from: page2)) {
            if electricCarButtonState == true {
                electricCarInfo.run(SKAction.fadeOut(withDuration: 1))
                electricCarButtonState = false
            } else {
                electricCarInfo.run(SKAction.fadeIn(withDuration: 1))
                electricCarButtonState = true
            }
            return
        }

        if hybridCarInfoIcon.contains(convert(pos, from: page3)) {
            if hybridCarButtonState == true {
                hybridCarInfo.run(SKAction.fadeOut(withDuration: 1))
                hybridCarButtonState = false
            } else {
                hybridCarInfo.run(SKAction.fadeIn(withDuration: 1))
                hybridCarButtonState = true
            }
            return
        }
        
        dragging = true
        touchX = pos.x
        startPageX = pages?.position.x
    }

    func touchMoved(toPoint pos : CGPoint) {
        if dragging == false {
            return
        }
        let deltaX = pos.x - touchX
        if pages.position.x == 0 && deltaX > 0 {
            return
        }
        pages?.position.x = startPageX + deltaX
    }

    func touchUp(atPoint pos : CGPoint) {
        let currentX = pages!.position.x
        let halfWidth: CGFloat = 768 * 0.5
        var finalX: CGFloat
        if currentX > -halfWidth {
            finalX = 0
        } else if currentX > (-3 * halfWidth) {
            finalX = -2 * halfWidth
        } else if currentX > (-5 * halfWidth){
            finalX = -4 * halfWidth
        } else {
            finalX = -6 * halfWidth
        }
        let distance = abs(currentX - finalX)
        let movingAnimation = SKAction.moveTo(x: finalX, duration: Double(distance) * 0.001)
        movingAnimation.timingMode = .easeOut
        pages?.run(movingAnimation)
        dragging = false
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
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

