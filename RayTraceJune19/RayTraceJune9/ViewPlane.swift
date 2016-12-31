//
//  ViewPlane.swift
//  MatrixTest
//
//  Created by Student on 2016-05-03.
//  Copyright © 2016 Student. All rights reserved.
//  Jordan Testing
//  testing complete!
import Foundation

//class ViewPlane

class ViewPlane {
    var hres: Int   					// horizontal image resolution
    var vres: Int   					// vertical image resolution
    var s: Float						// pixel size
    var num_samples: Int				// number of samples per pixel
    var gamma: Float					// gamma correction factor
    var inv_gamma: Float				// the inverse of the gamma correction factor
    var show_out_of_gamut: Bool			// display red if RGBColor out of gamut
    
    init()   								// default Constructor, tested, works
    {
        hres = 400
        vres = 400
        s = 1.0
        num_samples = 1
        gamma = 1.0
        inv_gamma = 1.0
        show_out_of_gamut = false
    }
    
    init(vp: ViewPlane)				// copy constructor, tested, works
    {
        hres = vp.hres
        vres = vp.vres
        s = vp.s
        num_samples = vp.num_samples
        gamma = vp.gamma
        inv_gamma = vp.inv_gamma
        show_out_of_gamut = vp.show_out_of_gamut
    }
    
    func set_hres(h_res: Int)
    {
        hres = h_res
    }
    
    func set_vres(v_res: Int)
    {
        vres = v_res
    }
				
    func set_pixel_size(size: Float)
    {
        s = size
    }
    
    func set_gamma(g: Float)
    {
        gamma = g
        inv_gamma = 1.0 / gamma
    }
    
    func set_gamut_display(show: Bool)
    {
        show_out_of_gamut = show
    }
    
    func set_samples(n: Int)
    {
        num_samples = n
    }
}