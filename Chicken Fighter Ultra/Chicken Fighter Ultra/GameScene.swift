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
    var cn = 0
    var max_jumps = 2
    var charbut1 = SKSpriteNode()
    var charbut2 = SKSpriteNode()
    var charbut3 = SKSpriteNode()
    var charbut4 = SKSpriteNode()
    var charback1 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
    var charback2 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
    var charback3 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
    var charback4 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
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
        Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize)
        Player.setAnimations(run_sprite: "goose_walk", run_folder: "gooseMove", fly_sprite:"goose_flying" , fly_folder: "goose_flying_good", attack_sprite: "", attack_folder: "")
        setup()
    }
    
    func setup(){
       
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
        charbut1.name = "charbut1"
        charbut2.name = "charbut2"
        charbut3.name = "charbut3"
        charbut4.name = "charbut4"
        charback1.name = "charback1"
        charback2.name = "charback2"
        charback3.name = "charback3"
        charback4.name = "charback4"
    }
    
    func set_textures(){
        set_filtering_mode(fileNamed: "RightArrow", node: Right_Arrow)
        set_filtering_mode(fileNamed: "LeftArrow", node: Left_Arrow)
        set_filtering_mode(fileNamed: "StartButton", node: Play_Button)
        set_filtering_mode(fileNamed: "JumpButton", node: jump_button)
        set_filtering_mode(fileNamed: "farmyard", node: backround)
        set_filtering_mode(fileNamed: "Punch Button", node: Punch_button)
        set_filtering_mode(fileNamed: "dummy", node: dummy)
        set_filtering_mode(fileNamed: "goose_stand", node: charbut1)
        set_filtering_mode(fileNamed: "penguin_walk0", node: charbut2)
        set_filtering_mode(fileNamed: "Chickette", node: charbut3)
        set_filtering_mode(fileNamed: "Chickette", node: charbut4)
    }
    
    func set_sizes(){
        Right_Arrow.size = buttonSize
        Player.size = CharacterSize
        Left_Arrow.size = buttonSize
        Play_Button.size = buttonSize
        jump_button.size = buttonSize
        Punch_button.size = buttonSize
        charbut1.size = CGSize(width: 80, height: 80)
        charbut2.size = CGSize(width: 80, height: 80)
        charbut3.size = CGSize(width: 80, height: 80)
        charbut4.size = CGSize(width: 80, height: 80)
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
        Play_Button.position = CGPoint(x: 0, y: -200)
        
        charbut1.position = CGPoint(x: -200, y: 100)
        charbut1.zPosition = 0
        charbut2.position = CGPoint(x: 200, y: 100)
        charbut2.zPosition = 0
        charbut3.position = CGPoint(x: -200, y: -100)
        charbut3.zPosition = 0
        charbut4.position = CGPoint(x: 200, y: -100)
        charbut4.zPosition = 0
        
        charback1.position = CGPoint(x: -200, y: 100)
        charback1.zPosition = -1
        charback2.position = CGPoint(x: 200, y: 100)
        charback2.zPosition = -1
        charback3.position = CGPoint(x: -200, y: -100)
        charback3.zPosition = -1
        charback4.position = CGPoint(x: 200, y: -100)
        charback4.zPosition = -1
        Platform.position = CGPoint(x: 0, y: -200)
        LeftWall.position = CGPoint(x: -450, y: 0)
        Left_Arrow.position = CGPoint(x: -300, y: -200)
        Right_Arrow.position = CGPoint(x: -200,y: -200)
        RightWall.position = CGPoint(x: 435, y: 0)
        jump_button.position = CGPoint(x: 200, y: -200)
        Punch_button.position = CGPoint(x: 300, y: -200)
        backround.zPosition = -2
    }
    
    func setup_game_scene(){
        self.removeAllChildren()
        if cn == 1{
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize)
            Player.setAnimations(run_sprite: "goose_walk", run_folder: "gooseMove", fly_sprite:"goose_flying" , fly_folder: "goose_flying_good", attack_sprite: "", attack_folder: "")
        }else if cn == 2{
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize)
            Player.setAnimations(run_sprite: "penguin_walk", run_folder: "Penguin_Walk", fly_sprite:"penguin_jump" , fly_folder: "Penguin_Jump", attack_sprite: "", attack_folder: "")
        }else if cn == 3{
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize)
            Player.setAnimations(run_sprite: "goose_walk", run_folder: "gooseMove", fly_sprite:"goose_flying" , fly_folder: "goose_flying_good", attack_sprite: "", attack_folder: "")
        }else if cn == 4{
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize)
            Player.setAnimations(run_sprite: "goose_walk", run_folder: "gooseMove", fly_sprite:"goose_flying" , fly_folder: "goose_flying_good", attack_sprite: "", attack_folder: "")
        }
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
        addChild(charbut1)
        addChild(charbut2)
        addChild(charbut3)
        addChild(charbut4)
        addChild(charback1)
        addChild(charback2)
        addChild(charback3)
        addChild(charback4)
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
        if Player.x_direction != "" && Player.position.y < 0{
            addEmiter(loc: CGPoint(x: Player.position.x, y: Player.position.y-Player.size.height/2), file: "PlayerWalkDust")
        }
        switch cn {
        case 1:
            charback1.color = UIColor.cyan
            charback2.color = UIColor.yellow
            charback3.color = UIColor.yellow
            charback4.color = UIColor.yellow
            break
        case 2:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.cyan
            charback3.color = UIColor.yellow
            charback4.color = UIColor.yellow
            break
        case 3:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.yellow
            charback3.color = UIColor.cyan
            charback4.color = UIColor.yellow
            break
        case 4:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.yellow
            charback3.color = UIColor.yellow
            charback4.color = UIColor.cyan
        default:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.yellow
            charback3.color = UIColor.yellow
            charback4.color = UIColor.yellow
            break
        }
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
            }else if node.name == "charback1"{
                if self.charback1.contains(location){
                    self.cn = 1
                    print("cn1")
                }
            }else if node.name == "charback2"{
                if self.charback2.contains(location){
                    self.cn = 2
                    print("cn2")
                }
            }else if node.name == "charback3"{
                if self.charback3.contains(location){
                    self.cn = 3
                    print("cn3")
                }
            }else if node.name == "charback4"{
                if self.charback4.contains(location){
                    self.cn = 4
                    print("cn4")
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
