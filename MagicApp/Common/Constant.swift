//
//  Constant.swift
//  MagicApp
//
//  Created by Cường Trần on 13/09/2023.
//

import SwiftUI

let mainBackroundColor = Gradient(colors: [Color(UIColor(hex: "0000FF")).opacity(0.3), .purple.opacity(0.3)]) 
let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

let normalFontSize = CGFloat(20)

let RadientBackgroundView = RadialGradient(gradient: mainBackroundColor, 
                                 center: .top, 
                                 startRadius: 5, 
                                 endRadius: height)
