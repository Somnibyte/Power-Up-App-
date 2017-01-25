//
//  Effects.swift
//  Power Up
//
//  Created by Guled on 1/25/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import UIKit 


/**
 The imageWithDarkGradient method applies a black and clear gradient to an image.
 
 - parameter img: A UIImage.
 - returns: A UIImage with a black and clear gradient applied to it.
 */
func imageWithDarkGradient(img:UIImage!) -> UIImage {
    
    
    // Create a Graphics context
    UIGraphicsBeginImageContext(img.size)
    
    let context = UIGraphicsGetCurrentContext()
    
    // Draw the image into the context
    img.draw(at: CGPoint(x: 0, y: 0))
    
    
    // Setup the parameters for our gradient
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    let clear = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
    
    let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
    
    let colorLocations:[CGFloat] = [0.0, 1.0]
    
    let gradientColors = [clear, black] as CFArray
    
    
    // Create the gradient
    let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: colorLocations)
    
    // Specify the locations of each point for the linear gradient
    let startPoint = CGPoint(x: img.size.width/2, y: 0)
    
    let endPoint = CGPoint(x: img.size.width/2, y: img.size.height)
    
    
    // Apply the gradient to the current graphics context
    context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
    
    
    // Obtain the image from the current graphics context
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image!
}

