//
//  PostDetailViewController.swift
//  HttpRequestAndTableView
//
//  Created by klioop on 2021/03/31.
//

import UIKit
import Alamofire

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var btnDeleted: UIButton!
    
    var post: Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PostDetailVC - viewDidLoad() 호출됨 / post.title: \(post?.title ?? "")")
        print("post.id: \(post?.id ?? "")")
        
        self.titleLabel.text = self.post?.title ?? ""
        self.bodyLabel.text = self.post?.body ?? ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(goToEditPostView))
        
        btnDeleted.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
    }
    
    // MARK: - filprivate methods
    @objc fileprivate func goToEditPostView() {
        performSegue(withIdentifier: K.EditPostSegueId, sender: self)
    }
    
    @objc fileprivate func deletePost() {
        print("deletePost() called")
        
        AF.request("http://13.209.73.176/api/post/\(post?.id ?? "")", method: .delete, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                print("posting 삭제 성공!~ \(response)")
            }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.EditPostSegueId) {
            
            let vc = segue.destination as! EditPostViewController
            print("EditPostViewController 로 넘어왔다")
            
            vc.receviedPost = post
            vc.delegate = self
        }
    }
}

// MARK: - EditPostViewControllerDelegate method

extension PostDetailViewController: EditPostViewControllerDelegate {
    
    func editPostCompleted(editedPostItem: Post) {
        print("PostDetailViewController - editPostCompleted / editPostCompleted.title: \(editedPostItem.title) ")
        
        DispatchQueue.main.async {
            self.titleLabel.text = editedPostItem.title
            self.bodyLabel.text = editedPostItem.body
        }
        
    }
    
    
}
