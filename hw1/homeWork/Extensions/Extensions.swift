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
