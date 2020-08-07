//
//  DetailsViewController.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-06.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var textViewDistanceToTopConstraint: NSLayoutConstraint!
    var redditEntry: RedditEntry?
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var entryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = redditEntry?.title
        self.entryTextView.text = redditEntry?.selftext
        
        if let title = redditEntry?.title, let thumbnailImage = DataManager.sharedInstance.getImageFromCache(title: title) {
            self.entryImage.image    = thumbnailImage
            self.entryImage.isHidden = false
        } else {
            self.entryImage.isHidden = true
            self.textViewDistanceToTopConstraint.constant = 10
        }
    }
}
