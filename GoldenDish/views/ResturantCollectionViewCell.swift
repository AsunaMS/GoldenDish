//
//  ResturantCollectionViewCell.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//

import UIKit
class ResturantCollectionViewCell : UICollectionViewCell {
    static let identifier = "ResturantCollectionViewCell"
    
    fileprivate let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate func desc(image:UIImage,_ num:Int) -> UIView {
        let view = UIView()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        switch num {
        case 1:
            view.addSubview(dishRatingLabel)
            dishRatingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            dishRatingLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor,constant: 2).isActive = true
        case 2:
            view.addSubview(dishCookingTimeLabel)
            dishCookingTimeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            dishCookingTimeLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor,constant: 2).isActive = true
        case 3:
            view.addSubview(dishDifficultyLabel)
            dishDifficultyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            dishDifficultyLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor,constant: 2).isActive = true
        default:
            print("undefined label")
        }
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        return view
    }
    
    fileprivate lazy var stackView : UIStackView = {
        let v1 = desc(image: #imageLiteral(resourceName: "star"),1)
        let v2 = desc(image: #imageLiteral(resourceName: "clock"), 2)
        let v3 = desc(image: #imageLiteral(resourceName: "chef"), 3)
        let stack = UIStackView(arrangedSubviews: [v1,v2,v3])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    fileprivate var dishTitleLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    fileprivate var dishDescLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    fileprivate var dishRatingLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate var dishCookingTimeLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate var dishDifficultyLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate lazy var descContainer : UIView = {
        let view = UIView()
        let labelsStack = UIStackView(arrangedSubviews: [dishTitleLabel,dishDescLabel])
        labelsStack.axis = .vertical
        labelsStack.distribution = .fillEqually
        labelsStack.spacing = 0
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius =  8
        view.addSubview(stackView)
        view.addSubview(labelsStack)
        
        labelsStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        labelsStack.bottomAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        labelsStack.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        labelsStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 8).isActive = true
        return view
    }()
    
    func configure(recipe:CoreDishRecipe) {
        imageView.image = nil
        // props
        let title = recipe.title
        // let glutenFree = recipe.glutenFree
        let imageUrl = recipe.imageUrl
        //let ings = recipe.ingrediants
        let veryPopular = recipe.veryPopular
        let veryHealthy = recipe.veryHealthy
        let vegan = recipe.vegan
        let vegetarian = recipe.vegetarian
        let readyInMinutes = recipe.readyInMinutes
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            if let dishImageUrl =  imageUrl {
                guard let url = URL(string: dishImageUrl) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        
        let rating = veryPopular ? "5" : Double.random(in: 2.5...4.5).cut()
        dishTitleLabel.text = title
        dishDescLabel.text = veryHealthy ? "Very Healthy" : "Healthy"
        dishRatingLabel.text = rating
        dishCookingTimeLabel.text = "\(readyInMinutes)min"
        let diet = vegan ? "vega" : vegetarian ? "vege" : "norm"
        dishDifficultyLabel.text = diet
        
    }
    
    func configure(recipe:CoreDishFavoriteRecipe) {
        imageView.image = nil
        // props
        let title = recipe.title
        // let glutenFree = recipe.glutenFree
        let imageUrl = recipe.imageUrl
        //let ings = recipe.ingrediants
        let veryPopular = recipe.veryPopular
        let veryHealthy = recipe.veryHealthy
        let vegan = recipe.vegan
        let vegetarian = recipe.vegetarian
        let readyInMinutes = recipe.readyInMinutes
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            if let dishImageUrl =  imageUrl {
                guard let url = URL(string: dishImageUrl) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        
        let rating = veryPopular ? "5" : Double.random(in: 2.5...4.5).cut()
        dishTitleLabel.text = title
        dishDescLabel.text = veryHealthy ? "Very Healthy" : "Healthy"
        dishRatingLabel.text = rating
        dishCookingTimeLabel.text = "\(readyInMinutes)min"
        let diet = vegan ? "vega" : vegetarian ? "vege" : "norm"
        dishDifficultyLabel.text = diet
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(imageView)
        self.addSubview(descContainer)
        descContainer.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.5).isActive = true
        descContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 80).isActive = true
        descContainer.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16).isActive = true
        descContainer.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16).isActive = true
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
