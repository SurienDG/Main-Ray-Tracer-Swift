//
//  Point2D.swift
//  RGBColor
//
//  Created by Surien on 2016-04-26.
//  Copyright © 2016 Surien. All rights reserved.
//  Jordan Testing
//  Testing Complete!

import Foundation

// scales the point by a double
//tested, works
func *(lhs:Point2D, rhs:Double) -> Point2D {
    return (Point2D(x1: rhs * lhs.x, y1: rhs * lhs.y));
}

class Point2D
{
    var x:Double
    var y:Double
    
    //default initializer
    //tested, works
    init()
    {
        x=0.0
        y=0.0
    }
    
    //initialize from a double
    //tested, works
    init(let arg:Double)
    {
        x=arg
        y=arg
    }
    
    //initialize from 2 doubles
    //tested, works
    init(let x1:Double, let y1:Double)
    {
        x = x1
        y = y1
    }
    
    //initialize from another point2D
    //tested, works
    init(let p:Point2D)
    {
        x = p.x
        y = p.y
    }
}