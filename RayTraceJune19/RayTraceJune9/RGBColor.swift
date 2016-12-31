//
//  World.swift
//  Ray Tracer World Class
//
//  Created by comp on 2016-04-23.
//  Copyright © 2016 comp. All rights reserved.
//

import Foundation


// This file contains the definition of the class RGBColor



//#include "RGBColor.h"





// -------------------------------------------------------- default constructor
class RGBColor
{
    var	r:Float = 0.0
    var g:Float = 0.0
    var b:Float = 0.0
    
    init()
    {
        r=0.0
        g=0.0
        b=0.0
        
    }
    
    
    // -------------------------------------------------------- constructor
    
    init(c:Float)
    {
        r=c
        g=c
        b=c
        
    }
    
    
    // -------------------------------------------------------- constructor
    
    init( _r:Float, _g:Float, _b:Float)
    {
        r=_r
        g=_g
        b=_b
    }
    
    
    // -------------------------------------------------------- copy constructor
    
    init(c:RGBColor)
    {
        r=c.r
        g=c.g
        b=c.b
    }
    
    //power function for RGBColor
    func powc(p:Float) -> RGBColor
    {
        return (RGBColor(_r:pow(r, p), _g:pow(g, p), _b:pow(b, p)))
    }
    
    func average() -> Float
    {
        return (0.333333333333 * (r + g + b))
    }
}
// operator overloading for operations between RGBColors
func +(lhs:RGBColor, rhs: RGBColor) -> RGBColor
{
    return(RGBColor(_r: lhs.r + rhs.r, _g: lhs.g + rhs.g, _b: lhs.b + rhs.b))
}

func +=(lhs: RGBColor, rhs: RGBColor)
{
    lhs.r += rhs.r
    lhs.g += rhs.g
    lhs.b += rhs.b
}

func * (lhs: RGBColor, a: Float) -> RGBColor
{
    return (RGBColor(_r: lhs.r*a, _g: lhs.g*a, _b: lhs.b*a))
}

func *= (lhs: RGBColor, a: Float)
{
    lhs.r *= a
    lhs.g *= a
    lhs.b *= a
}

func / (lhs: RGBColor, a: Float) -> RGBColor
{
    return (RGBColor(_r: lhs.r/a, _g: lhs.g/a, _b: lhs.b/a))
}

func /= (lhs: RGBColor, a: Float)
{
    lhs.r /= a
    lhs.g /= a
    lhs.b /= a
}

func * (lhs: RGBColor, rhs: RGBColor) -> RGBColor
{
    return (RGBColor(_r: lhs.r * rhs.r, _g: lhs.g * rhs.g, _b: lhs.b * rhs.b))
}

func == (lhs: RGBColor, rhs: RGBColor) -> Bool
{
    return ((lhs.r == rhs.r) && (lhs.g == rhs.g) && (lhs.b == rhs.b))
}

func * (a: Float, rhs: RGBColor) -> RGBColor
{
    return (RGBColor(_r: a * rhs.r, _g: a * rhs.g, _b: a * rhs.b))
}