//
//  GuidanceView.swift
//  Guidance
//
//  Created by Nanda, Raman on 9/10/14.
//  Copyright (c) 2014 Nanda, Raman. All rights reserved.
//

import UIKit
import QuartzCore
import Foundation

class GuidanceView: UIView {

    var baseLayer = CALayer()
    var subLayer = CALayer()
    var outlineLayer = CALayer()
    let externalDimension:CGFloat = 240.0
    let outerDimension:CGFloat = 300.0
    let baseDimension: CGFloat = 220.0
    let subDimension: CGFloat = 180.0
    let guideLineColor = UIColor.lightGrayColor()
    let segmentCount:CGFloat = 720
    
    let showHelperSegments = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        var centerPoint:CGPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
        
        if(showHelperSegments) {
            self.layer.addSublayer(outlineLayer)
            
            /** Helper Lines **/
            var innerCircle = CALayer()
            var outerCircle = CALayer()
            
            outlineLayer.addSublayer(outerCircle)
            outlineLayer.addSublayer(innerCircle)
            outerCircle.bounds = CGRectMake(0, 0, baseDimension, baseDimension)
            outerCircle.position = centerPoint
            outerCircle.borderColor = guideLineColor.CGColor
            outerCircle.borderWidth = 1
            outerCircle.cornerRadius = baseDimension / 2
            
            innerCircle.bounds = CGRectMake(0, 0, subDimension, subDimension)
            innerCircle.position = centerPoint
            innerCircle.borderColor = guideLineColor.CGColor
            innerCircle.borderWidth = 1
            innerCircle.cornerRadius = subDimension / 2
        }
        
        /** Line Segments **/
        self.layer.addSublayer(baseLayer)
        self.layer.addSublayer(subLayer)
        
        for var i:CGFloat = 0; i < segmentCount; i++ {
            var iSegment = CAShapeLayer()
            baseLayer.addSublayer(iSegment)
            iSegment.fillColor = UIColor.clearColor().CGColor
            iSegment.strokeColor = guideLineColor.CGColor
            iSegment.lineWidth = 1
            
            var iPath = UIBezierPath()
            var startX:CGFloat = (subDimension / 2) * cos(i/2) + (self.bounds.size.width / 2)
            var startY:CGFloat = (subDimension / 2) * sin(i/2) + (self.bounds.size.height / 2)
            
            var randDistance: CGFloat = CGFloat(arc4random_uniform(25))
            
            var endX:CGFloat = ((baseDimension - randDistance) / 2) * cos(i/2) + (self.bounds.size.width / 2)
            var endY:CGFloat = ((baseDimension - randDistance) / 2) * sin(i/2) + (self.bounds.size.height / 2)
            
            iPath.moveToPoint(CGPoint(x: startX, y: startY))
            iPath.addLineToPoint(CGPoint(x: endX, y: endY))
            iSegment.path = iPath.CGPath
            
            var oSegment = CAShapeLayer()
            subLayer.addSublayer(oSegment)
            oSegment.fillColor = UIColor.clearColor().CGColor
            oSegment.strokeColor = guideLineColor.CGColor
            oSegment.lineWidth = 1
            
            var oPath = UIBezierPath()
            var oStartX:CGFloat = (externalDimension / 2) * cos(i/2) + (self.bounds.size.width / 2)
            var oStartY:CGFloat = (externalDimension / 2) * sin(i/2) + (self.bounds.size.height / 2)
            
            var oRandDistance: CGFloat = CGFloat(arc4random_uniform(75))
            
            var radius = outerDimension - oRandDistance
            
            var oEndX:CGFloat = ((radius) / 2) * cos(i/2) + (self.bounds.size.width / 2)
            var oEndY:CGFloat = ((radius) / 2) * sin(i/2) + (self.bounds.size.height / 2)
            
            oPath.moveToPoint(CGPoint(x: oStartX, y: oStartY))
            oPath.addLineToPoint(CGPoint(x: oEndX, y: oEndY))
            oSegment.path = oPath.CGPath
        }
        
        var rotationAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.duration = 10.0
        rotationAnimation.cumulative = true
        rotationAnimation.toValue = CGFloat(((360*M_PI)/180))
        rotationAnimation.repeatCount = 1e100;
        baseLayer.addAnimation(rotationAnimation, forKey: "tranform.rotation")
        baseLayer.frame = self.frame
        
        var oRotationAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        oRotationAnimation.duration = 20.0
        oRotationAnimation.cumulative = true
        oRotationAnimation.toValue = CGFloat(-1*((360*M_PI)/180))
        oRotationAnimation.repeatCount = 1e100;
        subLayer.addAnimation(oRotationAnimation, forKey: "tranform.rotation")
        subLayer.frame = self.frame
        
        
    }
    
    
}