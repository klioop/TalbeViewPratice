//
//  ViewController.swift
//  HttpRequestAndTableView
//
//  Created by klioop on 2021/03/30.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 포스팅 배열 초기화
    var posts = [Post]()
    var page = 0
    var selectdPost: Post?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MainViewController - viewDidLoad() 호출됨")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // 데이터 가져오기
        loadMoreData(page: 1)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateView))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear() called")
        
        handleRefresh()
    }
    
    
    // MARK: - selector methods
    @objc fileprivate func goToCreateView() {
        print("goToCreateView()")
        performSegue(withIdentifier:K.CreatePostSegueId, sender: self)
    }
    
    @objc fileprivate func handleRefresh() {
        print("handleRefresh 호출됨")
        posts.removeAll()
        self.page = 1
        loadMoreData(page: page)
    }
    
    fileprivate func loadMoreData(page: Int) {
        let url = "\(K.API.GET_POSTS)"
        
        self.page = page + 1
        
        let parameters = ["page": String(page)]
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            
            // To get status code
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            
            // To get JSON return value
            if let result = response.value {
                let JSON = result as! NSDictionary
                if let array = JSON["data"] as? [NSDictionary] {
                    print(array.count)
                    
                    for obj in array {
                        guard let id = obj.value(forKey: "id") else { return }
                        let title = obj.value(forKey: "title") as! String
                        let body = obj.value(forKey: "body") as! String
                        print("id \(id)")
                        print("title: \(title)")
                        print("body: \(body)")
                        
                        // 포스팅 배열에 넣는다.
                        self.posts.append(Post(id: "\(id)", title: title, body: body))
                        self.tableView.reloadData()
                        self.tableView.refreshControl?.endRefreshing()
                        print("포스팅 배열에 들어있다: \(self.posts.count)")
                    }
                }
            }
        }
    }
    
}



// MARK: - TableViewDataSource method
extension MainViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        cell.title.text = self.posts[indexPath.row].title
        cell.body.text = self.posts[indexPath.row].body
        
        if indexPath.row == self.posts.count - 1 {
            self.loadMoreData(page: self.page)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectdPost = posts[indexPath.row]
        
        print("테이블뷰를 선택했다. indexPath.row: \(indexPath.row)")
        print("selectdPost.title: \(selectdPost?.title ?? "")")
        
        performSegue(withIdentifier: K.postDetailSegueId, sender: self)
    }
    
    // 화면을 넘기는 부분이다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == K.postDetailSegueId) {
            print("세그웨이로 넘어왔다.")
            let vc = segue.destination as! PostDetailViewController
            vc.post = selectdPost
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
    
}
