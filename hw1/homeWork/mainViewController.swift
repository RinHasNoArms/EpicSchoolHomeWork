//
//  mainViewController.swift
//  homeWork
//
//  Created by Александр Романов on 17.03.2022.
//

import UIKit

final class mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate, PostPresenterDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: Cells.cellIdentifier)
        return table
    }()
    
    private let presenter = PostPresenter()
    private var posts = [Post]()
    
    struct Cells {
        static let cellIdentifier = "cellNode"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RosGramm"
        setupTableView()
        presenter.setViewDelegate(delegate: self)
        presenter.getPosts()
    }
    
    // добавляем таблицу на view и настраиваем
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.pin(to: view)
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
}

// MARK: - PostPresenterDelegate

extension mainViewController {
    func presentPosts(posts: [Post]) {
        self.posts = posts
    }
}

// MARK: - CustomCellDelegate

extension mainViewController {
    func shareImage(cell: CustomTableViewCell) {
        let image = cell.imagePost.image
        let imageToShare = [image!]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)}
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension mainViewController{
    // работа с ячейками
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellIdentifier, for: indexPath) as! CustomTableViewCell
        let post = posts[indexPath.row]
        cell.setDataOnCell(post: post)
        cell.delegate = self
        return cell
    }
    
    //количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
}
