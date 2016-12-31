//
//  World.swift
//  MatrixTest
//
//  Created by Student on 2016-05-16.
//  Copyright © 2016 Student. All rights reserved.
//  Testing Complete

//fix call to raytracing library

import Foundation
import CoreImage
import UIKit

class World {
    //declares world variables
    var vp = ViewPlane()
    var background_color = RGBColor()
    var tracer_ptr: Tracer? //replacing ptrs with optionals
    var ambient_ptr: Light?
    var camera_ptr: Pinhole?
    var sphere = Sphere()
    var objects = [GeometricObject]() //array of geometric objects
    var lights = [Light]()
    
//    var paintArea: RenderThread?    //originally a pointer to wxRaytracer.h
    
    init()
    {
        background_color = black
        tracer_ptr = nil
        ambient_ptr = Ambient()
        camera_ptr = nil
    }
    // function used to render the scene that used to render UIImage but instead writes to mutable texture
    func render_scene() //-> UIImage
    {
        //
        var pixel_color = RGBColor()
        let ray = Ray()
        let hres: Int = vp.hres
        let vres: Int = vp.vres
        let s: Float = vp.s
        let zw: Float = 100.0
        //array of pixels (RGBColorUInt
        var arrayRGBColor = [PixelData](count: vp.hres * vp.vres, repeatedValue: PixelData())
        
        ray.d = Vector3D(_x: 0,_y: 0,_z: -1)
        
        //loop to render the pixels in the correct
        for r in 0..<vres
        {
            for c in 0..<hres
            {
                //calculates the value of the origin of the ray
                ray.o = Point3D(a: Double(s)*(Double(c) - Double(hres) / 2.0 + 5.0),
                                b: Double(s) * (Double(r) - Double(vres) / 2.0 + 0.5), c: Double(zw))
                //gets the pixel colour from the tracer
                pixel_color = (tracer_ptr?.trace_ray(ray))!
                //add pixels to RGBColorUInt array
                arrayRGBColor[c + r * hres] = display_pixel(r, column: c, raw_color: pixel_color)
                pixelMap.setColour(c + r * hres, colour:arrayRGBColor[c+r*hres])
            }
        }
        
        //let pixels: ([PixelData], Int, Int) = (arrayRGBColor, vp.hres, vp.vres)
        //return UIImage(CIImage:imageFromPixels(pixels))
    }

    //makes the max value in the RGBColor 1
    func max_to_one(c: RGBColor) -> RGBColor
    {
        let max_value: Float = max(c.r, max(c.g,c.b))
        
        if (max_value > 1.0)
        {
            return c/max_value
        }
        else
        {
            return c
        }
    }
    //makes the colour red if it's max value is greater than one
    func clamp_to_color(raw_color: RGBColor) -> RGBColor
    {
        let c: RGBColor = raw_color
        
        if ((raw_color.r > 1.0) || (raw_color.g > 1.0) || (raw_color.b > 1.0))
        {
            c.r = 1.0
            c.g = 0.0
            c.b = 0.0
        }
        
        return c
    }
    
    // ---------------------------------------------------------------------------display_pixel
    // raw_color is the pixel color computed by the ray tracer
    // its RGB floating point components can be arbitrarily large
    // mapped_color has all components in the range [0, 1], but still floating point
    // display color has integer components for computer display
    // the Mac's components are in the range [0, 65535]
    // a PC's components will probably be in the range [0, 255]
    // the system-dependent code is in the function convert_to_display_color
    // the function SetCPixel is a Mac OS function
    
