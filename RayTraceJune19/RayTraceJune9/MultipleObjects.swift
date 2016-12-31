//
//  MultipleObjects.swift
//  MatrixTest
//
//  Created by Student on 2016-05-19.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
// relies on hit_objects function

import Foundation

class MultipleObjects: Tracer
{
    //initialization is same as for superclass
    override init()
    {
        super.init()
    }
    override init(worldptr: World?)
    {
        super.init(worldptr: worldptr)
    }
    override func trace_ray(ray: Ray) -> RGBColor
    {
        //shaderec returned by the hit_objects function with ray argument in world class
        let sr: ShadeRec = w!.hit_objects(ray)
        
        //if the ray hit an object, return the ray calculated by the shaderec
        if (sr.hit_an_object)
        {
            return (sr.color)
        }
        //otherwise return the background colour
        else
        {
            return (w?.background_color)!
        }
    }
}