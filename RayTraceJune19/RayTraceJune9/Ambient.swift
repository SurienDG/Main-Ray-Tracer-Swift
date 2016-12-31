//
//  Ambient.swift
//  MatrixTest
//
//  Created by Student on 2016-05-26.
//  Copyright © 2016 Student. All rights reserved.
//  Surien Testing
// Testing Completed

import Foundation

class Ambient: Light
{
    //float for ls value which is the radiance
    var ls: Float
    //variable for the value of RGBColor due to the lighting
    var color: RGBColor
    override init()
    {
        //sets the value of ls to 1.0
        ls = 1.0
        // gives all the parameters in the value color a value of 1.0
        color = RGBColor(c: 1.0)
        //initializes the rest of the parts of the super class
        super.init()
    }
    
    init(a: Ambient)
    {
        //assigns the value from the ambient being taken in to the ambient that calls the function
        ls = a.ls
        color = a.color
        super.init(ls: a)
    }
    
    func clone() -> Light?
    {
        return Ambient(a: self)
    }
    // gets the direction of the vector
    override func get_direction(s: ShadeRec) -> Vector3D {
        return Vector3D(a: 0.0)
    }
    //creates a modified RGBColor based on the radiance
    override func L(sr: ShadeRec) -> RGBColor {
        return (ls * color)
   }
    //sets the value for the radiance of the light
    func scale_radiance(b: Float)
    {
        ls = b
    }
    //allows a float to set the value of the colour
    func set_color(c: Float)
    {
        color.r = c
        color.g = c
        color.b = c
    }
    //allows the change of the value of the colour in the ambient
    func set_color(c: RGBColor)
    {
        color = c
    }
    //gives color specific red, green and blue values
    func set_color(r: Float, g: Float, b: Float)
    {
        color.r = r
        color.g = g
        color.b = b
    }
}