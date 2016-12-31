//
//  Plane.swift
//  MatrixTest
//
//  Created by Jordan Long on 2016-05-30.
//  Copyright © 2016 Student. All rights reserved.
//  Surien Testing
// Testing Complete

import Foundation

// function for the plane of geometric object
class Plane: GeometricObject
{
    //the variables for the point and the normal
    var a: Point3D
    var n: Normal
    let kEpsilon: Double = 0.001
    
    //initializes all the class objects
    override init()
    {
        a = Point3D(a: 0.0)
        n = Normal(_x: 0, _y: 1, _z: 0)
        super.init()
    }
    // the value of the Point3D and the normal are initialized
    //and the normal is  normalized
    init(point: Point3D, normal: Normal)
    {
        a = point
        n = normal
        
        n.normalize()
        super.init()
    }
    //initializes a copy of the plane
    init(plane: Plane)
    {
        
        a = plane.a
        n = plane.n
        super.init(object: plane)
    }
    
    //returns a clone of
    override func clone() -> Plane?
    {
        return self
    }
    //determines if an object is hit
    override func hit(ray: Ray, inout tmin: Double, inout sr: ShadeRec) -> Bool {
        let t: Double = (a - ray.o) * n / (ray.d * n)
        
        if t > kEpsilon
        {
            tmin = t
            sr.normal = n
            sr.local_hit_point = ray.o + t * ray.d
            
            return true
        }
        
        return false
    }
}