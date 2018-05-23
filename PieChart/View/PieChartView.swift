//
//  PieChartView.swift
//  PieChart
//
//  Created by Ken Phanith on 2018/05/23.
//  Copyright © 2018 Quad. All rights reserved.
//

import Foundation
import UIKit

class PieChartView: UIView {
    
    var segments = [Segment]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(from: CGColor,
                        to: CGColor,
                        layer: CAShapeLayer,
                        radius: CGFloat,
                        endAngle: CGFloat) {
        
        let animation = CABasicAnimation(keyPath: "fillColor")
        
        animation.duration = CFTimeInterval(3)
        
        animation.fromValue = from
        animation.toValue = to
        
        animation.isAdditive = false
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.repeatCount = .infinity
        
        layer.add(animation, forKey: "growingAnimation")
        
    }

    override func draw(_ rect: CGRect) {
       
        
        
        
        
        let radius = min(frame.size.width, frame.size.height) * 0.5
        let viewCenter = CGPoint(x: frame.size.width * 0.5,
                                 y: frame.size.height * 0.5)

        var startAngle = CGFloat(CGFloat.pi * 3 / 2)
        let valueCount = segments.reduce(0, {$0 + $1.value})

        for (index, segment) in segments.enumerated() {

            let circleLayer: CAShapeLayer = CAShapeLayer()
            let labelLayer: CATextLayer = CATextLayer()

            let circlePath = UIBezierPath()

            let endAngle = startAngle + (CGFloat(Double.pi*2) * (segment.value / valueCount))

            circlePath.move(to: viewCenter)
            circlePath.addArc(withCenter: viewCenter,
                              radius: radius,
                              startAngle: startAngle,
                              endAngle: endAngle,
                              clockwise: true)

            circleLayer.path = circlePath.cgPath
            circleLayer.fillColor = segment.color.cgColor

            // start animation
            if index > 0 {
                self.startAnimation(from: segments[index - 1].color.cgColor,
                                    to: segment.color.cgColor,
                                    layer: circleLayer,
                                    radius: radius,
                                    endAngle: endAngle)
            }else {
                self.startAnimation(from: UIColor.clear.cgColor,
                                    to: segment.color.cgColor,
                                    layer: circleLayer,
                                    radius: radius,
                                    endAngle: endAngle)
            }


            let halfAngle = startAngle + (endAngle - startAngle) * 0.5

            let textPositiveValue: CGFloat = 0.67

            let segmentCenter = CGPoint(x: viewCenter.x + radius * textPositiveValue * cos(halfAngle),
                                        y: viewCenter.y + radius * textPositiveValue * sin(halfAngle))

            // get the color of each segment
            guard let colorComponents = segment.color.cgColor.components else { return }

            // findout the averate RGB value for the color
            let averageRGB = (colorComponents[0] + colorComponents[1] + colorComponents[2]) / 3

            labelLayer.frame = CGRect(x: 50,
                                      y: 50,
                                      width: 76,
                                      height: 21)
            labelLayer.string = "\(segment.name) (\(segment.value.formattedToOneDecimalPlace))"
            labelLayer.fontSize = 16
            labelLayer.position = segmentCenter
            labelLayer.foregroundColor = (averageRGB > 0.7) ? UIColor.black.cgColor : UIColor.white.cgColor
            labelLayer.alignmentMode = kCAAlignmentCenter

            startAngle = endAngle

            self.layer.addSublayer(circleLayer)
            self.layer.addSublayer(labelLayer)

        }
        
        
        let circle = UIBezierPath()
        let circleCenter = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        circle.move(to: circleCenter)
        circle.addArc(withCenter: circleCenter, radius: frame.size.width / 4 , startAngle: 3 * CGFloat.pi / 2, endAngle: (3 * CGFloat.pi / 2) + (2 * CGFloat.pi) , clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circle.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 200
        self.layer.addSublayer(circleLayer)
        
        
        let animator = CABasicAnimation(keyPath: "strokeStart")
        animator.fromValue = 0
        animator.toValue = 1
        animator.duration = 3
        animator.isRemovedOnCompletion = false
        animator.fillMode = kCAFillModeForwards
        circleLayer.add(animator, forKey: nil)
        
    }
    
}