    //function used to create teh pixels
    func display_pixel(row: Int, column: Int, raw_color: RGBColor) -> PixelData
    {
        var mapped_color: RGBColor
        
        if (vp.show_out_of_gamut)
        {
            mapped_color = clamp_to_color(raw_color)
        }
        else
        {
            mapped_color = max_to_one(raw_color)
        }
        
        if (vp.gamma != 1.0)
        {
            mapped_color = mapped_color.powc(vp.inv_gamma)
        }
        
        var x: Int = column
        var y: Int = vp.vres - row - 1
        
        return PixelData(r: UInt8(mapped_color.r * 255), g: UInt8(mapped_color.g * 255), b: UInt8(mapped_color.b * 255), a: 255)
        
        /*paintArea.setPixel(x,y, Int(mapped_color.r * 255), Int(mapped_color.g * 255),
                                Int(mapped_color.b * 255))*/
    }
    /*
    //this function was aquired from a swift ray tracing tutorial
    func imageFromPixels(pixels: ([RGBColorUInt], width: Int, height: Int)) -> CIImage {
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue) // alpha is last
        let providerRef = CGDataProviderCreateWithCFData(NSData(bytes: pixels.0, length: pixels.0.count * sizeof(RGBColorUInt)))
        let image = CGImageCreate(pixels.1, pixels.2, bitsPerComponent, bitsPerPixel, pixels.1 * sizeof(RGBColorUInt), rgbColorSpace, bitmapInfo, providerRef, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
        return CIImage(CGImage: image!)
    }*/
    //function to check whether rays of light are hitting the objects
    func hit_objects(ray: Ray) -> ShadeRec
    {
        var sr = ShadeRec(wr: self)
        var t: Double = 0
        var normal = Normal()
        var local_hit_point = Point3D()
        var tmin:Float = Float(kHugeValue)
        let num_objects: Int = objects.count
        //loop to go through all the objects and changes parameter based on whether the object was hit or not
        for j in 0..<num_objects
        {
            
            if (objects[j].hit(ray, tmin: &t, sr: &sr) && (t < Double(tmin)))
            {
                
                sr.hit_an_object = true
                tmin = Float(t)
                sr.material = objects[j].get_material()
                sr.hit_point = ray.o + t * ray.d
                normal = sr.normal
                local_hit_point = sr.local_hit_point
            }
            if (sr.hit_an_object)
            {
                sr.t = Double(tmin)
                sr.normal = normal
                sr.local_hit_point = local_hit_point
            }
        }
        return(sr)
    }
    
    //Deletes objects in the objects array
    func delete_objects()
    {
        objects.removeAll()
    }
    
    func delete_lights()
    {
        lights.removeAll()
    }
    
    func add_object(object_ptr: GeometricObject)
    {
        objects.append(object_ptr)
    }
    
    func add_light(light_ptr: Light)
    {
        lights.append(light_ptr)
    }
    
    func set_ambient_light(light_ptr: Light)
    {
        ambient_ptr = light_ptr
    }
    
