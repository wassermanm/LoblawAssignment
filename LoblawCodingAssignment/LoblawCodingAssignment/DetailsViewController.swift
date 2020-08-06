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
    var data: RedditEntry?
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var entryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = data?.title
        self.entryTextView.text = data?.selftext
        if let thumbnailURLStr = data?.thumbnail, let thumbnailImage = DataManager.sharedInstance.getThumbnailImage(thumbnailURLStr: (thumbnailURLStr)) {
            self.entryImage.image = thumbnailImage
            self.entryImage.isHidden = false
        } else {
            self.entryImage.isHidden = true
            textViewDistanceToTopConstraint.constant = 10
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
