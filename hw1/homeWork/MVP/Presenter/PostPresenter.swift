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
        guard let posts = fetchData() else {return}
        self.delegate?.presentPosts(posts: posts)
    }
    
    public func setViewDelegate(delegate: PostPresenterDelegate){
        self.delegate = delegate
    }
    
}

// MARK: - Расширение для загрузки данных

extension PostPresenter{
    func fetchData() -> [Post]? {
        guard let imageProfileFirst = ImagesProfiles.image.first else {return nil}
        let post1 = Post(imageProfile: imageProfileFirst, nameProfile: "Dasha Badavi", imagePost: ImagesPosts.image.first!, textProfile: "#sima #sigma30mmf14 #nikon #anapa #vsco #vscorussia #vscocam #russia #инстаграмнедели #sun #sunset #sea #blaacksea #nature #anapa #анапа", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileSecond = ImagesProfiles.image.second else {return nil}
        let post2 = Post(imageProfile: imageProfileSecond, nameProfile: "Alexander Mazurov", imagePost: ImagesPosts.image.second!, textProfile: "#abkhazia #sukhumi #boat #sea #sunset #evening #sail #sigma #sigma30mmf14 #nikon #vscorussia #vsco #vscocam #nikonrussia #абхазия #сухум #закат #лодка #парус #вечер #инстаграмнедели", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileThird = ImagesProfiles.image.third else {return nil}
        let post3 = Post(imageProfile: imageProfileThird, nameProfile: "Jude Allen", imagePost: ImagesPosts.image.third!, textProfile: "#vsco #vscorussia #vscocam #sun #sunset #russia #iphonephoto #dock #boat #evening #summer #sunlight #инстаграмнедели #light", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileFourth = ImagesProfiles.image.fourth else {return nil}
        let post4 = Post(imageProfile: imageProfileFourth, nameProfile: "John Turner", imagePost: ImagesPosts.image.fourth!, textProfile: "#abkhazia #ritsa #lake #mount #summer #sigma #sigma30mmf14 #nikon #vscorussia #vsco #vscocam #nikonrussia #абхазия #озерорица #рица #озеро #горы #инстаграмнедели", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileFifth = ImagesProfiles.image.fifth else {return nil}
        let post5 = Post(imageProfile: imageProfileFifth, nameProfile: "lillyisblind", imagePost: ImagesPosts.image.fifth!, textProfile: "Красивое фото кувшинки (с) @irenborodina #sukhumi #abkhazia #garden#flowers #waterlilies #pond #summer#сухум #ботаническийсад #кувшинка #цветок #пруд #абхазия #sigma #sigma30mmf14 #nikon #vscorussia #vsco #vscocam #nikonrussia", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileSixth = ImagesProfiles.image.sixth else {return nil}
        let post6 = Post(imageProfile: imageProfileSixth, nameProfile: "nitkavilka", imagePost: ImagesPosts.image.sixth!, textProfile: "#sigma #nikon #sigma30mmf14 #nikonrussia #tulip #tulips #vsco #vscorussia #vscocam #russia #spring #color #москва #инстаграмнедели #природа", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileSeventh = ImagesProfiles.image.seventh else {return nil}
        let post7 = Post(imageProfile: imageProfileSeventh, nameProfile: "Aleksandra Tale", imagePost: ImagesPosts.image.seventh!, textProfile: "Model: шикарный котик. Желаю всем быть такими же фотогеничными😊 #35mm #vsco #vscocam #vscorussia #nikon #nikonrussia #инстаграмнедели #natgeoru #natgeo #msk #mskpit #kgd", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileEighth = ImagesProfiles.image.eighth else {return nil}
        let post8 = Post(imageProfile: imageProfileEighth, nameProfile: "Anna Khalitova", imagePost: ImagesPosts.image.eighth!, textProfile: "#35mm #vsco #vscocam #vscorussia #nikon #nikonrussia #natgeoru #moscow #moscowcity #city #инстаграмнедели", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileNinth = ImagesProfiles.image.ninth else {return nil}
        let post9 = Post(imageProfile: imageProfileNinth, nameProfile: "Dmitry Grunenkov", imagePost: ImagesPosts.image.ninth!, textProfile: "#35mm #vsco #vscocam #vscorussia #nikon #nikonrussia #инстаграмнедели #natgeoru #natgeo #msk #mskpit #autumn #leaf #red #sun #sunlight", countLikes: UInt.random(in: 0..<1000))
        guard let imageProfileTenth = ImagesProfiles.image.tenth else {return nil}
        let post10 = Post(imageProfile: imageProfileTenth, nameProfile: "Isaac Lane Koval", imagePost: ImagesPosts.image.tenth!, textProfile: "#vsco #vscocam #vscorussia #nikon #bigstonebridge #cathedralofchristthesaviour #night #moscow", countLikes: UInt.random(in: 0..<1000))
        
        return [post1, post2, post3, post4, post5, post6, post7, post8, post9, post10]
    }
}
