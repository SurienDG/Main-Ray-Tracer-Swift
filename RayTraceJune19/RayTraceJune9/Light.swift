//
//  Light.swift
//  MatrixTest
//
//  Created by Student on 2016-05-24.
//  Copyright © 2016 Student. All rights reserved.
//  Surien Testing
//Testing completed

import Foundation

//this is the class with all the functions dealing with light
class Light {
    init()
    {
        
    }
    //radiance 
    init(ls: Light)
    {
        
    
    }
    // this returns the color black as the RGBColor probably will have more functionality as more is added to the code
    func L(s: ShadeRec) -> RGBColor
    {
        return black
    }
    //this gets the direction of the light
    func get_direction(sr:ShadeRec) -> Vector3D
    {
        return Vector3D()
    }
}