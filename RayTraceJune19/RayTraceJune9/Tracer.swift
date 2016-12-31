//
//  Tracer.swift
//  MatrixTest
//
//  Created by Student on 2016-05-16.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing Complete!

import Foundation

//base class Tracer, allows different types of ray tracing with different versions
//of the function trace_ray
class Tracer {
    //only member is the world to trace
    var w: World?
    //default initialization of world to nil
    init() {
        w = nil
    }
    //initialization with the world to trace
    init(worldptr: World?)
    {
        w = worldptr
    }
    //traces the rays and returns black, to be overriden in inherited classes
    func trace_ray(ray: Ray) -> RGBColor {
        return (black)
    }
    func trace_ray(ray: Ray, depth: Int) -> RGBColor {
        return (black)
    }
}