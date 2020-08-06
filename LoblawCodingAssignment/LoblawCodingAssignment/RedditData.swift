//
//  RedditData.swift
//  LoblawCodingAssignment
//
//  Created by michael wasserman on 2020-08-05.
//  Copyright © 2020 michael wasserman. All rights reserved.
//

import Foundation
import UIKit

struct RedditData : Decodable {
    let data: Children
}

struct Children: Decodable {
    let children: [ChildrenData]
}

struct ChildrenData: Decodable {
    let data: RedditEntry
}

struct RedditEntry: Decodable {
    let title: String
    let selftext: String
    let thumbnail: String?
}

