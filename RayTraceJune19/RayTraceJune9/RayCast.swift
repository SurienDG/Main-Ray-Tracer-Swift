//
//  RayCast.swift
//  MatrixTest
//
//  Created by Student on 2016-05-19.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing Complete
import Foundation

class RayCast: Tracer {
    //initializing RayCast is same as initializing Tracer
    override init()
    {
        super.init()
    }
    
    override init(worldptr: World?)
    {
        super.init(worldptr: worldptr)
    }
    //
    override func trace_ray(ray: Ray) -> RGBColor {
        //shaderec returned from hit_objects function in world
        let sr: ShadeRec = w!.hit_objects(ray)
        
        //if the ray hit an object, return the colour provided by the shade function in material class
        if (sr.hit_an_object)
        {
            sr.ray = ray    //used for specular shading
            return (sr.material!.shade(sr))
        }
        //otherwise return the background colour
        else
        {
            return (w?.background_color)!
        }
    }
    //same as above function, depth is never used
    override func trace_ray(ray: Ray, depth: Int) -> RGBColor {
        let sr: ShadeRec = w!.hit_objects(ray)
        
        if (sr.hit_an_object)
        {
            sr.ray = ray    //used for specular shading
            return (sr.material!.shade(sr))
        }
        else
        {
            return (w?.background_color)!
        }
    }
}