    func set_camera(c_ptr: Pinhole?)
    {
        camera_ptr = c_ptr
    }
    //build function to initialize the all the objects and lights/cameras
    func build()
    {
        /* Setup your scene here */
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        var num_samples: Int = 1
        vp.set_hres(Int(screenSize.width))
        vp.set_vres(Int(screenSize.height))
        vp.set_pixel_size(0.5)
        vp.set_samples(num_samples)
        // creates an ambient pointer
        var ambient_ptr = Ambient()
        //sets the radiance of the ambient
        ambient_ptr.scale_radiance(1.0)
        //sets the ambient light value
        set_ambient_light(ambient_ptr)
        //sets the background color of the scene
        background_color = black
        
        //chooses the tracer type
        tracer_ptr = RayCast(worldptr: self)
        
        //initializes the pinhole camera parameters
        var pinhole_ptr = Pinhole()
        pinhole_ptr.set_eye(Point3D(a: 0,b: 0,c: 500))
        pinhole_ptr.set_lookat(Point3D(a: 0))
        pinhole_ptr.set_view_distance(600)
        pinhole_ptr.compute_uvw()
        set_camera(pinhole_ptr)
        //initilizes the directional light source
        var light_ptr1 = Directional()
        light_ptr1.set_direction(100, dy: 100, dz: 200)
        light_ptr1.scale_radiance(3.0)
        add_light(light_ptr1)
        
        //initializes the values for colours
        let yellow = RGBColor(_r: 1,_g: 1,_b: 0)
        let brown = RGBColor(_r: 0.71, _g: 0.4, _b: 0.16)
        let darkGreen = RGBColor(_r: 0,_g: 0.41,_b: 0.41)
        let orange = RGBColor(_r: 1, _g: 0.75, _b: 0)
        let green = RGBColor(_r: 0, _g: 0.6,_b: 0.3)
        let lightGreen = RGBColor(_r: 0.65, _g: 1, _b: 0.3)
        let darkYellow = RGBColor(_r: 0.61, _g: 0.61, _b: 0)
        let lightPurple = RGBColor(_r: 0.65,_g: 0.3,_b: 1)
        let darkPurple = RGBColor(_r: 0.5, _g: 0, _b: 1)
        let grey = RGBColor(c: 0.25)
        
        let ka: Float = 0.25
        let kd: Float = 0.75
        
        // spheres definitions (including choosing material type and colour)
        let matte_ptr1 = Matte();
        matte_ptr1.set_ka(ka);
        matte_ptr1.set_kd(kd);
        matte_ptr1.set_cd(yellow);
        let sphere_ptr1 = Sphere(c: Point3D(a: 5, b: 3, c: 0), r: 30);
        sphere_ptr1.set_material(matte_ptr1);	   							// yellow
        add_object(sphere_ptr1);
        
        let matte_ptr2 =  Matte();
        matte_ptr2.set_ka(ka);
        matte_ptr2.set_kd(kd);
        matte_ptr2.set_cd(brown);
        let	sphere_ptr2 =  Sphere(c: Point3D(a: 45, b: -7, c: -60), r: 20);
        sphere_ptr2.set_material(matte_ptr2);								// brown
        add_object(sphere_ptr2);
        
        
        let matte_ptr3 =  Matte();
        matte_ptr3.set_ka(ka);
        matte_ptr3.set_kd(kd);
        matte_ptr3.set_cd(darkGreen);
        let	sphere_ptr3 =  Sphere(c: Point3D(a: 40, b: 43, c: -100), r: 17);
        sphere_ptr3.set_material(matte_ptr3);								// dark green
        add_object(sphere_ptr3);
        
        let matte_ptr4 =  Matte();
        matte_ptr4.set_ka(ka);
        matte_ptr4.set_kd(kd);
        matte_ptr4.set_cd(orange);
        let	sphere_ptr4 =  Sphere(c: Point3D(a: -20, b: 28, c: -15), r: 20);
        sphere_ptr4.set_material(matte_ptr4);								// orange
        add_object(sphere_ptr4);
        
        let matte_ptr5 =  Matte();
        matte_ptr5.set_ka(ka);
        matte_ptr5.set_kd(kd);
        matte_ptr5.set_cd(green);
        let	sphere_ptr5 =  Sphere(c: Point3D(a: -25, b: -7, c: -35), r: 27);
        sphere_ptr5.set_material(matte_ptr5);								// green
        add_object(sphere_ptr5);
        
        let matte_ptr6 =  Matte();
        matte_ptr6.set_ka(ka);
        matte_ptr6.set_kd(kd);
        matte_ptr6.set_cd(lightGreen);
        let	sphere_ptr6 =  Sphere(c: Point3D(a: 20, b: -27, c: -35), r: 25);
        sphere_ptr6.set_material(matte_ptr6);								// light green
        add_object(sphere_ptr6);
        
        let matte_ptr7 =  Matte();
        matte_ptr7.set_ka(ka);
        matte_ptr7.set_kd(kd);
        matte_ptr7.set_cd(green);
        let	sphere_ptr7 =  Sphere(c: Point3D(a: 35, b: 18, c: -35), r: 22);
        sphere_ptr7.set_material(matte_ptr7);   							// green
        add_object(sphere_ptr7);
        
        let matte_ptr8 =  Matte();
        matte_ptr8.set_ka(ka);
        matte_ptr8.set_kd(kd);
        matte_ptr8.set_cd(brown);
        let	sphere_ptr8 =  Sphere(c: Point3D(a: -57, b: -17, c: -50), r: 15);
        sphere_ptr8.set_material(matte_ptr8);								// brown
        add_object(sphere_ptr8);
        
        let matte_ptr9 =  Matte();
        matte_ptr9.set_ka(ka);
        matte_ptr9.set_kd(kd);
        matte_ptr9.set_cd(lightGreen);
        let	sphere_ptr9 =  Sphere(c: Point3D(a: -47, b: 16, c: -80), r: 23);
        sphere_ptr9.set_material(matte_ptr9);								// light green
        add_object(sphere_ptr9);
        
        let matte_ptr10 =  Matte();
        matte_ptr10.set_ka(ka);
        matte_ptr10.set_kd(kd);
        matte_ptr10.set_cd(darkGreen);
        let	sphere_ptr10 =  Sphere(c: Point3D(a: -15, b: -32, c: -60), r: 22);
        sphere_ptr10.set_material(matte_ptr10);     						// dark green
        add_object(sphere_ptr10);
        
        let matte_ptr11 =  Matte();
        matte_ptr11.set_ka(ka);
        matte_ptr11.set_kd(kd);
        matte_ptr11.set_cd(darkYellow);
        let	sphere_ptr11 =  Sphere(c: Point3D(a: -35, b: -37, c: -80), r: 22);
        sphere_ptr11.set_material(matte_ptr11);							// dark yellow
        add_object(sphere_ptr11);
        
        let matte_ptr12 =  Matte();
        matte_ptr12.set_ka(ka);
        matte_ptr12.set_kd(kd);
        matte_ptr12.set_cd(darkYellow);
        let	sphere_ptr12 =  Sphere(c: Point3D(a: 10, b: 43, c: -80), r: 22);
        sphere_ptr12.set_material(matte_ptr12);							// dark yellow
        add_object(sphere_ptr12);
        
        let matte_ptr13 =  Matte();
        matte_ptr13.set_ka(ka);
        matte_ptr13.set_kd(kd);
        matte_ptr13.set_cd(darkYellow);
        let	sphere_ptr13 =  Sphere(c: Point3D(a: 30, b: -7, c: -80), r: 10);
        sphere_ptr13.set_material(matte_ptr13);
        add_object(sphere_ptr13);											// dark yellow (hidden)
        
        let matte_ptr14 =  Matte();
        matte_ptr14.set_ka(ka);
        matte_ptr14.set_kd(kd);
        matte_ptr14.set_cd(darkGreen);
        let	sphere_ptr14 =  Sphere(c: Point3D(a: -40, b: 48, c: -110), r: 18);
        sphere_ptr14.set_material(matte_ptr14); 							// dark green
        add_object(sphere_ptr14);
        
        
        
        let matte_ptr15 =  Matte();
        matte_ptr15.set_ka(ka);
        matte_ptr15.set_kd(kd);
        matte_ptr15.set_cd(brown);
        let	sphere_ptr15 =  Sphere(c: Point3D(a: -10, b: 53, c: -120), r: 18);
        sphere_ptr15.set_material(matte_ptr15); 							// brown
        add_object(sphere_ptr15);
        
        let matte_ptr16 =  Matte();
        matte_ptr16.set_ka(ka);
        matte_ptr16.set_kd(kd);
        matte_ptr16.set_cd(lightPurple);
        let	sphere_ptr16 =  Sphere(c: Point3D(a: -55, b: -52, c: -100), r: 10);
        sphere_ptr16.set_material(matte_ptr16);							// light purple
        add_object(sphere_ptr16);
        
        let matte_ptr17 =  Matte();
        matte_ptr17.set_ka(ka);
        matte_ptr17.set_kd(kd);
        matte_ptr17.set_cd(brown);
        let	sphere_ptr17 =  Sphere(c: Point3D(a: 5, b: -52, c: -100), r: 15);
        sphere_ptr17.set_material(matte_ptr17);							// browm
        add_object(sphere_ptr17);
        
        let matte_ptr18 =  Matte();
        matte_ptr18.set_ka(ka);
        matte_ptr18.set_kd(kd);
        matte_ptr18.set_cd(darkPurple);
        let	sphere_ptr18 =  Sphere(c: Point3D(a: -20, b: -57, c: -120), r: 15);
        sphere_ptr18.set_material(matte_ptr18);							// dark purple
        add_object(sphere_ptr18);
        
        let matte_ptr19 =  Matte();
        matte_ptr19.set_ka(ka);
        matte_ptr19.set_kd(kd);
        matte_ptr19.set_cd(darkGreen);
        let	sphere_ptr19 =  Sphere(c: Point3D(a: 55, b: -27, c: -100), r: 17);
        sphere_ptr19.set_material(matte_ptr19);							// dark green
        add_object(sphere_ptr19);
        
        let matte_ptr20 =  Matte();
        matte_ptr20.set_ka(ka);
        matte_ptr20.set_kd(kd);
        matte_ptr20.set_cd(brown);
        let	sphere_ptr20 =  Sphere(c: Point3D(a: 50, b: -47, c: -120), r: 15);
        sphere_ptr20.set_material(matte_ptr20);							// browm
        add_object(sphere_ptr20);
        
        let matte_ptr21 =  Matte();
        matte_ptr21.set_ka(ka);
        matte_ptr21.set_kd(kd);
        matte_ptr21.set_cd(lightPurple);
        let	sphere_ptr21 =  Sphere(c: Point3D(a: 70, b: -42, c: -150), r: 10);
        sphere_ptr21.set_material(matte_ptr21);							// light purple
        add_object(sphere_ptr21);
        
        let matte_ptr22 =  Matte();
        matte_ptr22.set_ka(ka);
        matte_ptr22.set_kd(kd);
        matte_ptr22.set_cd(lightPurple);
        let	sphere_ptr22 =  Sphere(c: Point3D(a: 5, b: 73, c: -130), r: 12);
        sphere_ptr22.set_material(matte_ptr22);							// light purple
        add_object(sphere_ptr22);
        
        let matte_ptr23 =  Matte();
        matte_ptr23.set_ka(ka);
        matte_ptr23.set_kd(kd);
        matte_ptr23.set_cd(darkPurple);
        let	sphere_ptr23 =  Sphere(c: Point3D(a: 66, b: 21, c: -130), r: 13);
        sphere_ptr23.set_material(matte_ptr23);							// dark purple
        add_object(sphere_ptr23);
        
        let matte_ptr24 =  Matte();
        matte_ptr24.set_ka(ka);
        matte_ptr24.set_kd(kd);
        matte_ptr24.set_cd(lightPurple);
        let	sphere_ptr24 =  Sphere(c: Point3D(a: 72, b: -12, c: -140), r: 12);
        sphere_ptr24.set_material(matte_ptr24);							// light purple
        add_object(sphere_ptr24);
        
        let matte_ptr25 =  Matte();
        matte_ptr25.set_ka(ka);
        matte_ptr25.set_kd(kd);
        matte_ptr25.set_cd(green);
        let	sphere_ptr25 =  Sphere(c: Point3D(a: 64, b: 5, c: -160), r: 11);
        sphere_ptr25.set_material(matte_ptr25);					 		// green
        add_object(sphere_ptr25);
        
        let matte_ptr26 =  Matte();
        matte_ptr26.set_ka(ka);
        matte_ptr26.set_kd(kd);
        matte_ptr26.set_cd(lightPurple);
        let	sphere_ptr26 =  Sphere(c: Point3D(a: 55, b: 38, c: -160), r: 12);
        sphere_ptr26.set_material(matte_ptr26);							// light purple
        add_object(sphere_ptr26);
        
        let matte_ptr27 =  Matte();
        matte_ptr27.set_ka(ka);
        matte_ptr27.set_kd(kd);
        matte_ptr27.set_cd(lightPurple);
        let	sphere_ptr27 =  Sphere(c: Point3D(a: -73, b: -2, c: -160), r: 12);
        sphere_ptr27.set_material(matte_ptr27);							// light purple
        add_object(sphere_ptr27);
        
        let matte_ptr28 =  Matte();
        matte_ptr28.set_ka(ka);
        matte_ptr28.set_kd(kd);
        matte_ptr28.set_cd(darkPurple);
        let	sphere_ptr28 =  Sphere(c: Point3D(a: 30, b: -62, c: -140), r: 15);
        sphere_ptr28.set_material(matte_ptr28); 							// dark purple
        add_object(sphere_ptr28);
        
        let matte_ptr29 =  Matte();
        matte_ptr29.set_ka(ka);
        matte_ptr29.set_kd(kd);
        matte_ptr29.set_cd(darkPurple);
        let	sphere_ptr29 =  Sphere(c: Point3D(a: 25, b: 63, c: -140), r: 15);
        sphere_ptr29.set_material(matte_ptr29);							// dark purple
        add_object(sphere_ptr29);
        
        let matte_ptr30 =  Matte();
        matte_ptr30.set_ka(ka);
        matte_ptr30.set_kd(kd);
        matte_ptr30.set_cd(darkPurple);
        let	sphere_ptr30 =  Sphere(c: Point3D(a: -60, b: 46, c: -140), r: 15);
        sphere_ptr30.set_material(matte_ptr30); 							// dark purple
        add_object(sphere_ptr30);
        
        
        let matte_ptr31 =  Matte();
        matte_ptr31.set_ka(ka);	
        matte_ptr31.set_kd(kd);
        matte_ptr31.set_cd(lightPurple);
        let	sphere_ptr31 =  Sphere(c: Point3D(a: -30, b: 68, c: -130), r: 12); 
        sphere_ptr31.set_material(matte_ptr31); 							// light purple
        add_object(sphere_ptr31);
        
        let matte_ptr32 =  Matte();
        matte_ptr32.set_ka(ka);	
        matte_ptr32.set_kd(kd);
        matte_ptr32.set_cd(green);
        let	sphere_ptr32 =  Sphere(c: Point3D(a: 58, b: 56, c: -180), r: 11);   
        sphere_ptr32.set_material(matte_ptr32);							//  green
        add_object(sphere_ptr32);
        
        let matte_ptr33 =  Matte();
        matte_ptr33.set_ka(ka);	
        matte_ptr33.set_kd(kd);
        matte_ptr33.set_cd(green);
        let	sphere_ptr33 =  Sphere(c: Point3D(a: -63, b: -39, c: -180), r: 11); 
        sphere_ptr33.set_material(matte_ptr33);							// green 
        add_object(sphere_ptr33);
        
        let matte_ptr34 =  Matte();
        matte_ptr34.set_ka(ka);	
        matte_ptr34.set_kd(kd);
        matte_ptr34.set_cd(lightPurple);
        let	sphere_ptr34 =  Sphere(c: Point3D(a: 46, b: 68, c: -200), r: 10); 	
        sphere_ptr34.set_material(matte_ptr34);							// light purple
        add_object(sphere_ptr34);
        
        let matte_ptr35 =  Matte();
        matte_ptr35.set_ka(ka);	
        matte_ptr35.set_kd(kd);
        matte_ptr35.set_cd(lightPurple);
        let	sphere_ptr35 =  Sphere(c: Point3D(a: -3, b: -72, c: -130), r: 12); 
        sphere_ptr35.set_material(matte_ptr35);							// light purple
        add_object(sphere_ptr35);
        
        
        // vertical plane
        
        let matte_ptr36 =  Matte();
        matte_ptr36.set_ka(ka);	
        matte_ptr36.set_kd(kd);
        matte_ptr36.set_cd(grey);
        let plane_ptr =  Plane(point: Point3D(a: 0, b: 0, c: -150), normal: Normal(_x: 0, _y: 0, _z: 1));
        plane_ptr.set_material(matte_ptr36);
        add_object (plane_ptr);
    }
}





