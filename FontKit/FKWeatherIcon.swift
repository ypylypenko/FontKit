//
//  FKWeatherIcon.swift
//  FontKit
//
//  Created by Ievhenii Pylypenko on 30.06.16.
//  Copyright © 2016 Ievhenii Pylypenko. All rights reserved.
//

import UIKit
import CoreText

public extension UIFont {
    public class func wiIconOfSize(fontSize: CGFloat) -> UIFont {
        struct Static {
            static var onceToken : dispatch_once_t = 0
        }
        
        let name = "Weather Icons"
        
        if UIFont.fontNamesForFamilyName(name).isEmpty {
            dispatch_once(&Static.onceToken) {
                FontLoader.loadFont(name)
            }
        }
        
        return UIFont(name: name, size: fontSize)!
    }
}

public extension String {
    
    public static func wiIconWithName(name: FKWeatherIcon) -> String {
        return name.rawValue.substringToIndex(name.rawValue.startIndex.advancedBy(1))
    }
    
    public static func wiIconWithCode(code: String) -> String? {
        guard let raw = FKWeacherIcons[code], icon = FKWeatherIcon(rawValue: raw) else {
            return nil
        }
        
        return self.wiIconWithName(icon)
    }
}

public extension UIImage {
    
    public static func wiIconWithName(name: FKWeatherIcon, textColor: UIColor, size: CGSize, backgroundColor: UIColor = UIColor.clearColor()) -> UIImage {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.Center
        
        // Taken from FontAwesome.io's Fixed Width Icon CSS
        let fontAspectRatio: CGFloat = 1.28571429
        
        let fontSize = min(size.width / fontAspectRatio, size.height)
        let attributedString = NSAttributedString(string: String.wiIconWithName(name), attributes: [NSFontAttributeName: UIFont.wiIconOfSize(fontSize), NSForegroundColorAttributeName: textColor, NSBackgroundColorAttributeName: backgroundColor, NSParagraphStyleAttributeName: paragraph])
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.drawInRect(CGRectMake(0, (size.height - fontSize) / 2, size.width, fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}



private class FontLoader {
    
    class func loadFont(name: String) {
        let bundle = NSBundle(forClass: FontLoader.self)
        var fontURL = NSURL()
        let identifier = bundle.bundleIdentifier
        
        print("Name \(name)")
        
        if identifier?.hasPrefix("org.cocoapods") == true {
            // If this framework is added using CocoaPods, resources is placed under a subdirectory
            fontURL = bundle.URLForResource(name, withExtension: "ttf", subdirectory: "FontKit.bundle")!
        } else {
            fontURL = bundle.URLForResource(name, withExtension: "ttf")!
        }
        
        print("Font url \(fontURL)")
        
        let data = NSData(contentsOfURL: fontURL)!
        
        
        let provider = CGDataProviderCreateWithCFData(data)
        let font = CGFontCreateWithDataProvider(provider)!
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
            let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
            NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
    
}
