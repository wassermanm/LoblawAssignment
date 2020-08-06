//
//  ViewController.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-05.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tableData: [RedditEntries]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicator.color = UIColor.black
        self.addSpinner()
        DataManager.sharedInstance.getRedditStories { [weak self](success, entries, error) in
            if success {
                self?.tableData = entries
                DispatchQueue.main.async {
                    self?.removeSpinner()
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self?.removeSpinner()
                    self?.presentAlert(title: "Error", message: error)
                }
            }
        }
    }


    //MARK: - Utility Methods
    
    private func addSpinner() {
        self.activityIndicator.isHidden =  false
        self.activityIndicator.startAnimating()
    }
    
    private func removeSpinner() {
        self.activityIndicator.isHidden =  true
        self.activityIndicator.stopAnimating()
    }
    
    private func presentAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

