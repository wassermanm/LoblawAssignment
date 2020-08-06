//
//  RedditEntryNoImageTableViewCell.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-06.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import UIKit

class RedditEntryNoImageTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellLabel.text     = nil
    }
    
    func configure(redditEntry: RedditEntry) {
        self.cellLabel.text = redditEntry.title
    }

}
