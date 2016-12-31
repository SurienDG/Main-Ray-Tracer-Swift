//
//  Ray.swift
//  RGBColor
//
//  Created by Surien on 2016-04-27.
//  Copyright © 2016 Surien. All rights reserved.
//  Jordan Testing
//  Testing Complete!

import Foundation

class Ray
{

    var o:Point3D  	// origin
    var d:Vector3D     // direction
    
    // ---------------------------------------------------------------- default constructor
    //tested, works
    init ()
    {
        o=Point3D(a: 0.0)
        d=Vector3D(_x:  0.0, _y: 0.0, _z: 1.0)
    }
    
    // ---------------------------------------------------------------- constructor
    //tested, works
    init (let origin:Point3D, let dir: Vector3D)
    {
        o = origin
        d = dir
    }
    
    // ---------------------------------------------------------------- copy constructor
    //tested, works
    init (let ray:Ray)
    {
        o = ray.o
        d = ray.d
    }
    
}