//
//  UIFontExtension.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/23.
//

import UIKit

enum FontType {
    case SDBold, SDMed, SDReg, PPBold, PPMed, PPReg
}

extension UIFont {
    static func SOTFont(type: FontType, size: CGFloat) -> UIFont {
        var fontName = ""
        switch type {
        case .SDBold:
            fontName = "AppleSDGothicNeo-Bold"
        case .SDMed:
            fontName = "AppleSDGothicNeo-Medium"
        case .SDReg:
            fontName = "AppleSDGothicNeo-Regular"
        case .PPBold:
            fontName = "Poppins-Bold"
        case .PPMed:
            fontName = "Poppins-Medium"
        case .PPReg:
            fontName = "Poppins-Regular"
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
