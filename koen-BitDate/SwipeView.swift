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

	let overlay: UIImageView = UIImageView()
	
	var direction: Direction?
	
	var innerView: UIView? {
		didSet{
			if let v = innerView {
				self.insertSubview(v, belowSubview: overlay)
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
	
	override init(){
		super.init(frame: CGRectZero)
		initialize()
	}
	
	private func initialize(){
		// Set color back to clearColor()
		self.backgroundColor = UIColor.clearColor()
		
		self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
		
		overlay.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
		self.addSubview(overlay)
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
			
			updateOverlay(distance.x)
			
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
	
	private func updateOverlay(distance: CGFloat){
		var newDirection: Direction
		newDirection = distance < 0 ? .Left : .Right
		
		// Determine what to set the overlay's image to,
		// If the user swipes to the right, set it to "yeah", if they swipe to the left to "nah"
		if newDirection != direction{
			direction = newDirection
			overlay.image = direction == .Right ? UIImage(named: "yeah-stamp") : UIImage(named: "nah-stamp")
		}
		overlay.alpha = abs(distance) / (superview!.frame.width/2)
	}
	
	
	private func resetViewPositionAndTransformations(){
		UIView.animateWithDuration(0.2, animations: { () -> Void in
			self.center = self.originalPoint!
			self.transform = CGAffineTransformMakeRotation(0)
			
			self.overlay.alpha = 0
		})
	}
}


protocol SwipeViewDelegate: class {
	func swipedLeft()
	func swipedRight()
}



















