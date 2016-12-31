//
//  Material.swift
//  MatrixTest
//
//  Created by Student on 2016-05-24.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing complete!
//  Final Copy

import Foundation

//material base class, to be overriden by material types like matte -> see matte for details
class Material
{
    init()
    {
        
    }
    
    init(m: Material)
    {
        
    }
    
    func shade(sr: ShadeRec) -> RGBColor
    {
        return black
    }
    
    func clone() -> Material?
    {
        return Material()
    }
}