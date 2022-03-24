//
//  PostPresenter.swift
//  homeWork
//
//  Created by Александр Романов on 22.03.2022.
//

import UIKit

protocol PostPresenterDelegate: AnyObject {
    func presentPosts(posts: [Post])
}

class PostPresenter {
    
    weak var delegate: PostPresenterDelegate?
    
    public func getPosts(){
        let posts = fetchData()
        self.delegate?.presentPosts(posts: posts)
    }
    
    public func setViewDelegate(delegate: PostPresenterDelegate){
        self.delegate = delegate
    }
    
}

// MARK: - Расширение для загрузки данных

extension PostPresenter{
    func fetchData() -> [Post] {
        let post1 = Post(imageProfile: imagesProfiles.first, nameProfile: "Dasha Badavi", imagePost: imagesPosts.first, textProfile: "#sima #sigma30mmf14 #nikon #anapa #vsco #vscorussia #vscocam #russia #инстаграмнедели #sun #sunset #sea #blaacksea #nature #anapa #анапа", countLikes: UInt.random(in: 0..<1000))
        let post2 = Post(imageProfile: imagesProfiles.second, nameProfile: "Alexander Mazurov", imagePost: imagesPosts.second, textProfile: "#abkhazia #sukhumi #boat #sea #sunset #evening #sail #sigma #sigma30mmf14 #nikon #vscorussia #vsco #vscocam #nikonrussia #абхазия #сухум #закат #лодка #парус #вечер #инстаграмнедели", countLikes: UInt.random(in: 0..<1000))
        let post3 = Post(imageProfile: imagesProfiles.third, nameProfile: "Jude Allen", imagePost: imagesPosts.third, textProfile: "#vsco #vscorussia #vscocam #sun #sunset #russia #iphonephoto #dock #boat #evening #summer #sunlight #инстаграмнедели #light", countLikes: UInt.random(in: 0..<1000))
        let post4 = Post(imageProfile: imagesProfiles.fourth, nameProfile: "John Turner", imagePost: imagesPosts.fourth, textProfile: "#abkhazia #ritsa #lake #mount #summer #sigma #sigma30mmf14 #nikon #vscorussia #vsco #vscocam #nikonrussia #абхазия #озерорица #рица #озеро #горы #инстаграмнедели", countLikes: UInt.random(in: 0..<1000))
        let post5 = Post(imageProfile: imagesProfiles.fifth, nameProfile: "lillyisblind", imagePost: imagesPosts.fifth, textProfile: "Красивое фото кувшинки (с) @irenborodina #sukhumi #abkhazia #garden#flowers #waterlilies #pond #summer#сухум #ботаническийсад #кувшинка #цветок #пруд #абхазия #sigma #sigma30mmf14 #nikon #vscorussia #vsco #vscocam #nikonrussia", countLikes: UInt.random(in: 0..<1000))
        let post6 = Post(imageProfile: imagesProfiles.sixth, nameProfile: "nitkavilka", imagePost: imagesPosts.sixth, textProfile: "#sigma #nikon #sigma30mmf14 #nikonrussia #tulip #tulips #vsco #vscorussia #vscocam #russia #spring #color #москва #инстаграмнедели #природа", countLikes: UInt.random(in: 0..<1000))
        let post7 = Post(imageProfile: imagesProfiles.seventh, nameProfile: "Aleksandra Tale", imagePost: imagesPosts.seventh, textProfile: "Model: шикарный котик. Желаю всем быть такими же фотогеничными😊 #35mm #vsco #vscocam #vscorussia #nikon #nikonrussia #инстаграмнедели #natgeoru #natgeo #msk #mskpit #kgd", countLikes: UInt.random(in: 0..<1000))
        let post8 = Post(imageProfile: imagesProfiles.eighth, nameProfile: "Anna Khalitova", imagePost: imagesPosts.eighth, textProfile: "#35mm #vsco #vscocam #vscorussia #nikon #nikonrussia #natgeoru #moscow #moscowcity #city #инстаграмнедели", countLikes: UInt.random(in: 0..<1000))
        let post9 = Post(imageProfile: imagesProfiles.ninth, nameProfile: "Dmitry Grunenkov", imagePost: imagesPosts.ninth, textProfile: "#35mm #vsco #vscocam #vscorussia #nikon #nikonrussia #инстаграмнедели #natgeoru #natgeo #msk #mskpit #autumn #leaf #red #sun #sunlight", countLikes: UInt.random(in: 0..<1000))
        let post10 = Post(imageProfile: imagesProfiles.tenth, nameProfile: "Isaac Lane Koval", imagePost: imagesPosts.tenth, textProfile: "#vsco #vscocam #vscorussia #nikon #bigstonebridge #cathedralofchristthesaviour #night #moscow", countLikes: UInt.random(in: 0..<1000))
        
        return [post1, post2, post3, post4, post5, post6, post7, post8, post9, post10]
    }
}
