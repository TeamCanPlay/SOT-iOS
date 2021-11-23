//
//  UIFontExtension.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/23.
//

import UIKit

enum FontType {
    case SDBold, SDMed, SDReg
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
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
