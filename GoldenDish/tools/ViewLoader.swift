//
//  ViewFactory.swift
//  GoldenDish
//
//  Created by נדב אבנון on 23/02/2021.
//

import UIKit

class ViewLoader {
    func insertComponentsTo(scrollView:UIScrollView,textColor:UIColor,descs:[String]) {
        var scrollViewInitialHeight:CGFloat = 550
        var scrollViewInitialWidth:CGFloat = 350
        var scrollWidthSet:Bool = false
        var ingViews:[UIView] = []
        for (i,desc) in descs.enumerated() {
            let labelText = desc
            if !scrollWidthSet {
                if labelText.count >= 45 {
                    scrollViewInitialWidth +=  labelText.count > 65 ? 220 : labelText.count > 60 ? 170 : 0
                    scrollWidthSet = true
                }
            }
            let view = UIView()
            let image = UIImageView(image: UIImage(systemName: "plus.circle"))
            let inglabel = UILabel()
            view.addSubview(image)
            view.addSubview(inglabel)
            scrollView.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            inglabel.textColor = textColor
            inglabel.translatesAutoresizingMaskIntoConstraints = false
            inglabel.font = UIFont.systemFont(ofSize: 14)
            inglabel.numberOfLines = 0
            inglabel.text = labelText
            inglabel.numberOfLines = 0
            
            image.translatesAutoresizingMaskIntoConstraints = false
            image.layer.shadowRadius = 4
            image.layer.shadowOpacity = 0.3
            image.layer.shadowOffset = CGSize(width: 0, height: 6)
            
            image.widthAnchor.constraint(equalToConstant: 40).isActive = true
            image.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            inglabel.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            inglabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
            inglabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8).isActive = true
            
            if i > 0 {
                
                view.topAnchor.constraint(equalTo: ingViews[i-1].bottomAnchor, constant: 16)
                    .isActive = true
            }else {
                view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8)
                    .isActive = true
            }
            if i >= 9 {
                scrollViewInitialHeight += 40 + 16
            }
            ingViews.append(view)
        }
        scrollView.contentSize.width = scrollViewInitialWidth
        scrollView.contentSize.height = scrollViewInitialHeight
    }
    
}

