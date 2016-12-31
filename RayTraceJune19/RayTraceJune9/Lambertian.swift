//
//  Lambertian.swift
//  MatrixTest
//
//  Created by Student on 2016-05-24.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing Complete!

import Foundation
//Lambertian distribution is for perfect diffuse reflection, where no light is absorbed as heat
class Lambertian: BRDF
{
    //diffuse reflection coefficient
    var kd: Float
    //diffuse color
    var cd: RGBColor
    
    //tested, works
    override init()
    {
        kd = 0.0
        cd = RGBColor(c: 0.0)
        super.init()
    }
    
    //tested, works
    init(lamb: Lambertian)
    {
        kd = lamb.kd
        cd = lamb.cd
        super.init(brdf: lamb)
    }
    
    //tested, works
    override func clone() -> Lambertian
    {
        return (self)
    }
    
    //not sure what this does, used in shade function in Matte class
    override func f(sr: ShadeRec, wo: Vector3D, wi: Vector3D) -> RGBColor
    {
        return (kd * Float(invPI) * cd)
    }
    
    //not sure what this does, something about reflection coefficient, used in shade function
    override func rho(sr: ShadeRec, wo: Vector3D) -> RGBColor
    {
        return (kd * cd)
    }
    
    //set ambient reflection coefficient, for use in further extensions, not used in this version
    func set_ka(k: Float)
    {
        kd = k
    }
    
    //set ambient reflection coefficient
    //tested, works
    func set_kd(k: Float)
    {
        kd = k
    }
    
    //set diffuse color from another color
    //tested, works
    func set_cd(c: RGBColor)
    {
        cd = c
    }
    
    //set diffuse color from 3 floats
    //tested, works
    func set_cd(r: Float, g: Float, b: Float)
    {
        cd.r = r
        cd.g = g
        cd.b = b
    }
    
    //set diffuse color from a single float
    //tested, works
    func set_cd(c: Float)
    {
        cd.r = c
        cd.g = c
        cd.b = c
    }
}