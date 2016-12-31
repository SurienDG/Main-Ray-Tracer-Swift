//
//  Normal.swift
//  RGBColor
//
//  Created by Surien on 2016-04-26.
//  Copyright © 2016 Surien. All rights reserved.
//  Jordan Testing
//  Testing Complete!

import Foundation

// addition of two normals
//tested, works
func +(let lhs:Normal, let rhs:Normal) -> Normal {
    return (Normal(_x:lhs.x + rhs.x,_y:lhs.y +  rhs.y, _z:lhs.z + rhs.z));
}

// compound addition of two normals
//tested, works
func +=(lhs:Normal, rhs:Normal) -> Normal{
    lhs.x += rhs.x; lhs.y += rhs.y; lhs.z += rhs.z;
    return lhs
}

// dot product of a normal on the left and a vector on the right
//tested, works
func *(lhs:Normal, rhs:Vector3D) ->Double {
    return (lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z)
}

// dot product of a vector on the left and a normal on the right
//tested, works
func *(let lhs:Vector3D, let rhs:Normal) -> Double {
    return (lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z);
}

// multiplication by a double on the right
//tested, works
func *(lhs:Normal,rhs:Double) ->Normal {
    return (Normal(_x: lhs.x * rhs, _y: lhs.y * rhs, _z: lhs.z * rhs));
}

// multiplication by a double on the left
//tested, works
func *(let lhs:Double, let rhs:Normal) -> Normal {
    return (Normal(_x: lhs * rhs.x, _y: lhs * rhs.y,_z: lhs * rhs.z))
}

// addition of a vector on the left to return a vector
//tested, works
func +(let lhs:Vector3D, let rhs:Normal) -> Vector3D {
    return (Vector3D(_x: lhs.x + rhs.x, _y: lhs.y + rhs.y, _z: lhs.z + rhs.z))
}

// subtraction of a normal from a vector to return a vector
//tested, works
func -(let lhs:Vector3D, let rhs:Normal) ->Vector3D {
    return (Vector3D(_x: lhs.x - rhs.x, _y: lhs.y - rhs.y, _z: lhs.z - rhs.z));
}

// multiplication by a matrix on the left
// a normal is transformed by multiplying it on the left by the transpose of the upper left 3 x 3
// partition of the inverse transformation matrix
//tested, works
func *(mat:Matrix, n:Normal)->Normal {
    var expression1 = mat.m[0][0] * n.x
    expression1 += mat.m[1][0] * n.y
    expression1 += mat.m[2][0] * n.z
    var expression2 = mat.m[0][1] * n.x
    expression2 += mat.m[1][1] * n.y
    expression2 += mat.m[2][1] * n.z
    var expression3 = mat.m[0][2] * n.x
    expression3 += mat.m[1][2] * n.y
    expression3 += mat.m[2][2] * n.z
    
    return (Normal(_x: expression1, _y: expression2, _z: expression3))
}

//division of normal by a double
//tested, works
func /(lhs: Normal, rhs: Double) -> Normal
{
    return Normal(_x: lhs.x / rhs, _y: lhs.y/rhs, _z: lhs.z/rhs)
}

// unary minus operator
//tested, works
prefix func -(n: Normal) -> Normal
{
    return (Normal(_x: -n.x, _y: -n.y, _z: -n.z))
}

class Normal
{
    var x:Double
    var y:Double
    var z:Double
   
    //default constructor
    //tested, works
    init ()
    {
        x=0.0
        y=0.0
        z=0.0
    }

    //constructor from a double
    //tested, works
    init(a:Double)
    {
        x=a
        y=a
        z=a
    }

    //constructor from 3 doubles
    //tested, works
    init( _x:Double, _y:Double, _z:Double)
    {
        x=_x
        y=_y
        z=_z
    }


    // copy constructor
    //tested, works
    init(n:Normal)
    {
        x=n.x
        y=n.y
        z=n.z
    }

    // construct a normal from a vector
    //tested, works
    init(v:Vector3D)
    {
        x=v.x
        y=v.y
        z=v.z
    }
    
    // construct normal from a point
    //tested, works
    init (p: Point3D) {
        x = p.x
        y = p.y
        z = p.z
    }

    //normalize
    //tested, works
    func normalize() {
        let length:Double = sqrt(x * x + y * y + z * z);
        x /= length
        y /= length
        z /= length
    }
}