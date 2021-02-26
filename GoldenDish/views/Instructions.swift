//
//  Instructions.swift
//  GoldenDish
//
//  Created by נדב אבנון on 23/02/2021.
//

import UIKit

class Instructions : UIView  {
    
    fileprivate let contentText : UITextView =  {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isUserInteractionEnabled = false
        textView.textAlignment = .center
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    fileprivate lazy var container : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = CGSize(width: frame.width + 100, height: frame.height + 100)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(container)
        container.addSubview(contentText)
        self.frame = UIScreen.main.bounds
        self.addSubview(container)
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        contentText.heightAnchor.constraint(equalTo:container.heightAnchor).isActive = true
        contentText.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        contentText.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        contentText.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }
    convenience init(frame:CGRect,instructions:String) {
        self.init(frame: frame)
        let htmlString = "<div style='text-align:justify; font-size:13px;font-family:HelveticaNeue;color:#362932;'>"
        var instructionsHtml = instructions
        instructionsHtml.insert(contentsOf: htmlString, at: instructionsHtml.startIndex)
        if let htmlData = instructionsHtml.data(using: String.Encoding.unicode) {
            do {
                let attributedText = try NSAttributedString(data: htmlData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                contentText.attributedText = attributedText
            } catch let e as NSError {
                print("Couldn't translate \(instructionsHtml): \(e.localizedDescription) ")
            }
        }

        print(instructions)
    }
    required init?(coder: NSCoder) {
        fatalError(coder.debugDescription)
    }
}
