//
//  ShadeRec.swift
//  MatrixTest
//
//  Created by Student on 2016-05-02.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing complete!

import Foundation

class ShadeRec {
    var hit_an_object: Bool     //did the ray hit an object?
    var material: Material?		// Pointer to the nearest object's material
    var hit_point: Point3D			// World coordinates of intersection
    var local_hit_point: Point3D	// World coordinates of hit point on generic object (used for texture transformations)
    var normal: Normal				// Normal at hit point
    var ray: Ray				// Required for specular highlights and area lights
    var depth: Int				// recursion depth
    var t: Double    // ray parameter
    //var u: Float
    //var v: Float
    var w: World					// World reference
    var color: RGBColor //color to be displayed
				
    //constructor with defaults
    init(wr: World) {
        hit_an_object = false
        material = nil
        hit_point = Point3D()
        local_hit_point = Point3D()
        normal = Normal()
        ray = Ray()
        depth = 0
        color = black
        t = 0.0
        //u = 0.0
        //v = 0.0
        w = wr
    }
    
    //copy constructor
    init(sr: ShadeRec) {
        hit_an_object = sr.hit_an_object
        material = sr.material
        hit_point = sr.hit_point
        local_hit_point = sr.local_hit_point
        normal = sr.normal
        ray = sr.ray
        depth = sr.depth
        color = sr.color
        t = sr.t
        //u = sr.u
        //v = sr.v
        w = sr.w
    }
}