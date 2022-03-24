//
//  Extensions.swift
//  homeWork
//
//  Created by Александр Романов on 20.03.2022.
//

import UIKit

// MARK: - Расширение для UIView, привязка на весь Safe Area
extension UIView{
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints                                           = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive            = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive    = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive  = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive      = true
    }
}

// MARK: - Расширение для лайков типа int чтобы правильно скланялось окончание
extension UInt {
    func likes() -> String {
        
        var likes: String!
        let number = self%10
        
        switch number{
        case 0:
            likes = "лайков"
        case 1:
            likes = "лайк"
        case 2...4:
            likes = "лайка"
        case 5...9:
            likes = "лайков"
        default:
            likes = "лайка"
        }
        
    return "\(self) " + likes
    }
}
