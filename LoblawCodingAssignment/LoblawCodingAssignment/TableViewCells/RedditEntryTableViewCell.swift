//
//  RedditEntryTableViewCell.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-05.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import UIKit

class RedditEntryTableViewCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    func configure(redditEntry: RedditEntry) {
        self.cellLabel.text = redditEntry.title
        if let thumbnailImage = DataManager.sharedInstance.getImageFromCache(title: redditEntry.title) {
            self.cellImage.image = thumbnailImage
            self.cellImage.isHidden = false
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImage.isHidden = true
        self.cellLabel.text     = nil
    }
}
