//
//  GeometricObject.swift
//  RGBColor
//
//  Created by Surien on 2016-05-04.
//  Copyright © 2016 Surien. All rights reserved.
//  Surien Testing
// testing complete

import Foundation

// this file contains the definition of the class GeometricObject


class GeometricObject
{
    //this defines a material as an optional
    var material_ptr:Material?
    

    // this initializes the material to a value of nil
    init()
    {
        material_ptr = nil
    
    }


// ---------------------------------------------------------------------- copy constructor

    init (object: GeometricObject) {
        if(object.material_ptr != nil)
        {
            material_ptr = object.material_ptr!.clone()
        }
        else
        {
            material_ptr = nil
        }
    
    }


// ---------------------------------------------------------------- set_material

    func set_material(mPtr: Material?)
    {
        material_ptr = mPtr
    }
    //this creates a clone of a geometric object
    func clone() -> GeometricObject?
    {
        return GeometricObject()
    }
    //this function is to determine if a ray hits one of the geometric objects
    func hit(ray: Ray, inout tmin: Double, inout sr: ShadeRec) -> Bool
    {
        return false
    }
    //this gets the type of material of the object
    func get_material() -> Material?
    {
        return material_ptr
    }
}