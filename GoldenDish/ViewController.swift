//
//  ViewController.swift
//  GoldenDish
//
//  Created by נדב אבנון on 15/02/2021.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.frame = self.view.frame
        scrollView.backgroundColor = .black
        return scrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        let strings:[String] = ["A","B","C", "D"]
        let color:UIColor = .black
        let loader = ViewLoader()
        loader.insertComponentsTo(scrollView: scrollView, textColor: color, descs: strings)
    }


}

