//
//  GameScene.swift
//  Chicken Figher Ultra
//
//  Created by 90308589 on 10/20/20.
//

import SpriteKit
import GameplayKit
import UIKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    var current_jumps = 0
    var max_jumps = 2
    var backround = SKSpriteNode()
    var dummy = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    var Punch_button = SKSpriteNode()
    var Right_Arrow = SKSpriteNode()
    var Platform = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 900, height: 100))
    var RightWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var LeftWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var jump_button = SKSpriteNode()
    var Left_Arrow = SKSpriteNode()
    var Player = Character(texture: SKTexture(imageNamed: "Chickette"))
    let buttonSize = CGSize(width: 96 , height: 96)
    let CharacterSize = CGSize(width: 96 , height: 96)
    var Play_Button = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    func setup(){
        Player.setvalues(jumps: 2, jump_vel: 300, max_x_speed: 200, acc: 200, size: CharacterSize)
        set_names()
        set_textures()
        set_sizes()
        set_physics()
        set_positions()
        setup_main_menu()
    }
    
    func set_names(){
        Platform.name = "Platform"
        RightWall.name = "RightWall"
        LeftWall.name = "LeftWall"
        Player.name = "Player"
        Right_Arrow.name = "Right"
        Left_Arrow.name = "Left"
        Play_Button.name = "PlayButton"
        jump_button.name = "JumpButton"
        Punch_button.name = "PunchButton"
        dummy.name = "dummy"
    }
    
    func set_textures(){
        set_filtering_mode(fileNamed: "RightArrow", node: Right_Arrow)
        set_filtering_mode(fileNamed: "LeftArrow", node: Left_Arrow)
        set_filtering_mode(fileNamed: "StartButton", node: Play_Button)
        set_filtering_mode(fileNamed: "JumpButton", node: jump_button)
        set_filtering_mode(fileNamed: "farmyard", node: backround)
        set_filtering_mode(fileNamed: "Punch Button", node: Punch_button)
        set_filtering_mode(fileNamed: "dummy", node: dummy)
    }
    
    func set_sizes(){
        Right_Arrow.size = buttonSize
        Player.size = CharacterSize
        Left_Arrow.size = buttonSize
        Play_Button.size = buttonSize
        jump_button.size = buttonSize
        Punch_button.size = buttonSize
        dummy.size = CharacterSize
        backround.size = CGSize(width: 1000, height: 800)
    }
    
    func set_physics(){
        
        //bit mask of 1 for player
        //bit mask of 2 for stuff like walls and platforms
        
        physicsWorld.contactDelegate = self
        RightWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 900))
        RightWall.physicsBody?.affectedByGravity = false
        RightWall.physicsBody?.isDynamic = false
        
        LeftWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 900))
        LeftWall.physicsBody?.affectedByGravity = false
        LeftWall.physicsBody?.isDynamic = false
       
        Platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 900, height: 100))
        Platform.physicsBody?.affectedByGravity = false
        Platform.physicsBody?.friction = 1
        Platform.physicsBody?.isDynamic = false
        Platform.physicsBody?.categoryBitMask = 2
        Platform.physicsBody?.contactTestBitMask = 1
        
        
        LeftWall.physicsBody?.categoryBitMask = 2
        RightWall.physicsBody?.categoryBitMask = 2
        
        dummy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
    }
    
    func set_positions(){
        
        Platform.position = CGPoint(x: 0, y: -200)
        LeftWall.position = CGPoint(x: -450, y: 0)
        Left_Arrow.position = CGPoint(x: -300, y: -200)
        Right_Arrow.position = CGPoint(x: -200,y: -200)
        RightWall.position = CGPoint(x: 435, y: 0)
        jump_button.position = CGPoint(x: 200, y: -200)
        Punch_button.position = CGPoint(x: 300, y: -200)
        backround.zPosition = -1
    }
    
    func setup_game_scene(){
        self.removeAllChildren()
        addChild(Platform)
        addChild(Player)
        addChild(Left_Arrow)
        addChild(Right_Arrow)
        addChild(RightWall)
        addChild(LeftWall)
        addChild(jump_button)
        addChild(backround)
        addChild(Punch_button)
        addChild(dummy)
    }
    
    
    func setup_main_menu(){
        self.removeAllChildren()
        addChild(Play_Button)
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
            Player.x_direction = ""
            Right_Arrow.alpha = 1
        }
        if Left_Arrow.contains(location){
            print("left end")
            Player.x_direction = ""
            Left_Arrow.alpha = 1

        }
        if jump_button.contains(location){
            print("jump end")
            jump_button.alpha = 1

        }
        if Punch_button.contains(location){
            print("punch end")
            Punch_button.alpha = 1
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        Player.update_character()
    }
    
    func buttonPress(touch: UITouch){
        enumerateChildNodes(withName: "//*") { [self] (node, stop) in
            let location = touch.location(in: self)
            if node.name == "Right"{
                if (self.Right_Arrow.contains(location)){
                    self.Right_Arrow.alpha = 0.5
                    print("right begin")
                    Player.x_direction = "right"
                    Player.isFly = false
                    
                }
            }else  if node.name == "Left"{
                if (self.Left_Arrow.contains(location)){
                    self.Left_Arrow.alpha = 0.5
                    print("left begin")
                    Player.x_direction = "left"
                    Player.isFly = false
                    
                }
            }else if node.name == "PlayButton"{
                if (self.Play_Button.contains(location)){
                    print("start")
                    self.setup_game_scene()
                }
            }else if node.name == "JumpButton"{
                if(self.jump_button.contains(location)){
                    self.jump_button.alpha = 0.5
                    print("jump")
                    if self.current_jumps < self.max_jumps{
                        self.current_jumps += 1
                        self.Player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Player.jump_velocity))
                        Player.isWalk = false
                    }
                }
            }else if node.name == "PunchButton"{
                if self.Punch_button.contains(location){
                    self.Punch_button.alpha = 0.5
                    print("punch")
                }
            }
        }
    }
    
   
    func addEmiter(loc: CGPoint,file:String){
        let emitter = SKEmitterNode(fileNamed: file)
        emitter?.name = "emitter"
        emitter?.zPosition = 2;
        emitter?.position = CGPoint(x: loc.x, y: loc.y )
        addChild(emitter!)
        
        emitter?.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),SKAction.removeFromParent()]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if nodeA!.name == "Player" && nodeB!.name == "Platform"{
            current_jumps = 0
            Player.isFly = false
        } else if nodeB!.name == "Player" && nodeA!.name == "Platform"{
            current_jumps = 0
            Player.isFly = false
        }
    }
}
