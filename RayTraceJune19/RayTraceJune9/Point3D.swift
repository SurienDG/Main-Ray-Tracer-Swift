//
//  Point3D.swift
//  RGBColor
//
//  Created by Surien on 2016-04-27.
//  Copyright © 2016 Surien. All rights reserved.
//  Surien Testing
//  Testing Complete

import Foundation

// inlined member functions

// -------------------------------------------------------------- operator-
// unary minus

prefix func -(p:Point3D) -> Point3D {
    return (Point3D(a: -p.x, b: -p.y, c: -p.z))
}


// -------------------------------------------------------------- operator-
// the vector that joins two points

func -(let lhs: Point3D, let rhs: Point3D) -> Vector3D {
    return (Vector3D(_x: lhs.x - rhs.x,_y: lhs.y - rhs.y,_z: lhs.z - rhs.z))
}


// -------------------------------------------------------------- operator+
// addition of a vector to a point that returns a new point

func +(let lhs:Point3D, let rhs:Vector3D) -> Point3D {
    return (Point3D(a: lhs.x + rhs.x, b:lhs.y + rhs.y, c: lhs.z + rhs.z));
}


// -------------------------------------------------------------- operator-
// subtraction of a vector from a point that returns a new point

func -(let lhs:Point3D, let rhs:Vector3D) -> Point3D {
    return (Point3D(a: lhs.x - rhs.x, b: lhs.y - rhs.y, c: lhs.z - rhs.z));
}


// -------------------------------------------------------------- operator*
// mutliplication by a double on the right

func * (lhs:Point3D, rhs:Double) -> Point3D
{
    return (Point3D(a: lhs.x * rhs,b: lhs.y * rhs,c: lhs.z * rhs));
}


// inlined non-member function

// -------------------------------------------------------------- operator*
// multiplication by a double on the left



func *(let lhs:Double, let rhs:Point3D) -> Point3D {
    return (Point3D(a: lhs * rhs.x, b: lhs * rhs.y, c: lhs * rhs.z));
}

// non-member function

// --------------------------------------------- operator*
// multiplication by a matrix on the left

func *(let mat:Matrix, let p:Point3D) -> Point3D {
    
    var expression1 = mat.m[0][0] * p.x
    expression1 += mat.m[0][1] * p.y
    expression1 += mat.m[0][2] * p.z
    expression1 += mat.m[0][3]
    var expression2 = mat.m[1][0] * p.x
    expression2 += mat.m[1][1] * p.y
    expression2 += mat.m[1][2] * p.z
    expression2 += mat.m[1][3]
    var expression3 = mat.m[2][0] * p.x
    expression3 += mat.m[2][1] * p.y
    expression3 += mat.m[2][2] * p.z
    expression3 += mat.m[2][3]

    return (Point3D(a: expression1,b: expression2,c: expression3))
}

class Point3D
{
    var x:Double
    var y:Double
    var z:Double
    // --------------------------------------------- default constructor
    
    init ()
    {
        x=0; y=0; z=0;
    }
    
    
    
    // --------------------------------------------- constructor
    
    init(let a:Double)
    {
        x = a; y = a; z = a;
    }
    
    // --------------------------------------------- constructor
    
    init(let a:Double, let b:Double, let c:Double)
    {
        x = a; y = b; z = c;
    
    }
    
    
    // --------------------------------------------- copy constructor
    
    init (let p: Point3D)
    {
        x = p.x; y = p.y; z = p.z;
    }
    
    
    
    // --------------------------------------------- distance
    // distance between two points
    
    func distance(let p: Point3D) ->Double
    {
    return (sqrt((x - p.x) * (x - p.x) + (y - p.y) * (y - p.y) + (z - p.z) * (z - p.z) ))
    }
    
    // -------------------------------------------------------------- d_squared
    // the square of the distance between the two points as a member function
    
    
    func d_squared(let p:Point3D) -> Double {
        
    return ((x - p.x) * (x - p.x) + (y - p.y) * (y - p.y) +	(z - p.z) * (z - p.z))
    }
    
}