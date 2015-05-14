//
//  SwipeView.swift
//  koen-BitDate
//
//  Created by Koen Hendriks on 07/05/15.
//  Copyright (c) 2015 Koen Hendriks. All rights reserved.
//

import Foundation
import UIKit

class SwipeView: UIView {
	
	enum Direction{
		case None
		case Left
		case Right
	}
	
	weak var delegate: SwipeViewDelegate?

	var innerView: UIView? {
		didSet{
			if let v = innerView {
				addSubview(v)
				v.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
			}
		}
	}
	
	private var originalPoint: CGPoint?
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	init(){
		super.init(frame: CGRectZero)
		initialize()
	}
	
	private func initialize(){
		// Set color back to clearColor()
		self.backgroundColor = UIColor.redColor()
		
		self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
	}
	
	func dragged(gestureRecognizer: UIPanGestureRecognizer){
		let distance = gestureRecognizer.translationInView(self)
		println("Distance x:\(distance.x) y: \(distance.y)")
		
		switch gestureRecognizer.state{
		case UIGestureRecognizerState.Began:
			originalPoint = center
		case UIGestureRecognizerState.Changed:
			
			let rotationPercentage = min(distance.x/(self.superview!.frame.width/2),1)
			center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
			
			let rotationAngle = (CGFloat(2*M_PI/16)*rotationPercentage)
			
			transform = CGAffineTransformMakeRotation(rotationAngle)
		case UIGestureRecognizerState.Ended:
			if abs(distance.x) < frame.width/4 {
				resetViewPositionAndTransformations()
			}
			else{
				swipe(distance.x > 0 ? .Right : .Left)
			}
			
		default:
			println("Default triggered for GestureRecognizer")
			break
		}
	}
	
	func swipe(s:Direction){
		
		if s == .None{
			return
		}
		var parentWidth = superview!.frame.size.width
		if s == .Left{
			parentWidth *= -1
		}
		
		UIView.animateWithDuration(0.2, animations: { () -> Void in
			self.center.x = self.frame.origin.x + parentWidth
			}, completion: {
			succes in
				if let d = self.delegate{
					s == .Right ? d.swipedRight() : d.swipedLeft()
				}
		})
	}
	
	private func resetViewPositionAndTransformations(){
		UIView.animateWithDuration(0.2, animations: { () -> Void in
			self.center = self.originalPoint!
			self.transform = CGAffineTransformMakeRotation(0)
		})
	}
}


protocol SwipeViewDelegate: class {
	func swipedLeft()
	func swipedRight()
}



















