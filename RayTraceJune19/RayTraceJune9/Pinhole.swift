 //
//  Pinhole.swift
//  RGBColor
//
//  Created by Surien on 2016-05-02.
//  Copyright © 2016 Surien. All rights reserved.
//  Jordan Testing
//  need to test render_scene
import Foundation
import UIKit
 
class Pinhole: Camera
{

    var d:Double	// view plane distance
    var zoom:Float	// zoom factor
    
    //default constructor
    //tested, works
    override init()
    {
        d=500
        zoom=1.0
        super.init()
    }
    
    //copy constructor
    //tested, works
    init(c:Pinhole)
    {
        d=c.d
        zoom=c.zoom
        super.init(c: c)
    }
    
    //clone
    //tested, works
    override func clone() -> Pinhole?
    {
        return Pinhole(c: self)
    }
    
    //get direction from pinhole location towards point on the view plane
    //with negative z direction for use in ray object intersection calculations
    //tested, works
    func get_direction(p:Point2D) ->Vector3D
    {
        let dir:Vector3D = p.x * u + p.y * v - d * w
        dir.normalize()
    
        return(dir)
    }
    
    //tested, works
    func set_view_distance(_d: Double)
    {
        d = _d
    }
    
    //tested, works
    func set_zoom(zoom_factor: Float)
    {
        zoom = zoom_factor
    }
    
    //render scene function
    //still need to test
    override func render_scene(w:World) //-> UIImage 
    {
        var L:RGBColor  //colour to be displayed
        var vp:ViewPlane = w.vp //viewplane from world
        let ray = Ray()
        let depth = 0
        let pp = Point2D()		// sample point on a pixel
        let n:Int = Int(sqrt(Float(vp.num_samples)))    //squareroot of the number of samples in a pixel
        var arrayRGBColor = [PixelData](count: vp.hres * vp.vres, repeatedValue: PixelData())
        
        vp.s /= zoom    //pixel size divided by zoom
        ray.o = eye     //ray origin set to the eye placement of the camera
    
        for r in 0..<vp.vres
        {// loop through vertical pixels
            for c in 0..<vp.hres
            {		// loop across horizontal pixels
                L = black   //colour defaults to black
    
                for p in 0..<n
                {// loop up samples
        
                    for q in 0..<n
                    {	// loop across samples
                        //horizontal sample location + 0.5, divide by square root of samples in a pixel
                        let temp1a = (Double(q) + 0.5) / Double(n)
                        //horizontal pixel location - half of the total horizontal pixels, plus temp1a
                        let temp1 = Double(c) - 0.5 * Double(vp.hres) + temp1a
                        pp.x = Double(vp.s) * temp1 //pixel size * temp1 is x location of sample point on pixel
                        //similar calculations for vertical position on pixel
                        let temp2 = Double(r) - 0.5 * Double(vp.vres) + (Double(p) + 0.5) / Double(n)
                        pp.y = Double(vp.s) * temp2
                        //gets direction from pinhole to sample point on pixel
                        ray.d = get_direction(pp)
                        //traces the ray and adds the colour to L
                        L += w.tracer_ptr!.trace_ray(ray, depth: depth)
                    }
                    //divides L by the number of samples per pixel to get the average colour for the pixel
                    L /= Float(vp.num_samples)
                    L *= exposure_time      //colour shifts proportionate to exposure time
                    arrayRGBColor[c+r*vp.hres] = w.display_pixel(r, column: c, raw_color: L) //stores pixel color to array
                }
            }
            
        }
        //var pixels: ([PixelData], Int, Int) = (arrayRGBColor, vp.hres, vp.vres)
        //return UIImage(CIImage:w.imageFromPixels(pixels))
    }
 
}

