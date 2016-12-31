//
//  Camera.swift
//  World Class
//
//  Created by Jordan Long on 2016-04-28.
//  Copyright © 2016 Jordan Long. All rights reserved.
//  Jordan Testing
//  Testing complete!
//  Final copy

import Foundation
import UIKit

class Camera {
    //point value for position of the lens of the Camera
    var eye: Point3D
    //point value for what the camera is looking at
    var lookat: Point3D
    //value for the roll angle
    var ra: Float
    //vectors u, v and w are all non-collinear with each other, form orthonormal coordinate system
    var u: Vector3D
    var v: Vector3D
    var w: Vector3D
    //up vector specifies which of u, v and w will be pointing up in the camera's view
    var up: Vector3D
    //length of camera exposure
    var exposure_time: Float
    
    //tested, works
    init()
    {
        //defaults to having the camera pointing at the origin
        eye = Point3D(a: 0, b: 0, c: 500)
        lookat = Point3D(a: 0)
        //default ra value of 0
        ra = 0
        //u, v and w are the x, y and z axis, respectively
        u = Vector3D(_x: 1, _y: 0, _z: 0)
        v = Vector3D(_x: 0, _y: 1, _z: 0)
        w = Vector3D(_x: 0, _y: 0, _z: 1)
        //the y axis will be on the vertical plane in the image
        up = Vector3D(_x: 0, _y: 1, _z: 0)
        //default exposure time of 1
        exposure_time = 1.0
    }
    
    //initializes by assigning values from another camera instance
    //tested, works
    init(c: Camera)
    {
        eye = c.eye
        lookat = c.lookat
        ra = c.ra
        up = c.up
        u = c.u
        v = c.v
        w = c.w
        exposure_time = c.exposure_time
    }
    
    //provides empty clone function for inheritance by pinhole
    func clone() -> Camera?
    {
        return nil
    }
    
    //provides empty render_scene function for inheritance by pinhole
    func render_scene(w: World) //-> UIImage
    {
        //return UIImage(imageLiteral: "0")
    }
    
    //set_eye from point3D
    //tested, works
    func set_eye(p: Point3D) {
        eye = p
    }
    
    
    // set_eye from 3 doubles
    //  tested, works
    func set_eye(x:Double, y: Double, z: Double) {
        eye.x = x
        eye.y = y
        eye.z = z
    }
    
    
    //set_lookat from Point3D
    //tested,works
    func set_lookat(p: Point3D) {
        lookat = p
    }
    
    
    //set_lookat from 3 doubles
    //tested, works
    func set_lookat(x: Double, y: Double, z: Double)
    {
        lookat.x = x
        lookat.y = y
        lookat.z = z
    }
    
    
    // set_up_vector from Vector3D
    // tested, works
    func set_up_vector(u: Vector3D)
    {
        up = u
    }
    
    
    // set_up_vector from 3 doubles
    // tested, works
    func set_up_vector(x: Double, y: Double, z: Double)
    {
        up.x = x
        up.y = y
        up.z = z
    }
    
    
    // set_roll
    //tested, works
    func set_roll(r: Float)
    {
        ra = r
    }
    
    
    // set_exposure_time
    //tested, works
    func set_exposure_time(exposure: Float)
    {
        exposure_time = exposure
    }
    
    //-------------------------------------------------------------- compute_uvw
    // This computes an orthornormal basis given the view point, lookat point, and up vector
    //all 3 cases tested, work
    func compute_uvw() {
        // take care of the singularity by hardwiring in specific camera orientations
        if ((eye.x == lookat.x) && (eye.z == lookat.z) && (eye.y > lookat.y)) { // camera looking vertically down
            u = Vector3D(_x: 0, _y: 0, _z: 1)
            v = Vector3D(_x: 1, _y: 0, _z: 0)
            w = Vector3D(_x: 0, _y: 1, _z: 0)
        }
        else if (eye.x == lookat.x && eye.z == lookat.z && eye.y < lookat.y) { // camera looking vertically up
            u = Vector3D(_x: 1, _y: 0, _z: 0)
            v = Vector3D(_x: 0, _y: 0, _z: 1)
            w = Vector3D(_x: 0, _y: -1, _z: 0)
        }
        //otherwise, u v and w are found such that w is the vector along which the eye and lookat lie
        //u is perpendicular to both the up vector and w, and v is perpendicular to both u and w
        else
        {
            w = eye - lookat
            w.normalize()
            u = up ^ w
            u.normalize()
            v = w ^ u
        }
    }
}

