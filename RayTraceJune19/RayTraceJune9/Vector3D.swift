//
//  Vector3D.swift
//  MatrixTest
//
//  Created by Student on 2016-04-26.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  Testing complete!
//Final copy

import Foundation

// operator overload functions, not part of the class because Swift does not allow it

// ------------------------------------------------------------------------ unary minus
// this does not change the current vector
// this allows ShadeRec objects to be declared as constant arguments in many shading
// functions that reverse the direction of a ray that's stored in the ShadeRec object
//Tested, works but provides -0 value if 0 is entered
prefix func -(v:Vector3D) -> Vector3D {
    return (Vector3D(_x: -v.x, _y: -v.y, _z: -v.z))
}




// ----------------------------------------------------------------------- operator*
// multiplication by a double on the right
//Tested, works

func * (let lhs:Vector3D, let rhs:Double) ->Vector3D {
    return (Vector3D(_x: lhs.x * rhs, _y: lhs.y * rhs, _z: lhs.z * rhs));
}

// ----------------------------------------------------------------------- operator*
// multiplication by a double on the left
//Tested, works

func *(let a:Double, let v:Vector3D) -> Vector3D {
    return (Vector3D(_x: a * v.x, _y: a * v.y, _z: a * v.z));
}

// ----------------------------------------------------------------------- operator/
// division by a double
//Tested, works as long as rhs is not 0, otherwise result is infinity or nan

func /(let lhs:Vector3D,let rhs:Double) ->Vector3D
{
    return (Vector3D(_x: lhs.x / rhs, _y: lhs.y / rhs, _z: lhs.z / rhs));
}


// ----------------------------------------------------------------------- operator+
// addition
//Tested, works

func +(let rhs:Vector3D, let lhs: Vector3D) ->Vector3D {
    return (Vector3D(_x:rhs.x + lhs.x, _y:rhs.y + lhs.y, _z: rhs.z + lhs.z));
}


// ----------------------------------------------------------------------- operator-
// subtraction
//Tested, works

func -(let lhs:Vector3D, let rhs:Vector3D) -> Vector3D
{
    return (Vector3D(_x: lhs.x - rhs.x, _y: lhs.y - rhs.y, _z: lhs.z - rhs.z))
}


// ----------------------------------------------------------------------- operator*
// dot product
//Tested, works

func *(let lhs:Vector3D, let rhs:Vector3D) -> Double {
    return (lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z);
}


// ----------------------------------------------------------------------- operator^
// cross product
//Tested, works

func ^(let lhs: Vector3D, let rhs:Vector3D) -> Vector3D
{
    return (Vector3D(_x: lhs.y * rhs.z - lhs.z * rhs.y, _y: lhs.z * rhs.x - lhs.x * rhs.z, _z: lhs.x * rhs.y - lhs.y * rhs.x))
}


// ---------------------------------------------------------------------  operator+=
// compound addition
//Tested, works

func +=(lhs:Vector3D, let rhs:Vector3D) {
    lhs.x += rhs.x; lhs.y += rhs.y; lhs.z += rhs.z;
    }

//Class Declaration

class Vector3D {
    //3 components
    var x,y,z: Double
    
    //default initialization to 0
    //Tested, works
    init()
    {
        x = 0.0
        y = 0.0
        z = 0.0
    }
    
    //initialization from a double
    //Tested, works
    init( a: Double)
    {
        x = a
        y = a
        z = a
    }
    
    //initialization from 3 doubles
    //tested, works
    init( _x: Double, _y: Double, _z: Double)
    {
        x = _x
        y = _y
        z = _z
    }
    
    //initialization from another vector
    //tested, works
    init(vector: Vector3D)
    {
        x = vector.x
        y = vector.y
        z = vector.z
    }
    
    //initialization from a Normal vector
    //tested, works
    init(n: Normal)
    {
        x = n.x
        y = n.y
        z = n.z
    }
    
    //initialization from a Point3D
    //tested, works
    init(p: Point3D)
    {
        x = p.x
        y = p.y
        z = p.z
    }
    
    //calculate magnitute of vector
    //Tested, works
    func length() -> Double
    {
        var length: Double
        length = sqrt(x*x + y*y + z*z)
        return length
    }
    
    //converts the vector into a unit vector
    //not returning anything, but changing the current vector
    //tested, works
    func normalize()
    {
        let length: Double = sqrt(x*x + y*y + z*z)
        x /= length
        y /= length
        z /= length
    }
    
    // ---------------------------------------------------------------------  len_squared
    // the square of the length
    //tested, works
    func len_squared() -> Double
    {
        return (x * x + y * y + z * z);
    }
}

// multiplication by a matrix on the left
// only multiplies the 3 x 3 matrix in the upper left hand corner of the 4 x 4 matrix
// tested, works
func *(mat: Matrix, v: Vector3D) -> Vector3D
{
    var expression1 = mat.m[0][0] * v.x
    expression1 += mat.m[0][1] * v.y
    expression1 += mat.m[0][2] * v.z
    var expression2 = mat.m[1][0] * v.x
    expression2 += mat.m[1][1] * v.y
    expression2 += mat.m[1][2] * v.z
    var expression3 = mat.m[2][0] * v.x
    expression3 += mat.m[2][1] * v.y
    expression3 += mat.m[2][2] * v.z
    

    return(Vector3D(_x: expression1, _y: expression2, _z: expression3))
}
