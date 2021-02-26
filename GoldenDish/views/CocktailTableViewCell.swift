//
//  CocktailTableViewCell.swift
//  GoldenDish
//
//  Created by נדב אבנון on 15/02/2021.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {
    public static let identifier = "CocktailTableViewCell"
    @IBOutlet weak var cocktailImage: UIImageView!
    
    @IBOutlet weak var cocktailName: UILabel!
    public static let cellheight:CGFloat = 170.0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(cocktail:Cocktail) {
        cocktailName?.text = cocktail.cName
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
        guard let imageurl = cocktail.cImage else {return}
        guard let url = URL(string: imageurl) else {return}
        guard let imageData = try? Data(contentsOf: url) else {return}
        guard let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                self?.cocktailImage?.image = image
            }
        }
        cocktailImage?.sizeToFit()
        cocktailImage?.contentMode = .scaleAspectFill
        cocktailImage?.clipsToBounds = true
        cocktailImage?.layer.borderWidth = 1.0
        cocktailImage?.layer.borderColor = UIColor.black.cgColor
        cocktailImage?.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
