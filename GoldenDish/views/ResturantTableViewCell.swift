//
//  ResturantTableViewCell.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//

import UIKit

class ResturantTableViewCell: UITableViewCell {
    public static let identifier = "ResturantTableViewCell"
    public static let cellHeight:CGFloat =  100.0
    
    fileprivate let dishImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate let dishTitle : UILabel = {
        let label = UILabel()
        label.font  = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let dishDesc : UILabel = {
        let label = UILabel()
        label.font  = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(dishTitle)
        contentView.addSubview(dishDesc)
        contentView.addSubview(dishImage)
        dishImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        dishImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        dishImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
       // dishImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dishImage.widthAnchor.constraint(equalToConstant: ResturantTableViewCell.cellHeight - 32).isActive = true
        dishTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        dishTitle.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor,constant: 16).isActive = true
        dishTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        dishDesc.topAnchor.constraint(equalTo: dishTitle.bottomAnchor, constant: 8).isActive = true
        dishDesc.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor,constant: 16).isActive = true
        dishDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func populate(recipe:CoreHotRecipe) {
        dishImage.image = nil
        let title = recipe.title
        // let glutenFree = recipe.glutenFree
        let imageUrl = recipe.imageUrl
        //let ings = recipe.ingrediants
        let veryPopular = recipe.veryPopular
        let veryHealthy = recipe.veryHealthy
        //let vegan = recipe.vegan
        //let vegetarian = recipe.vegetarian
        let readyInMinutes = recipe.readyInMinutes
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            guard let imageurl = imageUrl else {return}
            guard let url = URL(string: imageurl) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                self?.dishImage.image = image
            }
        }
        dishTitle.text = title
        var desc = ""
        if veryHealthy {
            desc += "This dish is considered very healthy!, "
        }
        if veryPopular {
            desc += "This Dish is rated 5/5 stars!, "
        }
        desc += "This dish takes \(readyInMinutes) minutes to cook!"
        dishDesc.text = desc
    }
    func populate(recipe:CoreHotFavoriteRecipe) {
        dishImage.image = nil
        let title = recipe.title
        // let glutenFree = recipe.glutenFree
        let imageUrl = recipe.imageUrl
        //let ings = recipe.ingrediants
        let veryPopular = recipe.veryPopular
        let veryHealthy = recipe.veryHealthy
        //let vegan = recipe.vegan
        //let vegetarian = recipe.vegetarian
        let readyInMinutes = recipe.readyInMinutes
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            guard let imageurl = imageUrl else {return}
            guard let url = URL(string: imageurl) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                self?.dishImage.image = image
            }
        }
        dishTitle.text = title
        var desc = ""
        if veryHealthy {
            desc += "This dish is considered very healthy!, "
        }
        if veryPopular {
            desc += "This Dish is rated 5/5 stars!, "
        }
        desc += "This dish takes \(readyInMinutes) minutes to cook!"
        dishDesc.text = desc
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
