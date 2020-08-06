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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(redditEntry: RedditEntry) {
        self.cellLabel.text = redditEntry.title
        if let thumbnailURLStr = redditEntry.thumbnail, let thumbnailImage = DataManager.sharedInstance.getThumbnailImage(thumbnailURLStr: (thumbnailURLStr)) {
            self.cellImage.image = thumbnailImage
            self.cellImage.isHidden = false
        }
        print(self.cellLabel.text as Any)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImage.isHidden = true
        self.cellLabel.text     = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
