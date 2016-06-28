//
//  StencilView.swift
//  StencilView
//
//  Created by Swarup on 28/6/16.
//  Copyright © 2016 swarup. All rights reserved.
//

import UIKit

class StencilView : UIView {
    
    var font = "HelveticaNeue"
    var strokeColor = UIColor.blackColor().CGColor
    var textLayer = CAShapeLayer()
    var lineWidth:CGFloat = 1.0
    var animationDuration = 3.0
    var fontSize:CGFloat = 64
    var spacing:CGFloat = 10
    
    func drawText(text: String) {
       
        self.textLayer.removeFromSuperlayer()
        self.textLayer = CAShapeLayer()
        
        let layer = self.textLayer
        let path = self.getPath(text)
        layer.path = path.CGPath
        
        layer.bounds = path.bounds
        layer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        layer.lineWidth = self.lineWidth
        layer.strokeColor = self.strokeColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.geometryFlipped = true
        
        layer.strokeStart = 0.0
        layer.strokeEnd = 1.0
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.duration = animationDuration
        anim.fromValue = 0.0
        anim.toValue = 1.0
        
        layer.addAnimation(anim, forKey: nil)
        self.layer.addSublayer(self.textLayer)
    }
    
    func getPath(word: String) -> UIBezierPath {
        let path = UIBezierPath()
        let spacing: CGFloat = self.spacing
        var i: CGFloat = 0
        for letter in word.characters {
            let newPath = getPathForLetter(letter)
            let actualPathRect = CGPathGetBoundingBox(path.CGPath)
            let transform = CGAffineTransformMakeTranslation((CGRectGetWidth(actualPathRect) + min(i, 1)*spacing), 0)
            newPath.applyTransform(transform)
            path.appendPath(newPath)
            i++
        }
        
        return path
    }
    
    func getPathForLetter(letter: Character) -> UIBezierPath {
        var path = UIBezierPath()
        let font = CTFontCreateWithName(self.font, self.fontSize, nil)
        var unichars = [UniChar]("\(letter)".utf16)
        var glyphs = [CGGlyph](count: unichars.count, repeatedValue: 0)
        
        let gotGlyphs = CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        if gotGlyphs {
            let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)
            path = UIBezierPath(CGPath: cgpath!)
        }
        
        return path
    }
}

