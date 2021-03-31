//
//  Post.swift
//  HttpRequestAndTableView
//
//  Created by klioop on 2021/03/30.
//

import Foundation

struct Post {
    
    let title: String
    let body: String
    let id: String
    
    init(id:String, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }
}
