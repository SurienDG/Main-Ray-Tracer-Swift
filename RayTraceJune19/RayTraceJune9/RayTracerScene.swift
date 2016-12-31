//
//  File.swift
//  Ray Tracer Interface
//
//  Created by Surien on 2016-04-18.
//  Copyright © 2016 Surien. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    func apsectFillToSize(fillSize:CGSize)
    {
        if texture != nil
        {
            
            self.size = texture!.size()
            let verticalRatio = fillSize.height / self.texture!.size().height
            let horizontalRatio = fillSize.width / self.texture!.size().width
            let scaleRatio = horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio
            
            self.setScale(scaleRatio)
        }
    }
    
}
var screenMiddle:CGPoint!
var pixelMap:PixelMap!
class RayTracerScene: SKScene {
    
    override init(size: CGSize) {
        
        super.init(size: size)
        /* Setup your scene here */
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        scene!.scaleMode = SKSceneScaleMode.ResizeFill
        var w = World()
        var p = Pinhole()
        // find the middle of the screen
        screenMiddle = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        w.build()
        // initialize the sprite. This puts everything in place and makes the screen black
        pixelMap = PixelMap(scene: self, width: w.vp.hres, height: w.vp.vres, location: screenMiddle)
       
        w.render_scene()
    
        //code for rendering CIImage to screen that we ended up not using
        /*var image = w.render_scene() */
        
        
        
        /*// our rectangle for the drawing size
        let rect = CGRectMake(0, 0, image.size.width, image.size.height)
        // we create our graphics context at the size of our image
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.width, height: rect.height), true, 0)
        // we retrieve it
        //let context = UIGraphicsGetCurrentContext()
        // we set our color to white (this will be the text color)
        // we set our color to white (this will be the text color)
        
        
        // we draw our image to the graphics context
        image.drawInRect(rect)
        
        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // we create a texture, pass the UIImage
        var texture = SKTexture(image: newImage)
        // wrap it inside a sprite node
        var rayTracedImage = SKSpriteNode(texture:texture)
        
        // we position it
        rayTracedImage.anchorPoint = CGPointMake(0,1)
        rayTracedImage.position = CGPointMake (0, size.height-250)
        
        
        //self.addChild(rayTracedImage)*/
      
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}