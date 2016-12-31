//
//  main.swift
//  RayTracerMay31
//
//  Created by Student on 2016-05-31.
//  Copyright © 2016 Student. All rights reserved.
//
/*
import Foundation

var w = World()
w.build()
w.render_scene()


let width = 800
let height = 400
let zoom = 10

var pixelSet = makePixelSet(width, height, zoom)
//checked to see if right image is produced at the side
var image = UIImage(CIImage:imageFromPixels(pixelSet))
//image
// our rectangle for the drawing size
let rect = CGRectMake(0, 0, image.size.width, image.size.height)
// we create our graphics context at the size of our image
UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.width, height: rect.height), true, 0)
// we retrieve it
let context = UIGraphicsGetCurrentContext()
// we set our color to white (this will be the text color)
// we set our color to white (this will be the text color)


// we draw our image to the graphics context
image.drawInRect(rect)



let newImage = UIGraphicsGetImageFromCurrentImageContext()

// we create a texture, pass the UIImage
var texture = SKTexture(image: newImage)

// wrap it inside a sprite node
var sprite = SKSpriteNode(texture:texture)

// we scale it a bit
sprite.setScale(0.5)

// we position it
sprite.position = CGPoint (x: 510, y: 300)

self.addChild(sprite)
//  self.addChild(myLabel)
*/