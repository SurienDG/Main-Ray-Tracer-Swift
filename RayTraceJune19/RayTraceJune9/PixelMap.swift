//
//  PixelMap.swift
//  Pixmap Display
//
//  Created by Lee Fryer-Davis on 2016-06-10.
//  Copyright © 2016 Lee Fryer-Davis. All rights reserved.
//

// This class contains a sprite that has a mutable texture, which allows the texture to be
// modified on a pixel-by-pixel basis.
// Each pixel is a packed 32 bit data structure with red, green, blue, and alpha components.
// The pixels are modified using the SKMutableTexture, which is the same as a SKTexture, but
// has a method modifyPixelDataWithBlock, which is an anonymous function that treats the
// entire texture as a single chunk of data in memory.

import SpriteKit

// packed 32 bit data structure to represent a single pixel colour. Alpha indicates transparency.
struct PixelData {
    var r: UInt8 = 0
    var g: UInt8 = 0
    var b: UInt8 = 0
    var a: UInt8 = 255
}

class PixelMap {
    var width:Int?
    var height:Int?
    var location:CGPoint?
    var texture:SKMutableTexture?   // allows access to updates to the pixels in the sprite
    var pixelSprite:SKSpriteNode?
    var scene:SKScene?  // scene where the spriteNode is stored
    
    init(scene:SKScene, width:Int, height:Int, location:CGPoint) {
        self.width = width
        self.height = height
        self.scene = scene
        self.location = location
        
        let numPixels:CGSize = CGSize(width: CGFloat(width), height:CGFloat(height))
        
        texture = SKMutableTexture(size: numPixels) // create the texture
        
        // fill the texture with empty data to start
        // This function calls the block and the parameters are given
        texture?.modifyPixelDataWithBlock{ (voidptr, len) in
            // take the pixel data and convert into a pointer with the colour structure
            let rgbaptr = UnsafeMutablePointer<PixelData>(voidptr)
            // len is in bytes. we want the number of pixels instead
            let numPixels = len / 4
            
            // change every pixel to black. Each colour component goes from 0 to 255
            for index in 0 ..< numPixels {
                rgbaptr[index].r = 0
                rgbaptr[index].g = 0
                rgbaptr[index].b = 0
                rgbaptr[index].a = 255
            }
        }
        
        // make a new sprite with the mutable texture
        pixelSprite = SKSpriteNode(texture: texture)
        
        // put in the appropriate spot on the screen
        pixelSprite?.position = self.location!
        
        // add to the scene
        scene.addChild(pixelSprite!)
    }
    
    func setColour(index:Int, colour:PixelData) {
        // modify the texture, which then will modify what is on the screen. Again using a block
        texture?.modifyPixelDataWithBlock{ (voidptr, len) in
            let rgbaptr = UnsafeMutablePointer<PixelData>(voidptr)
            
            // since the pixel data is flat instead of a 2D array, we have to index into it properly
            
            // update the appropriate pixel in the flat array
            rgbaptr[index] = colour
        }
    }
}
