//
//  EditPostViewController.swift
//  HttpRequestAndTableView
//
//  Created by klioop on 2021/03/31.
//

import UIKit
import Alamofire

class EditPostViewController: UIViewController {
    
    @IBOutlet weak var titleEditInput: UITextField!
    @IBOutlet weak var bodyEditInput: UITextView!
    
    var receviedPost: Post?
    
    weak var delegate: EditPostViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("receviedPost.id : \(receviedPost?.id ?? "")")
        print("receviedPost.title : \(receviedPost?.title ?? "")")
        
        titleEditInput.delegate = self
        bodyEditInput.delegate = self
        
        titleEditInput.text = receviedPost?.title
        bodyEditInput.text = receviedPost?.body
        
        
        navigationItem.title = "포스팅 수정하기"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Completed", style: .plain, target: self, action: #selector(editCompleted))
    }
    
    @objc fileprivate func editCompleted() {
        print("editCompleted() called")
        
        let parameters: [String: Any] = [
            "title": titleEditInput.text ?? "",
            "body": bodyEditInput.text ?? ""
        ]
        
        AF.request("http://13.209.73.176/api/post/\(receviedPost?.id ?? "")", method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("포스팅 수정 성공!~ \(response)")
                
                guard let result = response.value else { return }
                let JSON = result as! NSDictionary
                
                let postId = JSON["id"] as! Int
                let postTitle = JSON["title"] as! String
                let postBody = JSON["body"] as! String
                
                let responsePostItem = Post(id: "\(postId)", title: postTitle, body: postBody)
                
                self.delegate?.editPostCompleted(editedPostItem: responsePostItem)
            }
        
        navigationController?.popViewController(animated: true)
    }
}

extension EditPostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
}

extension EditPostViewController: UITextViewDelegate {
    
}

    
