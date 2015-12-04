//
//  RockYouTextFieldExtension.swift
//  RockYouTextFieldSample
//
//  Created by seedante on 15/12/2.
//  Copyright © 2015年 seedante. All rights reserved.
//

import Foundation
import UIKit

private var CurrentContextTextKey: UInt8 = 0
private var ColorModeKey: UInt8 = 1
private var InputAnimationEnabledKey: UInt8 = 2
private var EmitterLayerKey: UInt8 = 3
private var EmittingKey: UInt8 = 4
private var InputAnimationTextKey: UInt8 = 5

extension UITextField{
    private var emitterLayer: CAEmitterLayer{
        get {
            return objc_getAssociatedObject(self, &EmitterLayerKey) as! CAEmitterLayer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &EmitterLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    private var currentContextText: String?{
        get {
            return objc_getAssociatedObject(self, &CurrentContextTextKey) as? String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &CurrentContextTextKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    private var emitting: Bool{
        get {
            return objc_getAssociatedObject(self, &EmittingKey) as! Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &EmittingKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    private var colors: [UIColor]{
        return [UIColor.blackColor(), UIColor.darkGrayColor(), UIColor.lightGrayColor(), UIColor.whiteColor(), UIColor.grayColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(),
                UIColor.cyanColor(), UIColor.yellowColor(), UIColor.magentaColor(), UIColor.orangeColor(), UIColor.purpleColor(), UIColor.brownColor()]
    }

    //MARK: Custom Options
    //Text Color for deleted letter to throw: textfield's text color or random system color.
    var colorDeleteAnimationEnabled: Bool{
        get {
            return objc_getAssociatedObject(self, &ColorModeKey) as! Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ColorModeKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    //Input Effect Switch
    var inputAnimationEnabled: Bool{
        get {
            return objc_getAssociatedObject(self, &InputAnimationEnabledKey) as! Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &InputAnimationEnabledKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    //Content of Input Animation
    var inputAnimationText: String?{
        get {
            return objc_getAssociatedObject(self, &InputAnimationTextKey) as? String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &InputAnimationTextKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }

    }

    //MARK: Config your textfield with one line code.
    func addSDEEffect(){
        currentContextText = ""
        colorDeleteAnimationEnabled = false
        inputAnimationEnabled = false
        emitting = false
        setUpEmitterLayer()

        self.addTarget(self, action: "SDE_textDidChanged:", forControlEvents: .EditingChanged)
    }

    func removeSDEEffect(){
        emitterLayer.removeFromSuperlayer()
        self.removeTarget(self, action: "SDE_textDidChanged:", forControlEvents: .EditingChanged)
    }

    //MARK: Input Animation
    func enableInputEffect(){
        inputAnimationEnabled = true
    }

    func disableInputEffect(){
        inputAnimationEnabled = false
    }

    private func setUpEmitterLayer() {
        clipsToBounds = false
        emitterLayer = CAEmitterLayer()
        emitterLayer.frame = bounds
        emitterLayer.seed = UInt32(NSDate().timeIntervalSince1970)
        layer.addSublayer(emitterLayer)
    }

    private func degreesToRadians(degrees: Double) -> CGFloat {
        return CGFloat(degrees * M_PI / 180.0)
    }

    private func imageOfText(drawText: NSString, textColor: UIColor)->UIImage{
        UIGraphicsBeginImageContext(CGSize(width: 20, height: 20))

        let textFont: UIFont = UIFont(name: "Helvetica Bold", size: 14)!
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        let rect: CGRect = CGRect(origin: CGPointZero, size: CGSize(width: 20, height: 20))
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        let textImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        return textImage
        
    }
    private func setUpEmitterCell() {
        let emitterCell = CAEmitterCell()

        if let emitterContentText = inputAnimationText{
            emitterCell.contents = imageOfText(emitterContentText, textColor: textColor!).CGImage
        }

        emitterCell.enabled = true
        emitterCell.contentsRect = CGRect(origin: CGPointZero, size: CGSize(width: 1, height: 1))
        emitterCell.color =  UIColor.whiteColor().CGColor//UIColor(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 1.0).CGColor
        emitterCell.redRange = 0.0
        emitterCell.greenRange = 0.0
        emitterCell.blueRange = 0.0
        emitterCell.alphaRange = 0.0
        emitterCell.redSpeed = 0.0
        emitterCell.greenSpeed = 0.0
        emitterCell.blueSpeed = 0.0
        emitterCell.alphaSpeed = -0.5
        emitterCell.scale = 1
        emitterCell.scaleRange = 0.1
        emitterCell.scaleSpeed = 0.1

        let zeroDegreesInRadians = degreesToRadians(0.0)
        emitterCell.spin = degreesToRadians(130.0)
        emitterCell.spinRange = zeroDegreesInRadians
        emitterCell.emissionLatitude = zeroDegreesInRadians
        emitterCell.emissionLongitude = zeroDegreesInRadians
        emitterCell.emissionRange = degreesToRadians(360.0)

        emitterCell.lifetime = 0.5
        emitterCell.lifetimeRange = 0.3
        emitterCell.birthRate = 50.0
        emitterCell.velocity = 50.0
        emitterCell.velocityRange = 500.0
        emitterCell.xAcceleration = -500.0
        emitterCell.yAcceleration = -500.0
        emitterLayer.emitterCells = [emitterCell]
    }

    //MARK: Shake Animation(Useless)
    func shakeX(){
        let shakeXAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeXAnimation.values = [0, 10, -10, 10, 0]
        shakeXAnimation.keyTimes = [0, (1 / 6.0), (3 / 6.0), (5 / 6.0), 1]
        shakeXAnimation.additive = true

        layer.addAnimation(shakeXAnimation, forKey: nil)
    }

    func shakeY(){
        let shakeYAnimation = CAKeyframeAnimation(keyPath: "position.y")
        shakeYAnimation.values = [0, -10, 10, -10, 0]
        shakeYAnimation.keyTimes = [0, (1 / 6.0), (3 / 6.0), (5 / 6.0), 1]
        shakeYAnimation.additive = true

        layer.addAnimation(shakeYAnimation, forKey: nil)
    }

    //MARK: Helper
    @objc private func removeDiffView(diffView: UIView){
        diffView.removeFromSuperview()
    }

    private func diffTextColor() -> UIColor{
        var color: UIColor
        if colorDeleteAnimationEnabled{
            let index = Int(UInt32(arc4random()) % UInt32(colors.count))
            color = colors[index]
        }else{
            color = textColor!
        }

        return color
    }

    @objc private func SDE_textDidChanged(textField: UITextField){
        var cursorOrigin = caretRectForPosition(selectedTextRange!.start).origin

        let diffText = diffBetween(currentContextText!, newString: textField.text!)
        if currentContextText?.characters.count > text?.characters.count{
            var startPoint = convertPoint(CGPoint(x: (cursorOrigin.x + frame.height), y: -frame.height / 4), toView: superview)
            if startPoint.x > frame.origin.x + frame.size.width{
                startPoint.x = frame.origin.x + frame.size.width
            }

            let endPositionX = startPoint.x - 200 - CGFloat(UInt32(arc4random()) % UInt32(50))
            let endPositionY = startPoint.y + 50 - CGFloat(UInt32(arc4random()) % UInt32(100))
            let endPoint = CGPoint(x: endPositionX, y: endPositionY)
            let controlPoint = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: startPoint.y - frame.height)

            let throwOrigin = CGPoint(x: (endPoint.x - frame.height / 2), y: (endPoint.y - frame.height / 2))
            let viewSize = CGSize(width: frame.size.height, height: frame.size.height)
            let containerView = UIView(frame: CGRect(origin: throwOrigin, size: viewSize))
            containerView.layer.opacity = 0

            //Maybe you want throw other things.
            let diffLabel = UILabel(frame: CGRect(origin: CGPointZero, size: viewSize))
            diffLabel.font = font
            diffLabel.textColor = diffTextColor()
            diffLabel.adjustsFontSizeToFitWidth = true
            diffLabel.text = diffText

            containerView.addSubview(diffLabel)
            superview?.addSubview(containerView)

            let path = UIBezierPath()
            path.moveToPoint(startPoint)
            path.addQuadCurveToPoint(endPoint, controlPoint: controlPoint)
            let curvemoveAnimation = CAKeyframeAnimation(keyPath: "position")
            curvemoveAnimation.path = path.CGPath

            let rotateAnimation = CABasicAnimation(keyPath: "transform")
            let rotateRatio = CGFloat(UInt32(arc4random()) % UInt32(10)) / 10.0
            rotateAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, rotateRatio))

            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.fromValue = 1.0
            fadeAnimation.toValue = 0.5

            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [curvemoveAnimation, rotateAnimation, fadeAnimation]
            animationGroup.duration = 0.5

            containerView.layer.addAnimation(animationGroup, forKey: nil)
            performSelector("removeDiffView:", withObject: diffLabel, afterDelay: 0.51)
        }else if inputAnimationEnabled{
            if !emitting{
                setUpEmitterCell()
                emitting = true
            }else{
                NSObject.cancelPreviousPerformRequestsWithTarget(self)
            }

            //Why 10 here, cursorOrigin returned by 'caretRectForPosition(selectedTextRange!.start).origin' is always not same with real position. 10 work fine with system font size from 14 to 30 most time. Calculation for accurate value is painful for me, if you know simple way, please tell me.
            if cursorOrigin.x > frame.size.width{
                cursorOrigin.x = frame.size.width - 10
            }else{
                cursorOrigin.x += 10
            }
            emitterLayer.emitterPosition = cursorOrigin
            performSelector("shutdownEmitterLayer", withObject: nil, afterDelay: 0.5)
        }
        
        currentContextText = text
    }

    @objc private func shutdownEmitterLayer(){
        emitting = false
        emitterLayer.emitterCells = nil
    }

    private func diffBetween(oldString: String, newString: String) -> String{
        if oldString.characters.count == 0{
            return newString
        }

        if newString.characters.count == 0{
            return oldString
        }

        var diffCharacter: Character = Character("X")
        let startIndex = oldString.startIndex
        let oldLastIndex = oldString.startIndex.advancedBy(oldString.characters.count - 1)
        let newLastIndex = newString.startIndex.advancedBy(newString.characters.count - 1)
        for (index, charactor) in oldString.characters.enumerate(){
            let checkIndex = startIndex.advancedBy(index)
            let anotherCharacter = newString[checkIndex]

            if checkIndex == oldLastIndex{
                if charactor == anotherCharacter{
                    //XY: XYZ
                    diffCharacter = newString[newLastIndex]
                }else{
                    //XY: XZY
                    diffCharacter = anotherCharacter
                }
                break
            }

            if checkIndex == newLastIndex{
                if charactor == anotherCharacter{
                    //XYZ: XY
                    diffCharacter = oldString[oldLastIndex]
                }else{
                    //XYZ: XZ
                    diffCharacter = oldString[checkIndex]
                }
                break
            }

            if charactor != anotherCharacter{
                if newString.characters.count > oldString.characters.count{
                    //OXYZ: OKXYZ
                    diffCharacter = anotherCharacter
                }else{
                    //OXYZ: OYZ
                    diffCharacter = charactor
                }
                break
            }
        }
        
        return String(diffCharacter)
    }

}