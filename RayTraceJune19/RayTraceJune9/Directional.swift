//
//  Directional.swift
//  MatrixTest
//
//  Created by Student on 2016-05-24.
//  Copyright © 2016 Student. All rights reserved.
//  Surien Testing
//Testing Complete

import Foundation

class Directional: Light
{
    //float value that holds radiance
    var ls: Float
    //value for the colour associated with the light
    var color: RGBColor
    //the direction of the Vector3D
    var dir: Vector3D
    
    //initializes the value of the directional light
    override init()
    {
        //sets the value for the radiance
        ls = 1.0
        //sets the value for the colour
        color = RGBColor(c: 1.0)
        //sets the value for the direction of the vector
        dir = Vector3D(_x: 0, _y: 1, _z: 0)
        //initializes the super class's value
        super.init()
    }
    //initializes the function with a given direction
    init(dl: Directional)
    {
        //assigns the value of radiation from the direction taken in
        ls = dl.ls
        //assigns the value the direction's colour to the new direction
        color = dl.color
        //assigns the value of the direction vector to the new direction variable
        dir = dl.dir
        //initializes the rest of the variables in the super class
        super.init(ls: dl)
    }
    //creates a copy of the directional
    func clone() -> Directional?
    {
        return Directional(dl: self)
    }
    //returns the value of direction of light
    override func get_direction(sr: ShadeRec) -> Vector3D {
        return dir
    }
    //creates RGBColor based off the radiance of the light
   override func L(s: ShadeRec) -> RGBColor {
        return ls*color
    }
    //changes the value of the radiance of the light
    func scale_radiance(b: Float)
    {
        ls = b
    }
    //sets the value of the colour to a float value
    func set_color (c: Float)
    {
        color.r = c
        color.g = c
        color.b = c
    }
    // sets the value of a certain RGBColor to the colour
    func set_color (c: RGBColor)
    {
        color = c
    }
    //sets specific RGBvalues
    func set_color (r: Float, g: Float, b: Float)
    {
        color.r = r
        color.g = g
        color.b = b
    }
    //sets the direction from a vector3D
    func set_direction(d: Vector3D)
    {
        dir = d
        dir.normalize()
    }
    //sets the direction based off certain x, y, and z values
    func set_direction(dx: Double, dy: Double, dz: Double)
    {
        dir.x = dx
        dir.y = dy
        dir.z = dz
        dir.normalize()
    }
}