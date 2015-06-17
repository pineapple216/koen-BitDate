//
//  ChatViewController.swift
//  koen-BitDate
//
//  Created by Koen Hendriks on 16/06/15.
//  Copyright (c) 2015 Koen Hendriks. All rights reserved.
//

import Foundation

class ChatViewController: JSQMessagesViewController{
	
	var messages: [JSQMessage] = []
	var senderAvatar: UIImage!
	var recipientAvatar: UIImage!
	
	
	let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
	let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
	
	
	override func viewDidLoad(){
		super.viewDidLoad()
		// Do any additional setup after loading the view
	}
	
	func senderDisplayName() -> String! {
		return currentUser()!.name
	}
	
	func senderId() -> String! {
		return currentUser()!.id
	}
	
	override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
		var data = self.messages[indexPath.row]
		return data
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
	}
	
	// MARK: - JSQMessageBubbleImageDataSource
	
	override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
		
		var data = self.messages[indexPath.row]
		
		if data.senderId == PFUser.currentUser().objectId{
			return outgoingBubble
		}
		else{
			return incomingBubble
		}
	}
	
	override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
		let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
		
		self.messages.append(m)
		finishSendingMessage()
	}
	
	override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
		var imgAvatar = JSQMessagesAvatarImage.avatarWithImage(JSQMessagesAvatarImageFactory.circularAvatarImage( UIImage(named: "profile-header"), withDiameter: 60))
		
		if (self.messages[indexPath.row].senderId == self.senderId){
			if (self.senderAvatar != nil){
				imgAvatar = JSQMessagesAvatarImage.avatarWithImage(JSQMessagesAvatarImageFactory.circularAvatarImage( self.senderAvatar, withDiameter: 60))
			}
			else{
				currentUser()!.getPhoto({ (image) -> () in
					self.senderAvatar = image
					self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
				})
			}
		}
		else{
			if (self.recipientAvatar != nil){
				imgAvatar = JSQMessagesAvatarImage.avatarWithImage(JSQMessagesAvatarImageFactory.circularAvatarImage( self.recipientAvatar, withDiameter: 60))
			}
			else{
				getUserAsync( self.messages[indexPath.row].senderId, { (user) -> () in
					self.updateAvatarForRecipient( indexPath, user: user)
				})
			}
		}
		return imgAvatar
	}
	
	func updateAvatarImageForIndexPath( indexPath: NSIndexPath, avatarImage: UIImage) {
		let cell: JSQMessagesCollectionViewCell = self.collectionView.cellForItemAtIndexPath(indexPath) as JSQMessagesCollectionViewCell
		cell.avatarImageView.image = JSQMessagesAvatarImageFactory.circularAvatarImage( avatarImage, withDiameter: 60 )
	}
		
	func updateAvatarForRecipient( indexPath: NSIndexPath, user: User ) {
		user.getPhoto({ (image) -> () in
			self.recipientAvatar = image
			self.updateAvatarImageForIndexPath(indexPath, avatarImage: image)
		})
	}
	
	
	
	
}











