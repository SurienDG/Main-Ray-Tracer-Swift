//
//  Pixel.swift
//  RayTracerMay31
//
//  Created by Student on 2016-05-31.
//  Copyright © 2016 Student. All rights reserved.
//
/*
import CoreImage
import simd

//this struct is from a swift ray tracing tutorial
public struct Pixel {
    var r: UInt8
    var g: UInt8
    var b: UInt8
    var a: UInt8
    init(red: UInt8, green: UInt8, blue: UInt8) {
        r = red
        g = green
        b = blue
        a = 255
    }
}

public func makePixelSet(width: Int, _ height: Int, _ zoom:Int) -> ([Pixel], Int, Int) {
    
    var pixel = Pixel(red: 0, green: 0, blue: 0)
    var pixels = [Pixel](count: width * height, repeatedValue: pixel)
    //let lower_left_corner = vec3(e0: -2.0, e1: 1.0, e2: -1.0)
    // let horizontal = vec3(e0: 4.0, e1: 0.0, e2: 0.0)
    // let vertical = vec3(e0: 0.0, e1: -2.0, e2: 0.0)
    //let origin = vec3(e0: 0.0, e1: 0.0, e2: 0.0)
    var list=[hitable]()
    var col = float3()
    var lookfrom = float3(10,1.5,-3)
    var lookat = float3()
    var cam = camera(lookfrom: lookfrom,lookat: lookat,vup: float3(0,-1,0),vfov: 15, aspect: Float(width)/Float(height), aperture: 0,focus_dist:length(lookfrom-lookat) )
    //var R:Float = cos(M_PI/4)
    list.append(sphere(cen: float3(0, -100.5, -1), r: 100, m: lambertian(a: float3(0.8, 0.8, 0.0))))
    
    list.append(sphere(cen: float3(-1, 0, -1), r: 0.5, m: metal(a: float3(0.8, 0.6, 0.2), f:0.3)))
    list.append(sphere(cen: float3(0, 0, -1), r: 0.5, m: lambertian(a: float3(0.1, 0.2, 0.5))))
    list.append(sphere(cen: float3(1, 0, -1), r: 0.3, m: dielectric(ri: 1.5)))
    //list.append(sphere(cen: float3(1, 0, -1), r: -0.49, m: dielectric(ri: 1.5)))
    
    
    
    
    
    
    
    
    
    
    
   
    // list.append(sphere(cen: vec3(e0: 0, e1: 0.5, e2: -1.1), r: 0.5, m: metal(a: vec3(e0: 0.8, e1: 0.8, e2: 0.8))))
    
    var world = random_scene()
    //let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    //dispatch_apply(width, queue) { i in
    for i in 0..<width{
        for j in 0..<height {
            col = float3()
            for _ in 0..<zoom
            {
                let u = (Float(i) + Float(drand48())) / Float(width)
                let v = (Float(j) + Float(drand48())) / Float(height)
                let r = cam.get_ray(Float(u), t: Float(v))
                //let p:vec3 = r.point_at_parameter(2.0)
                col += color(r,world: world,depth: 0)
            }
            col /= float3(Float(zoom))
            col = float3(sqrt(col.x),sqrt(col.y),sqrt(col.z))
            //col = vec3(e0: sqrt(col.x()), e1: sqrt(col.y()), e2: sqrt(col.z()))
            //these two lines were aquired from a site
            pixel = Pixel(red: UInt8(col.x * 255), green: UInt8(col.y * 255), blue: UInt8(col.z * 255))
            pixels[i + j * width] = pixel
        }
        
    }
    return (pixels, width, height)
}

//this function was aquired from a swift ray tracing tutorial
func imageFromPixels(pixels: [RGBColor], width: Int, height: Int) -> CIImage {
    let bitsPerComponent = 8
    let bitsPerPixel = 32
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue) // alpha is last
    let providerRef = CGDataProviderCreateWithCFData(NSData(bytes: pixels[0], length: pixels[0].count * sizeof(Pixel)))
    let image = CGImageCreate(pixels.1, pixels.2, bitsPerComponent, bitsPerPixel, pixels.1 * sizeof(Pixel), rgbColorSpace, bitmapInfo, providerRef, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
    return CIImage(CGImage: image!)
}
*/