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

extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scalePiece(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }
    
    @objc private func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.scale < 1 {return}
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
          gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))!
          gestureRecognizer.scale = 1.0
       }
    }
}
