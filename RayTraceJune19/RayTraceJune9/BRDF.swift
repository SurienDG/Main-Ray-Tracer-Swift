//
//  BRDF.swift
//  MatrixTest
//
//  Created by Student on 2016-05-24.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing complete!

import Foundation
//BRDF class created solely to be overriden by subclasses, has no members, and no useful methods on its own
//BRDF stands for bidirectional reflectance distribution function
class BRDF
{
    init()
    {
        
    }
    
    init(brdf: BRDF)
    {
        
    }
    
   func clone() -> BRDF?
    {
       return BRDF()
    }
    
    func f(sr: ShadeRec, wo: Vector3D, wi: Vector3D) -> RGBColor
    {
        return black
    }
    
    func sample_f(sr: ShadeRec, wo: Vector3D, wi: Vector3D) -> RGBColor
    {
        return black
    }
    
    func sample_f(sr: ShadeRec, wo: Vector3D, wi: Vector3D, pdf: Float) -> RGBColor
    {
        return black
    }
    
    func rho(sr: ShadeRec, wo: Vector3D) -> RGBColor
    {
        return black
    }
}