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
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
