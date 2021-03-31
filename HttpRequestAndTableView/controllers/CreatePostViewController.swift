//
//  CreatePostViewController.swift
//  HttpRequestAndTableView
//
//  Created by klioop on 2021/03/31.
//

import UIKit
import Alamofire

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var bodyInput: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInput.delegate = self
        bodyInput.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerPost))
        
    }
    
    // MARK: - fileprivate methods
    
    @objc fileprivate func registerPost() {
        print("registerPost() called")
        
        print("입력된 타이틀 : \(titleInput.text ?? "")")
        print("입력된 바디 : \(bodyInput.text ?? "")")
        
        let parameters: [String: Any] = [
            "title": titleInput.text ?? "",
            "body": bodyInput.text ?? ""
        ]
        
        AF.request("http://13.209.73.176/api/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("포스팅 등록 성공!~ \(response)")
            }
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextViewDelegate

extension CreatePostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing / textView : \(textView.text!)")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing / textView : \(textView.text!)")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("바디입력: \(bodyInput.text!)")
        return true
    }
    
}

// MARK: - UITextFieldDelegate

extension CreatePostViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing / textField : \(textField.text!)")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing / textField : \(textField.text!)")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(titleInput.text!)
        return true
    }
}
