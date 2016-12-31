//
//  SingleSphere.swift
//  MatrixTest
//
//  Created by Student on 2016-05-16.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Tested, works
import Foundation

class SingleSphere: Tracer {
    //initializing singlesphere is same as initializing Tracer
    override init()
    {
        super.init()
    }
    
    override init(worldptr: World?)
    {
        super.init(worldptr: worldptr)
    }
    
    //if the ray hits the sphere, return red, otherwise return black
    override func trace_ray(ray: Ray) -> RGBColor {
        var sr: ShadeRec = ShadeRec(wr: w!) //creates shaderec from world, not used
        var t:Double = 0    //not used
        
        //if the ray hits the sphere, return red
        if (w!.sphere.hit(ray, tmin: &t, sr: &sr)) {
            return(red)
        }
        //otherwise return black
        else {
            return(black)
        }
    }
}