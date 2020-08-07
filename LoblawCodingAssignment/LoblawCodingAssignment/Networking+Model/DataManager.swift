//
//  DataManager.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-05.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    static let sharedInstance = DataManager()
    private let urlString     = "https://www.reddit.com/r/swift/.json"
    private var imageCache     = [String: UIImage]()
    
    private init() {}
    
    public func getRedditStories( _ completion: @escaping (_ success: Bool, _ message: Array<RedditEntry>, _ errorMessage: String) -> ()) {
        let errorMessage = "There was an error retrieving data"
        var entries      = [RedditEntry]()
        let session      = URLSession.shared
        
        if let url = URL(string: urlString) {
            let _: Void = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
                if let _ = error {
                    completion(false, entries, errorMessage)
                    return
                }
                do {
                    let decoder    = JSONDecoder()
                    let parsedData = try decoder.decode(RedditData.self, from: data!)
                    for element in parsedData.data.children {
                        self?.addImageToCache(redditEntry: element.data)
                        entries.append(element.data)
                    }
                    DispatchQueue.main.async(execute: {() -> Void in
                        completion(true, entries, "")
                    })
                } catch {
                    completion(false, entries, errorMessage)
                }
            }).resume()
        }
    }
    
    public func getImageFromCache(title: String) -> UIImage? {
        return imageCache[title]
    }
    
    private func addImageToCache(redditEntry: RedditEntry) {
        if let thumbnailURLStr = redditEntry.thumbnail, thumbnailURLStr.hasSuffix("jpg") != false ,let thumbnailImage = self.getThumbnailImage(thumbnailURLStr: (thumbnailURLStr)) {
            self.imageCache[redditEntry.title] = thumbnailImage
        }
    }
    
    private func getThumbnailImage(thumbnailURLStr: String) -> UIImage? {
        if let thumbnailURL = URL(string: thumbnailURLStr) {
            let data = try? Data(contentsOf: thumbnailURL)
            if let imageData = data {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
}
