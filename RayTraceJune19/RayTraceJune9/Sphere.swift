//
//  Sphere.swift
//  MatrixTest
//
//  Created by Jordan Long on 2016-05-30.
//  Copyright © 2016 Student. All rights reserved.
//  Surien Testing
// Testing Complete

import Foundation

class Sphere: GeometricObject
{
    var center: Point3D
    var radius: Double
    let kEpsilon: Double = 0.001
    //initialization functions for the sphere
    override init()
    {
        center = Point3D(a: 0.0)
        radius = 1.0
        super.init()
    }
    
    init(c: Point3D, r: Double)
    {
        center = c
        radius = r
        super.init()
    }
    
    override func clone() -> GeometricObject? {
        return self
    }
    //creating initializing the sphere the same as another sphere
    init(sphere: Sphere)
    {
        center = sphere.center
        radius = sphere.radius
        super.init(object: sphere)
    }
    //function to see whether a ray of light hits the sphere
    override func hit(ray: Ray, inout tmin: Double, inout sr: ShadeRec) -> Bool {
        //t is the value of time at which the ray hits the sphere
        var t: Double
        // is the centre of the sphere minus the rays origin
        let temp: Vector3D = ray.o - center
        //this calculates the length of the ray direction vector
        let a: Double = ray.d * ray.d
        //b is the dot product ray.d and the temp multiplied by 2
        let b: Double = 2 * temp * ray.d
        //this calculates the length of the temp vector squared and subtracts the radius giving the distance from the ray origin to the ooutside of the sphere
        let c: Double = temp * temp - radius * radius
        //this calculates the discriminant so that the # of roots can be determined
        let disc: Double = b*b - 4.0 * a * c
        
        //checks to see if there are anyreal roots, if not returns false
        if disc < 0.0
        {
            return false
        }
        else{
            //takes the square root of the discriminant to get part of the quadratic formula
            let e: Double = sqrt(disc)
            // gets the denominator portion of the quadratic formula
            let denom: Double = 2.0 * a
            //gets the smaller of the two roots
            t = (-b - e) / denom
           //checks to see if the first root is greater than kEpsilon(really small number)
            if t > kEpsilon
            {
                //sets the value of tmin to be t
                tmin = t
                 //calculates values for the new normal and the local_hit_point
                sr.normal = (Normal(v: temp) + t * Normal(v: ray.d)) / radius
                sr.local_hit_point = ray.o + t * ray.d
                return true
            }
            //gets the larher of the two roots
            t = (-b + e) / denom
            //checks to see if the first root is greater than kEpsilon(really small number)
            if t > kEpsilon
            {
                //sets the value of tmin to be t
                tmin = t
                //calculates values for the new normal and the local_hit_point
                sr.normal = (Normal(v: temp) + t * Normal(v: ray.d)) / radius
                sr.local_hit_point = ray.o + t * ray.d
                return true
            }
        }
        //returns false
        return false
    }
    //function that is to set the centre of the sphere
    func set_center(c: Point3D)
    {
        center = c
    }
    //function that is to set the centre of the sphere
    func set_center(x: Double, y: Double, z: Double)
    {
        center.x = x
        center.y = y
        center.z = z
    }
    //function that is to set the radius of the sphere
    func set_radius(r: Double)
    {
        radius = r
    }
}