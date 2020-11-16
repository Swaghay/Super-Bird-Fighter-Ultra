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
    var x_direction = ""
    var isWalk = false
    var isFly = false
    var current_jumps = 0
    var max_jumps = 2
    var backround = SKSpriteNode()
    var jump_velocity = 250
    var x_max_speed:CGFloat = 400
    var x_acc:CGFloat = 40
    var Right_Arrow = SKSpriteNode()
    var Platform = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 900, height: 100))
    var RightWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var LeftWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var jump_button = SKSpriteNode()
    var Left_Arrow = SKSpriteNode()
    var Player = SKSpriteNode()
    let buttonSize = CGSize(width: 96 , height: 96)
    let CharacterSize = CGSize(width: 96 , height: 96)
    var Play_Button = SKSpriteNode()
    
    override func didMove(to view: SKView) {

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
    }
    
    func set_textures(){
        //set_filtering_mode(fileNamed: "Chickette_with_skirt", node: Player)
        //setTexture(folderName: "GooseWalk", sprite: Player, spriteName: "goose_walk",speed: 15)
        set_filtering_mode(fileNamed: "goose_stand", node: Player)
        set_filtering_mode(fileNamed: "RightArrow", node: Right_Arrow)
        set_filtering_mode(fileNamed: "LeftArrow", node: Left_Arrow)
        set_filtering_mode(fileNamed: "StartButton", node: Play_Button)
        set_filtering_mode(fileNamed: "JumpButton", node: jump_button)
        set_filtering_mode(fileNamed: "farmyard", node: backround)
    }
    
    func set_sizes(){
        Right_Arrow.size = buttonSize
        Player.size = CharacterSize
        Left_Arrow.size = buttonSize
        Play_Button.size = buttonSize
        jump_button.size = buttonSize
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
        Player.physicsBody = SKPhysicsBody(rectangleOf: CharacterSize)
        Player.physicsBody?.affectedByGravity = true
        Player.physicsBody?.allowsRotation = false
        Platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 900, height: 100))
        Platform.physicsBody?.affectedByGravity = false
        Platform.physicsBody?.friction = 1
        Platform.physicsBody?.isDynamic = false
        Platform.physicsBody?.categoryBitMask = 2
        Platform.physicsBody?.contactTestBitMask = 1
        Player.physicsBody?.categoryBitMask = 1
        Player.physicsBody?.collisionBitMask = 2
        Player.physicsBody?.contactTestBitMask = 2
        
        LeftWall.physicsBody?.categoryBitMask = 2
        RightWall.physicsBody?.categoryBitMask = 2
    }
    
    func set_positions(){
        
        Platform.position = CGPoint(x: 0, y: -200)
        LeftWall.position = CGPoint(x: -450, y: 0)
        Left_Arrow.position = CGPoint(x: -300, y: -200)
        Right_Arrow.position = CGPoint(x: -200,y: -200)
        RightWall.position = CGPoint(x: 435, y: 0)
        jump_button.position = CGPoint(x: 200, y: -200)
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
           x_direction = ""
            Right_Arrow.alpha = 1
        }
        if Left_Arrow.contains(location){
            print("left end")
            x_direction = ""
            Left_Arrow.alpha = 1

        }
        if jump_button.contains(location){
            print("jump end")
            jump_button.alpha = 1

        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if x_direction != "" && Player.position.y < 0{
            addEmiter(loc: CGPoint(x: Player.position.x, y: Player.position.y-CharacterSize.height/2), file: "PlayerWalkDust")
        }

        if x_direction == "right" && !isFly{
            if (Player.physicsBody?.velocity.dx)! < x_max_speed{
                Player.physicsBody?.velocity.dx += x_acc
                if (!isWalk){
                    self.Player.removeAllActions()
                    setTexture(folderName: "gooseMove", sprite: Player, spriteName: "goose_walk",speed: 100)
                    Player.xScale = 1
                    isWalk = true
                }
            }
        }else if x_direction == "left" && !isFly{
            if (Player.physicsBody?.velocity.dx)! > -x_max_speed{
                Player.physicsBody?.velocity.dx -= x_acc
                if (!isWalk){
                    self.Player.removeAllActions()
                    setTexture(folderName: "gooseMove", sprite: Player, spriteName: "goose_walk",speed: 100)
                    Player.xScale = -1
                    isWalk = true
                }
            }
        }else if (Player.physicsBody?.velocity.dy)! >= 5 && !isWalk{
            if x_direction == "left"{
                Player.xScale = -1
                print("Abhay left")
            }else{
                Player.xScale = 1
                print("Abhay right")
            }
            if (!isFly){
                self.Player.removeAllActions()
                setTexture(folderName: "gooseflying", sprite: Player, spriteName: "goose_flying",speed: 15)
                isWalk = false
                isFly = true
            }
            
        }else {
            Player.removeAllActions()
            isWalk = false
            isFly = false
        }
        
    }
    
    func buttonPress(touch: UITouch){
        enumerateChildNodes(withName: "//*") { [self] (node, stop) in
            let location = touch.location(in: self)
            if node.name == "Right"{
                if (self.Right_Arrow.contains(location)){
                    self.Right_Arrow.alpha = 0.5
                    print("right begin")
                    self.x_direction = "right"
                    self.isFly = false
                    
                }
            }else  if node.name == "Left"{
                if (self.Left_Arrow.contains(location)){
                    self.Left_Arrow.alpha = 0.5
                    print("left begin")
                    self.x_direction = "left"
                    self.isFly = false
                    
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
                        self.Player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self.jump_velocity))
                        self.isWalk = false
                    }
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
            isFly = false
        } else if nodeB!.name == "Player" && nodeA!.name == "Platform"{
            current_jumps = 0
            isFly = false
        }
    }
}
