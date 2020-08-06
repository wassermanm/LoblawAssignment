//
//  ViewController.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-05.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tableData: [RedditEntry]?
    let redditCellIdentifier        = "redditDataCell"
    let redditCellNoImageIdentifier = "redditCellNoImageIdentifier"
    let segueIdentifier             = "toDetails"
    var indexOfValueToPass          = 0
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = "Swift News"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.color = UIColor.black
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        self.addSpinner()
        DataManager.sharedInstance.getRedditStories { [weak self](success, entries, error) in
            if success {
                self?.handleDataRetrivealSuccess(entries: entries)
            } else {
                self?.handleDataRetrievalFailure(error: error)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = true
        self.activityIndicator.frame = self.view.bounds
    }

    //MARK: - Utility Methods
    
    private func handleDataRetrivealSuccess(entries: [RedditEntry]) {
        self.tableData = entries
        DispatchQueue.main.async {
            self.removeSpinner()
            self.tableView.reloadData()
        }
    }
    
    private func handleDataRetrievalFailure(error: String) {
        DispatchQueue.main.async {
            self.removeSpinner()
            self.presentAlert(title: "Error", message: error)
        }
    }
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

//MARK: UITableViewDelegate Methods
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableData?[indexPath.row].thumbnail?.hasSuffix("jpg") != false) {
            let cell = tableView.dequeueReusableCell(withIdentifier: redditCellIdentifier, for: indexPath) as? RedditEntryTableViewCell
            guard let redditEntry = tableData?[indexPath.row] else { return UITableViewCell() }
            cell?.configure(redditEntry: redditEntry)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: redditCellNoImageIdentifier, for: indexPath) as? RedditEntryNoImageTableViewCell
            guard let redditEntry = tableData?[indexPath.row] else { return UITableViewCell() }
            cell?.configure(redditEntry: redditEntry)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.indexOfValueToPass = indexPath.row
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let detailController = segue.destination as? DetailsViewController {
                detailController.redditEntry = tableData?[self.indexOfValueToPass]
            }
        }
    }
}
