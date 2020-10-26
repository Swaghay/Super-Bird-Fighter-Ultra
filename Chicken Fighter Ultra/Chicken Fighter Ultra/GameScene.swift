//
//  GameScene.swift
//  Chicken Figher Ultra
//
//  Created by 90308589 on 10/20/20.
//

import SpriteKit
import GameplayKit

//pog

class GameScene: SKScene {
    var Right_Arrow = SKSpriteNode()
    var Platform = SKSpriteNode(color: UIColor.red, size: CGSize(width: 900, height: 100))
    var Left_Arrow = SKSpriteNode()
    var Player = SKSpriteNode()
   
    override func didMove(to view: SKView) {

        setup()
    }
    
    func setup(){
        Platform.name = "Platform"
        Player.name = "Player"
        Right_Arrow.name = "Right"
        Left_Arrow.name = "Left"
        set_filtering_mode(fileNamed: "Chickette_with_skirt", node: Player)
        set_filtering_mode(fileNamed: "RightArrow", node: Right_Arrow)
        set_filtering_mode(fileNamed: "LeftArrow", node: Left_Arrow)
        let buttonSize = CGSize(width: 96 , height: 96)
        let CharacterSize = CGSize(width: 96 , height: 96)
        Right_Arrow.size = buttonSize
        Player.size = CharacterSize
        Player.physicsBody = SKPhysicsBody(rectangleOf: CharacterSize)
        Player.physicsBody?.affectedByGravity = true
        Platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 900, height: 100))
        Platform.physicsBody?.affectedByGravity = false
        Platform.physicsBody?.isDynamic = false
        Platform.position = CGPoint(x: 0, y: -200)
        Left_Arrow.size = buttonSize
        Left_Arrow.position = CGPoint(x: -300, y: -200)
        Right_Arrow.position = CGPoint(x: -200,y: -200)
        addChild(Platform)
        addChild(Player)
        addChild(Left_Arrow)
        addChild(Right_Arrow)
    }
    
   
    func set_filtering_mode(fileNamed: String,node: SKSpriteNode){
        let texture = SKTexture(imageNamed: fileNamed)
        texture.filteringMode = SKTextureFilteringMode.nearest
        node.texture = texture
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonPress(touch: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        if Right_Arrow.contains(location) || !Right_Arrow.contains(location){
            print("right end")
           Right_Arrow.alpha = 1
        }
        if Left_Arrow.contains(location) || !Left_Arrow.contains(location){
            print("left end")
           Left_Arrow.alpha = 1
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
    
    func buttonPress(touch: UITouch){
        enumerateChildNodes(withName: "//*") { (node, stop) in
            let location = touch.location(in: self)
            if node.name == "Right"{
                if (self.Right_Arrow.contains(location)){
                    self.Right_Arrow.alpha = 0.5
                    print("right begin")
                    self.Player.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 0))
                }
            }else  if node.name == "Left"{
                if (self.Left_Arrow.contains(location)){
                    self.Left_Arrow.alpha = 0.5
                    print("left begin")
                    self.Player.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 0))
                }
            }
        }
    }
}
