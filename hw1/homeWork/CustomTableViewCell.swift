//
//  CustomTableViewCell.swift
//  homeWork
//
//  Created by Александр Романов on 18.03.2022.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func shareImage(cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    weak var delegate: CustomCellDelegate?
    // картинка профиля
    private let imageProfile = UIImageView()
    // текущее изображение
    let imagePost = UIImageView()
    // кнопка лайкаhh
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
    private let scrollViewImagePost = UIScrollView()
    
    private var scale: CGFloat = 1.0 { didSet { updateImagePostTransform() } }
    private var pinchGestureAnchorScale: CGFloat?
    
    private let postView = UIView()
    private let topView = UIView()
    private let bottomView = UIView()
    
    // флаг смены состояния кнопки
    private var flag = false {
        didSet{
            flag ? (numLikes+=1) : (numLikes-=1)
        }
    }
    
    // количество лайков
    private var numLikes: UInt = 0 {
        didSet{
            likeLabel.text = getStringCountLikes(count: numLikes)
            let imgName = flag ? "suit.heart.fill" : "suit.heart"
            likeButton.setImage(UIImage(systemName: imgName), for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = .systemIndigo
        
        setupPostView()
        setupTopView()
        setupScrollViewImagePost()
        setupBottomView()
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
    
    // переделать в протокол
    func setDataOnCell(post: Post?){
        guard let post = post else {return}
        
        if let image = post.imagePost {
            imagePost.load(url: URL(string: image)!)
        } else {
            imagePost.image = UIImage(systemName: "xmark")
        }
        
        if let image = post.imageProfile {
            imageProfile.image = image
        } else {
            imageProfile.image = UIImage(systemName: "xmark")
        }
        nameProfile.text = post.nameProfile
        
        if let text = post.textProfile {
            textPost.text = text
        } else {
            textPost.text = "text not found"
        }
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
    
    private func setupPostView() {
        addSubview(postView)
        postView.backgroundColor = .white
        postView.layer.cornerRadius = 8
        postView.clipsToBounds = true
        
        postView.layer.shadowColor = UIColor.black.cgColor
        postView.layer.shadowOpacity = 0.3
        postView.layer.shadowOffset = CGSize.zero
        postView.layer.shadowRadius = 8
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            postView.topAnchor.constraint(equalTo: topAnchor),
            postView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            postView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
// MARK: - Configure top view
    
    private func setupTopView(){
        postView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 5),
            topView.topAnchor.constraint(equalTo: postView.topAnchor),
            topView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -5),
            topView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        setupImageProfile()
        setupShareButton()
        setupNameProfile()
    }
    
    private func setupImageProfile(){
        imageProfile.layer.cornerRadius = 10
        imageProfile.clipsToBounds = true
        topView.addSubview(imageProfile)
        
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageProfile.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 5),
            imageProfile.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5),
            imageProfile.widthAnchor.constraint(equalToConstant: 30),
            imageProfile.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupNameProfile(){
        nameProfile.numberOfLines = 1
        nameProfile.font = UIFont.boldSystemFont(ofSize: 16)
        topView.addSubview(nameProfile)
        
        nameProfile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameProfile.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor),
            nameProfile.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5),
            nameProfile.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor),
            nameProfile.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor),
        ])
    }
    
    private func setupShareButton(){
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        topView.addSubview(shareButton)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5),
            shareButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -5),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        shareButton.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
    }
    
//MARK: - Configure middle view
    
    private func setupScrollViewImagePost(){
        postView.addSubview(scrollViewImagePost)
        
        scrollViewImagePost.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollViewImagePost.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            scrollViewImagePost.topAnchor.constraint(equalTo: topView.bottomAnchor),
            scrollViewImagePost.trailingAnchor.constraint(equalTo: postView.trailingAnchor),
            scrollViewImagePost.heightAnchor.constraint(equalToConstant: 300),
            scrollViewImagePost.centerXAnchor.constraint(equalTo: postView.centerXAnchor)
        ])
        
        setupImagePost()
        setupLikeImage()
    }
    
    private func setupImagePost(){
        imagePost.contentMode = UIView.ContentMode.scaleAspectFit
        imagePost.isUserInteractionEnabled = true
        addGestureOnImagePost()
        scrollViewImagePost.addSubview(imagePost)
        
        imagePost.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePost.centerYAnchor.constraint(equalTo: scrollViewImagePost.centerYAnchor),
            imagePost.centerXAnchor.constraint(equalTo: scrollViewImagePost.centerXAnchor),
            imagePost.leadingAnchor.constraint(equalTo: scrollViewImagePost.leadingAnchor),
            imagePost.topAnchor.constraint(equalTo: scrollViewImagePost.topAnchor),
        ])
    }
    
    private func setupLikeImage(){
        likeImage.image = UIImage(systemName: "suit.heart.fill")
        likeImage.isHidden = true
        likeImage.tintColor = .red
        scrollViewImagePost.addSubview(likeImage)
        
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeImage.centerXAnchor.constraint(equalTo: scrollViewImagePost.centerXAnchor),
            likeImage.centerYAnchor.constraint(equalTo: scrollViewImagePost.centerYAnchor),
            likeImage.widthAnchor.constraint(equalToConstant: 100),
            likeImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func addGestureOnImagePost(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(onDoubleTap))
        tapGesture.numberOfTapsRequired = 2
        imagePost.addGestureRecognizer(tapGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scalePiece(_:)))
        imagePost.addGestureRecognizer(pinchGesture)
    }
    
    private func updateImagePostTransform(){
        imagePost.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
    }
    
    @objc private func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        switch gestureRecognizer.state {
        case .began:
            pinchGestureAnchorScale = gestureRecognizer.scale
        case .changed:
            guard let pinchGestureAnchorScale = pinchGestureAnchorScale else { return }
            if pinchGestureAnchorScale <= 1 { return }
            let gestureScale = gestureRecognizer.scale
            scale += gestureScale - pinchGestureAnchorScale
            self.pinchGestureAnchorScale = gestureScale
        case .cancelled, .ended:
            scale = 1
            pinchGestureAnchorScale = nil
        case .possible, .failed:
            print("\(gestureRecognizer.state)")
            break
        default:
            break
        }
    }
    
//MARK: - Configure bottom view
    private func setupBottomView(){
        postView.addSubview(bottomView)
        //bottomView.backgroundColor = .green
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 5),
            bottomView.topAnchor.constraint(equalTo: scrollViewImagePost.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -5),
            bottomView.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -5)
        ])
        
        setupLikeButton()
        setupLikeLabel()
        setupTextPost()
    }
    
    private func setupLikeButton(){
        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        likeButton.tintColor = .blue
        bottomView.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
            likeButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        likeButton.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
    }
    
    private func setupLikeLabel(){
        likeLabel.numberOfLines = 1
        likeLabel.textColor = .blue
        bottomView.addSubview(likeLabel)
        
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            likeLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -5),
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
        bottomView.addSubview(textPost)
        
        textPost.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textPost.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
            textPost.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 5),
            textPost.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -5),
            textPost.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5)
        ])
    }
}
