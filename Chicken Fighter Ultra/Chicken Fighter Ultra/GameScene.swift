//
//  GameScene.swift
//  Chicken Figher Ultra
//
//  Created by 90308589 on 10/20/20.
//

import SpriteKit
import GameplayKit
import UIKit
//pog
//poggers

class GameScene: SKScene {
    var x_direction = ""
    var isAnimate = false
    var x_max_speed:CGFloat = 400
    var x_acc:CGFloat = 40
    var Right_Arrow = SKSpriteNode()
    var Platform = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 900, height: 100))
    var RightWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var LeftWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var Left_Arrow = SKSpriteNode()
    var Player = SKSpriteNode()
    let buttonSize = CGSize(width: 96 , height: 96)
    let CharacterSize = CGSize(width: 96 , height: 96)
   
    override func didMove(to view: SKView) {

        setup()
    }
    
    func setup(){
        set_names()
        set_textures()
        set_sizes()
        set_physics()
        set_positions()
        addchildren()
    }
    
    func set_names(){
        Platform.name = "Platform"
        RightWall.name = "RightWall"
        LeftWall.name = "LeftWall"
        Player.name = "Player"
        Right_Arrow.name = "Right"
        Left_Arrow.name = "Left"

    }
    
    func set_textures(){
        //set_filtering_mode(fileNamed: "Chickette_with_skirt", node: Player)
        //setTexture(folderName: "GooseWalk", sprite: Player, spriteName: "goose_walk",speed: 15)
        set_filtering_mode(fileNamed: "goose_stand", node: Player)
        set_filtering_mode(fileNamed: "RightArrow", node: Right_Arrow)
        set_filtering_mode(fileNamed: "LeftArrow", node: Left_Arrow)
    }
    
    func set_sizes(){
        Right_Arrow.size = buttonSize
        Player.size = CharacterSize
        Left_Arrow.size = buttonSize
    }
    
    func set_physics(){
        RightWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 900))
        RightWall.physicsBody?.affectedByGravity = false
        RightWall.physicsBody?.isDynamic = false
        
        LeftWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 900))
        LeftWall.physicsBody?.affectedByGravity = false
        LeftWall.physicsBody?.isDynamic = false
        Player.physicsBody = SKPhysicsBody(rectangleOf: CharacterSize)
        Player.physicsBody?.affectedByGravity = true
        Platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 900, height: 100))
        Platform.physicsBody?.affectedByGravity = false
        Platform.physicsBody?.friction = 1
        Platform.physicsBody?.isDynamic = false
    }
    
    func set_positions(){
        
        Platform.position = CGPoint(x: 0, y: -200)
        LeftWall.position = CGPoint(x: -450, y: 0)
        Left_Arrow.position = CGPoint(x: -300, y: -200)
        Right_Arrow.position = CGPoint(x: -200,y: -200)
        RightWall.position = CGPoint(x: 435, y: 0)
    }
    
    func addchildren(){
        addChild(Platform)
        addChild(Player)
        addChild(Left_Arrow)
        addChild(Right_Arrow)
        addChild(RightWall)
        addChild(LeftWall)
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
        if Right_Arrow.contains(location){
            print("right end")
           x_direction = ""
            Right_Arrow.alpha = 1
        }
        if Left_Arrow.contains(location){
            print("left end")
            x_direction = ""
            Left_Arrow.alpha = 1

        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if x_direction == "right"{
            if (Player.physicsBody?.velocity.dx)! < x_max_speed{
                Player.physicsBody?.velocity.dx += x_acc
                if (!isAnimate){
                    setTexture(folderName: "GooseWalk", sprite: Player, spriteName: "goose_walk",speed: 15)
                    isAnimate = true
                }
            }
            
        }else if x_direction == "left"{
            if (Player.physicsBody?.velocity.dx)! > -x_max_speed{
                Player.physicsBody?.velocity.dx -= x_acc
                self.Player.removeAllActions()
                isAnimate = false
            }
        }else {
            Player.removeAllActions()
            isAnimate = false
        }
        
    }
    
    func buttonPress(touch: UITouch){
        enumerateChildNodes(withName: "//*") { (node, stop) in
            let location = touch.location(in: self)
            if node.name == "Right"{
                if (self.Right_Arrow.contains(location)){
                    self.Right_Arrow.alpha = 0.5
                    print("right begin")
                    self.x_direction = "right"
                    
                }
            }else  if node.name == "Left"{
                if (self.Left_Arrow.contains(location)){
                    self.Left_Arrow.alpha = 0.5
                    print("left begin")
                    self.x_direction = "left"
                    
                }
            }
        }
    }
    
    func setTexture(folderName: String,sprite:SKSpriteNode,spriteName: String,speed:Double){
           let textureAtlas = SKTextureAtlas(named: folderName)
           var frames: [SKTexture] = []
           for i in 0...textureAtlas.textureNames.count - 1{
               let name = "\(spriteName)\(i).png"
               let texture = SKTexture(imageNamed: name)
               
               texture.filteringMode = SKTextureFilteringMode.nearest
               frames.append(texture)
           }
             
           let animation = SKAction.animate(with: frames, timePerFrame: 1/speed)
           sprite.run(SKAction.repeatForever(animation))
       }
}
