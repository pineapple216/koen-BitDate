//
//  CardsViewController.swift
//  koen-BitDate
//
//  Created by Koen Hendriks on 09/05/15.
//  Copyright (c) 2015 Koen Hendriks. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, SwipeViewDelegate {

	let frontCardTopMargin: CGFloat = 0
	let backCardTopMargin: CGFloat = 10
	
	@IBOutlet weak var cardStackView: UIView!
	
	var backCard: SwipeView?
	var frontCard: SwipeView?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		cardStackView.backgroundColor = UIColor.clearColor()
		
		backCard = SwipeView(frame: createCardFrame(backCardTopMargin))
		backCard!.delegate = self
		cardStackView.addSubview(backCard!)
		
		frontCard = SwipeView(frame: createCardFrame(frontCardTopMargin))
		frontCard!.delegate = self
		cardStackView.addSubview(frontCard!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	private func createCardFrame(topMargin: CGFloat) -> CGRect{
		return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
	}
	
	// MARK: - SwipeViewDelegate
	func swipedLeft() {
		println("Left")
		if let frontCard = frontCard{
			frontCard.removeFromSuperview()
		}
	}
	
	func swipedRight() {
		println("Right")
		if let frontCard = frontCard {
			frontCard.removeFromSuperview()
		}
	}
}










