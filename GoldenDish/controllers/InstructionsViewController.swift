//
//  InstructionsViewController.swift
//  GoldenDish
//
//  Created by נדב אבנון on 24/02/2021.
//

import UIKit

class InstructionsViewController: UIViewController {
    
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
        scrollView.backgroundColor = AppDelegate.main_color
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 100)
        return scrollView
    }()
    
    func setContentText(text:String) {
        var instructionsHtml = text
        instructionsHtml.insert(contentsOf: "•\r\n", at: instructionsHtml.startIndex)
        
        
        instructionsHtml = instructionsHtml.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil).replacingOccurrences(of: ". ", with: ".\r\n\r\n\r\n• \r\n")
        
        instructionsHtml.append(contentsOf: "\r\n*\r\nBon Appétit 😊")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.firstLineHeadIndent = 5.0
        
        contentText.attributedText =  NSAttributedString(string: text.count > 10 ? instructionsHtml : "This Recipe's Instructions are unavailable", attributes: [NSAttributedString.Key.font : UIFont(name: "Marker Felt", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        
    }
    
    @objc func dismissMe() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(container)
        container.frame = view.frame
        container.addSubview(contentText)
        contentText.frame = container.frame
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMe)))
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
