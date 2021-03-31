//
//  EditViewControllerDelegate.swift
//  HttpRequestAndTableView
//
//  Created by klioop on 2021/03/31.
//

protocol EditPostViewControllerDelegate: AnyObject {
    
    // 포스팅 수정이 완료 되었다.
    func editPostCompleted(editedPostItem: Post)
    
    
}
