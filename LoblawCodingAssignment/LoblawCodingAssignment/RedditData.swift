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
    let children: [Data]
}

struct Data: Decodable {
    let data: RedditEntries
}

struct RedditEntries: Decodable {
    let title: String
    let selftext: String
    let preview: Images?
}

struct Images: Decodable {
    let images: [ImageData]?
}

struct ImageData: Decodable {
    let source: Source
}

struct Source: Decodable {
    let url: String?
    let width: Int?
    let height: Int?
}
