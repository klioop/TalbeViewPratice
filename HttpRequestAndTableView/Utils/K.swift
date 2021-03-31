//
//  K.swift
//  HttpRequestAndTableView
//
//  Created by klioop on 2021/03/31.
//

import Foundation

struct K {
    static let API_BASE_URL: String = "http://13.209.73.176/api"
    static let postDetailSegueId: String = "goToPostDetailVC"
    static let CreatePostSegueId: String = "goToCreatePost"
    static let EditPostSegueId: String = "goToEditPost"
    
    struct API {
        static let GET_POSTS = "\(API_BASE_URL)/post"
    }
}
