//
//  Utils.swift
//  testAdastra
//
//  Created by boufaied youssef on 03/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//
import UIKit
import Foundation

public class Utils {
    
    public static func sliderToColor(value:Int)->UIColor{
        let colorArray = [ 0xC6DA02, 0x79A700, 0xF68B2C, 0xE2B400, 0xF5522D, 0xFF6E83,0xFF6E83]

        return uiColorFromHex(rgbValue:colorArray[value])
        
    }
    public static func parseColor(string:String) -> UIColor{
        print("coooloor \(string)")
        let colorsArr = string.characters.split{$0 == ","}.map(String.init)
        print("arraaay \(Double(colorsArr[0])!/255) \(Double(colorsArr[1])!) \(Double(colorsArr[2])!)")
        let red:CGFloat = CGFloat(Double(colorsArr[0])!/255)
        let green:CGFloat = CGFloat(Double(colorsArr[1])!/255)
        let blue:CGFloat = CGFloat(Double(colorsArr[2])!/255)
        print("red \(red) \(green) \(blue)")
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    static func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
