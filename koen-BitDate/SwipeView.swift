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
	
	private let card:CardView = CardView()
	
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
		self.backgroundColor = UIColor.clearColor()
		addSubview(card)
		
		card.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		setConstraints()
	}
	
	private func setConstraints(){
		
		addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
		
		addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
		
		addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
		
		addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0))
	}
}





