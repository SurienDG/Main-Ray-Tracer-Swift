//
//  Matte.swift
//  MatrixTest
//
//  Created by Student on 2016-05-24.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing Complete
import Foundation

class Matte: Material
{
    var ambient_brdf: Lambertian?   //ambient reflectance follows Lambertian distribution
    var diffuse_brdf: Lambertian?   //diffuse reflectance follows Lambertian distribution
    
    //default initialization involves default init of superclass and Lambertians
    override init()
    {
        super.init()
        ambient_brdf = Lambertian()
        diffuse_brdf = Lambertian()
    }
    
    //initialization from another Matte
    init(m: Matte)
    {
        if m.ambient_brdf != nil
        {
            ambient_brdf = (m.ambient_brdf!.clone() as! Lambertian)
        }
        else
        {
            ambient_brdf = nil
        }
        if m.diffuse_brdf != nil
        {
            diffuse_brdf = (m.diffuse_brdf!.clone() as! Lambertian)
        }
        else
        {
            diffuse_brdf = nil
        }
        super.init(m: m)
    }
    
    override func clone() -> Matte?
    {
        return Matte(m: self)
    }
    
    override func shade(sr: ShadeRec) -> RGBColor
    {
        //wo set to negative ray direction
        let wo: Vector3D = -sr.ray.d
        //L stores colour, from ambient BRDF multiplied by ambient light source
        let L: RGBColor = ambient_brdf!.rho(sr, wo: wo) * sr.w.ambient_ptr!.L(sr)
        //number of elements in lights array
        let num_lights = sr.w.lights.count
        
        //loop through lights array
        for j in 0..<num_lights {
            //wi set to direction of the specific light
            let wi: Vector3D = sr.w.lights[j].get_direction(sr)
            let ndotwi: Double = sr.normal * wi //dot product of normal and wi
            
            //if the light directionis at an angle between 270 and 90 with the normal
            if ndotwi > 0.0
            {
                //add to L the colour from the diffuse brdf multiplied by the directional light
                //multiplied by the value of ndotwi, with a light parallel to the normal having the most effect
                L += diffuse_brdf!.f(sr, wo: wo, wi: wi) * sr.w.lights[j].L(sr) * Float(ndotwi)
            }
        }
        //return L, the sum of the effects of the ambient light and each individual directional light
        return L
    }
    
    //functions to set the member variables of matte
    func set_ka(ka: Float)
    {
        ambient_brdf!.set_kd(ka)
    }
    
    func set_kd(kd: Float)
    {
        diffuse_brdf!.set_kd(kd)
    }
    
    func set_cd(c: RGBColor)
    {
        ambient_brdf!.set_cd(c)
        diffuse_brdf!.set_cd(c)
    }
    
    func set_cd(r: Float, g: Float, b: Float)
    {
        ambient_brdf!.set_cd(r, g: g, b: b)
        diffuse_brdf!.set_cd(r, g: g, b: b)
    }
    
    func set_cd(c: Float)
    {
        ambient_brdf!.set_cd(c)
        diffuse_brdf!.set_cd(c)
    }
}
