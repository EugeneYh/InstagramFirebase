//
//  UIColor.swift
//  InstagramFirebase App
//
//  Created by Eugene on 09.07.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alfa: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alfa)
    }
}
