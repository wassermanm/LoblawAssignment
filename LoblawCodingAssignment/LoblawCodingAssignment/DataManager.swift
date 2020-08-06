//
//  DataManager.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-05.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import Foundation

class DataManager {
    
    static let sharedInstance = DataManager()
    private let urlString     = "https://www.reddit.com/r/swift/.json"
    
    
    private init() {
    }
    
    public func getRedditStories( _ completion: @escaping (_ success: Bool, _ message: Array<RedditEntries>, _ errorMessage: String) -> ()) {
        //data.children.data.title
        //data.children.data.thumbnail
        //data.children.data.selftext
        let errorMessage = "There was an error retrieving data"
        var entries = [RedditEntries]()
        let session = URLSession.shared
        if let url = URL(string: urlString) {
            let _: Void = session.dataTask(with: url, completionHandler: { data, response, error in
                
                
                if let error = error { print(error); return }
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let parsedData = try decoder.decode(RedditData.self, from: data!)
                    //successBlock(model)
                    print("model is \(parsedData)")
                    for element in parsedData.data.children {
                        entries.append(element.data)
                    }
                    DispatchQueue.main.async(execute: {() -> Void in
                        completion(true, entries, "")
                    })
                } catch {
                    print(error)
                    completion(true, entries, errorMessage)
                }
                
                
                
               
                
                
                }).resume()
        }
        
    }
}
