//
//  MatchesTableViewController.swift
//  koen-BitDate
//
//  Created by Koen Hendriks on 09/06/15.
//  Copyright (c) 2015 Koen Hendriks. All rights reserved.
//

import UIKit

class MatchesTableViewController: UITableViewController {

	var matches: [Match] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationItem.titleView = UIImageView(image: UIImage(named: "chat-header"))
		
		let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToPreviousVC:")
		navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
		
		fetchMatches { (matches) -> () in
			self.matches = matches
			self.tableView.reloadData()
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func goToPreviousVC(button: UIBarButtonItem){
		pageController.goToPreviousVC()
	}

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return matches.count
    }

	// MARK: - UITableViewDataSource
	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as UserCell

		let user = matches[indexPath.row].user
		cell.nameLabel.text = user.name
		
		user.getPhoto { (image) -> () in
			cell.avatarImageView.image = image
		}
		

        return cell
    }
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		let vc = ChatViewController()
		navigationController?.pushViewController(vc, animated: true)
		
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	

	
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
		else if editingStyle == .Insert {
			
        }    
    }


    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
	
	
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


	// MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using [segue destinationViewController].
//         Pass the selected object to the new view controller.
    }

}
