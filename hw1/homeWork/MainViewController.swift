//
//  MainViewController.swift
//  homeWork
//
//  Created by Александр Романов on 17.03.2022.
//

import UIKit

final class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var presenter: PostPresenter?
    private var posts: [Post]?
    
    struct Cells {
        static let cellIdentifier = "cellNode"
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: Cells.cellIdentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RosGramm"
        setupPresenter()
        setupTableView()
    }
    
    private func setupPresenter() {
        self.presenter = PostPresenter(with: self)
    }
    
    // добавляем таблицу на view и настраиваем
    private func setupTableView() {
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

extension MainViewController: PostPresenterProtocol {
    func updateData(_ posts: [Post]?) {
        self.posts = posts
        tableView.reloadData()
    }
}

// MARK: - CustomCellDelegate

extension MainViewController: CustomCellDelegate {
    func shareImage(cell: CustomTableViewCell) {
        let image = cell.imagePost.image
        let imageToShare = [image!]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)}
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController{
    // работа с ячейками
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellIdentifier, for: indexPath) as! CustomTableViewCell
        let post = posts?[indexPath.row]
        cell.setDataOnCell(post: post)
        cell.delegate = self
        return cell
    }
    
    //количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts?.count ?? 0
    }
}
