//
//  PostPresenter.swift
//  homeWork
//
//  Created by Александр Романов on 22.03.2022.
//

import UIKit

protocol PostPresenterProtocol: AnyObject {
    func updateData(_ posts: [Post]?)
}

class PostPresenter {
    
    weak var delegate: PostPresenterProtocol?
    private let networkService: NetworkService?
    private var posts: [Post]?
    
    required init(with delegate: PostPresenterProtocol){
        self.delegate = delegate
        self.networkService = NetworkService()
        fetchComments()
    }

    private func loadPosts(bbCharacters: [BreakingBad]?){
        guard let posts = fetchLocalData(bbCharacters: bbCharacters) else {return}
        self.posts = posts
    }
    
    private func fetchComments() {
        let urlString = "https://www.breakingbadapi.com/api/characters?limit=10&offset=10"
        networkService?.downloadData(for: urlString) {(result: Result<[BreakingBad]?, Error>) in
                switch result {
                case .success(let bbCharacters):
                    self.loadPosts(bbCharacters: bbCharacters)
                    self.delegate?.updateData(self.posts)
                case .failure(let error):
                    print("Error data \(error)")
                }
        }
    }
}

// MARK: - Расширение для загрузки данных

extension PostPresenter{
    func fetchLocalData(bbCharacters: [BreakingBad]?) -> [Post]? {
        let post1 = Post(imageProfile: ImagesProfiles.image.first, nameProfile: "Dasha Badavi", imagePost: bbCharacters?[0].img, textProfile: bbCharacters?[0].name, countLikes: UInt.random(in: 0..<1000))
        let post2 = Post(imageProfile: ImagesProfiles.image.second, nameProfile: "Alexander Mazurov", imagePost: bbCharacters?[1].img, textProfile: bbCharacters?[1].name, countLikes: UInt.random(in: 0..<1000))
        let post3 = Post(imageProfile: ImagesProfiles.image.third, nameProfile: "Jude Allen", imagePost: bbCharacters?[2].img, textProfile: bbCharacters?[2].name, countLikes: UInt.random(in: 0..<1000))
        let post4 = Post(imageProfile: ImagesProfiles.image.fourth, nameProfile: "John Turner", imagePost: bbCharacters?[3].img, textProfile: bbCharacters?[3].name, countLikes: UInt.random(in: 0..<1000))
        let post5 = Post(imageProfile: ImagesProfiles.image.fifth, nameProfile: "lillyisblind", imagePost: bbCharacters?[4].img, textProfile: bbCharacters?[4].name, countLikes: UInt.random(in: 0..<1000))
        let post6 = Post(imageProfile: ImagesProfiles.image.sixth, nameProfile: "nitkavilka", imagePost: bbCharacters?[5].img, textProfile: bbCharacters?[5].name, countLikes: UInt.random(in: 0..<1000))
        let post7 = Post(imageProfile: ImagesProfiles.image.seventh, nameProfile: "Aleksandra Tale", imagePost: bbCharacters?[6].img, textProfile: bbCharacters?[6].name, countLikes: UInt.random(in: 0..<1000))
        let post8 = Post(imageProfile: ImagesProfiles.image.seventh , nameProfile: "Anna Khalitova", imagePost: bbCharacters?[7].img, textProfile: bbCharacters?[7].name, countLikes: UInt.random(in: 0..<1000))
        let post9 = Post(imageProfile: ImagesProfiles.image.ninth, nameProfile: "Dmitry Grunenkov", imagePost: bbCharacters?[8].img, textProfile: bbCharacters?[8].name, countLikes: UInt.random(in: 0..<1000))
        let post10 = Post(imageProfile: ImagesProfiles.image.tenth, nameProfile: "Isaac Lane Koval", imagePost: bbCharacters?[9].img, textProfile: bbCharacters?[9].name, countLikes: UInt.random(in: 0..<1000))
        
        return [post1, post2, post3, post4, post5, post6, post7, post8, post9, post10]
    }
}
