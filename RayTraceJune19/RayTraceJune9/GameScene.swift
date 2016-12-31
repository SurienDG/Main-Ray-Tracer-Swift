//
//  GameScene.swift
//  RayTraceJune9
//
//  Created by Student on 2016-06-09.
//  Copyright (c) 2016 Student. All rights reserved.
//

import SpriteKit


//var RayScene: SKScene!

class GameScene: SKScene {
    
    let button = UIButton(type: UIButtonType.System) as UIButton
    var sprite: SKSpriteNode!
    
    var hello = 0
    //code for the action done when button is pressed
    func btnAction (sender:UIButton!)
    {
        
        
        button.hidden=true
        button.enabled = false
        sprite.removeFromParent()
        //outputing the next scene with the ray traced image
        var RayScene = RayTracerScene(size: size)
        let reveal = SKTransition.flipHorizontalWithDuration(0)
        self.view?.presentScene(RayScene, transition: reveal)
        
    }
    override func didMoveToView(view: SKView) {
        
        
        
        
        
        
        //setup of home screen with buttons
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        sprite = SKSpriteNode(imageNamed:"HomeScreen.JPG")
        
        let ImageSize: UIImage = UIImage(imageLiteral:"HomeScreen.JPG")
        // 2
        backgroundColor = SKColor.whiteColor()
        
        sprite.xScale = CGFloat(screenSize.width)/CGFloat(ImageSize.size.width)
        sprite.yScale = CGFloat(screenSize.height)/CGFloat(ImageSize.size.height)
        
        sprite.position = CGPointMake(self.size.width/2, self.size.height/2)
        //1.35737704918033
        //print (self.size.height)
        self.addChild(sprite)
        
        button.frame = CGRectMake(screenSize.width*(20/414), screenSize.height*(530/736), screenSize.width*(370/414), screenSize.height*(100/736))
        print ("width + \(screenSize.width) + height: + \(screenSize.height)")
        
        button.backgroundColor = UIColor.blackColor()
        button.titleLabel!.font = UIFont(name: "Chalkduster", size: 30)!
        
        button.setTitle("Click To Trace", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        self.view!.addSubview(button)
        
        
        
        
        
        
        
        
        
        //  self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
