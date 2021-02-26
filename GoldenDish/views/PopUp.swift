//
//  File.swift
//  GoldenDish
//
//  Created by נדב אבנון on 16/02/2021.
//

import UIKit


class PopUp : UIView {
    fileprivate var mainImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.sizeToFit()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = 8.0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate var title : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt Thin", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    fileprivate var container : UIView = {
        let container  = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    fileprivate var descriptionText : UITextView = {
        let descriptionText = UITextView()
        descriptionText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        descriptionText.isUserInteractionEnabled = false
        descriptionText.textAlignment =  .center
        descriptionText.font = UIFont(name: "Marker Felt Thin", size: 10.0)
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        return descriptionText
    }()
    func animateIn() {
        self.transform = CGAffineTransform(translationX: 0, y: +self.frame.height)
        self.alpha = 0
    
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: []) {
            self.transform = .identity
            self.alpha = 1
        }
    }
    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self)
            gestureRecognizer.view!.center =  CGPoint(x: gestureRecognizer.view!.center.x + translation.x,y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self)
        }
    }
    @objc func animateOut() {
        let height =  self.frame.height
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: []) {
            self.transform = CGAffineTransform(translationX: 0, y: -height + 30)
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: []) {
                self?.transform = CGAffineTransform(translationX: 0, y: +height)
               self?.alpha = 0
           } completion: { [weak self] _ in
               self?.removeFromSuperview()
           }
        }
    }
    convenience init(frame:CGRect,title:String,imageurl:String) {
        self.init(frame:frame)
        self.title.text = title
        guard let url = URL(string: imageurl)  else {return}
        guard let imageData = try? Data(contentsOf: url) else {return}
        guard let image = UIImage(data: imageData) else {return}
        self.mainImage.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        self.backgroundColor = UIColor.white // UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)
        self.clipsToBounds = true
        self.addSubview(mainImage)
        self.addSubview(title)
        self.addSubview(descriptionText)
        mainImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        mainImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        title.topAnchor.constraint(equalTo: mainImage.bottomAnchor,constant: 8).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        animateIn()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
