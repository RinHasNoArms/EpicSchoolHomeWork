//
//  customTableViewCell.swift
//  homeWork
//
//  Created by Александр Романов on 18.03.2022.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func shareImage(cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    // картинка профиля
    private let imageProfile = UIImageView()
    // текущее изображение
    let imagePost = UIImageView()
    // кнопка лайка
    private let likeButton = UIButton()
    // лейбл количества лайков
    private let likeLabel = UILabel()
    // имя профиля
    private let nameProfile = UILabel()
    // текс пользователя
    private let textPost = UILabel()
    // кнопка "поделиться изображением"
    private let shareButton = UIButton()
    // анимация лайка
    private let likeImage = UIImageView()
    private let separator = UIView()
    
    // флаг смены состояния кнопки
    var flag = false {
        didSet{
            flag ? (numLikes+=1) : (numLikes-=1)
        }
    }
    
    // количество лайков
    var numLikes: UInt = 0 {
        didSet{
            likeLabel.text = getStringCountLikes(count: numLikes)
            let imgName = flag ? "suit.heart.fill" : "suit.heart"
            likeButton.setImage(UIImage(systemName: imgName), for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
        setupImageProfile()
        setupShareButton()
        setupNameProfile()
        setupImagePost()
        setupLikeImage()
        setupLikeButton()
        setupLikeLabel()
        setupSeparator()
        setupTextPost()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeClick(_ sender: UIButton){
        flag = !flag
    }
    
    @objc func onDoubleTap(_ sender: AnyObject) {
        flag = !flag
        if flag {
            animateImage()
        }
    }
    
    @objc func shareImage(_ sender: UIButton){
        if let delegateObject = self.delegate {
            delegateObject.shareImage(cell: self)
        }
    }
    
    func setDataOnCell(post: Post){
        imagePost.image = post.imagePost
        imageProfile.image = post.imageProfile
        nameProfile.text = post.nameProfile
        textPost.text = post.textProfile
        numLikes = post.countLikes
    }
    
    private func animateImage(){
        likeImage.isHidden = false
        likeImage.alpha = 1.0
        
        UIView.animate(withDuration: 0.5, delay: 0.15, options: [], animations: {
            self.likeImage.alpha = 0
        }, completion: {
            (value: Bool) in self.likeImage.isHidden = true
        })
    }
    
    private func getStringCountLikes(count: UInt) -> String {
        let formatStr: String = NSLocalizedString("Count Likes", comment: "")
        let resultStr: String = String.localizedStringWithFormat(formatStr, count)
        return resultStr
    }
    
    private func setupImageProfile(){
        imageProfile.layer.cornerRadius = 10
        imageProfile.clipsToBounds = true
        addSubview(imageProfile)
        
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageProfile.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageProfile.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageProfile.widthAnchor.constraint(equalToConstant: 30),
            imageProfile.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupNameProfile(){
        nameProfile.numberOfLines = 1
        nameProfile.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(nameProfile)
        
        nameProfile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameProfile.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor),
            nameProfile.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameProfile.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor),
            nameProfile.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor),
        ])
    }
    
    private func setupShareButton(){
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        addSubview(shareButton)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        shareButton.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
    }
    
    private func addGestureOnImagePost(){
        let gesture = UITapGestureRecognizer(target: self, action:#selector(onDoubleTap))
        gesture.numberOfTapsRequired = 2
        imagePost.addGestureRecognizer(gesture)
    }
    
    private func setupImagePost(){
        imagePost.contentMode = UIView.ContentMode.scaleToFill
        imagePost.isUserInteractionEnabled = true
        addGestureOnImagePost()
        addSubview(imagePost)
        
        imagePost.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePost.leadingAnchor.constraint(equalTo: leadingAnchor),
            imagePost.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 5),
            imagePost.trailingAnchor.constraint(equalTo: trailingAnchor),
            imagePost.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func setupLikeImage(){
        likeImage.image = UIImage(systemName: "suit.heart.fill")
        likeImage.isHidden = true
        likeImage.tintColor = .red
        addSubview(likeImage)
        
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeImage.centerXAnchor.constraint(equalTo: imagePost.centerXAnchor),
            likeImage.centerYAnchor.constraint(equalTo: imagePost.centerYAnchor),
            likeImage.widthAnchor.constraint(equalToConstant: 100),
            likeImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupLikeButton(){
        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        likeButton.tintColor = .blue
        addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            likeButton.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 5),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        likeButton.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
    }
    
    private func setupLikeLabel(){
        likeLabel.numberOfLines = 1
        likeLabel.textColor = .blue
        addSubview(likeLabel)
        
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeLabel.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 5),
            likeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            likeLabel.heightAnchor.constraint(equalToConstant: 30),
            likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
        ])
    }
    
    private func setupSeparator(){
        addSubview(separator)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func setupTextPost(){
        textPost.numberOfLines = 0
        textPost.textColor = .black
        addSubview(textPost)
        
        textPost.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textPost.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            textPost.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 5),
            textPost.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            textPost.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -5)
        ])
    }
}


