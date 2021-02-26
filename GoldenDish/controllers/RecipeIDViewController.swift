//
//  RecipeIDViewController.swift
//  GoldenDish
//
//  Created by נדב אבנון on 22/02/2021.
//

import UIKit

protocol RemovingProtocol {
    func removeFromFavorites(recipe:CoreHotFavoriteRecipe)
    func removeFromFavorites(recipe:CoreDishFavoriteRecipe)
}

class RecipeIDViewController: UIViewController {
    public static let identifier = "RecipeIDViewController"
    var removingDelegate: RemovingProtocol?
    weak var hotRecipe:CoreHotRecipe?
    weak var dishRecipe:CoreDishRecipe?
    
    weak var hotRecipeFav:CoreHotFavoriteRecipe?
    weak var dishRecipeFav:CoreDishFavoriteRecipe?
    fileprivate let imageView :UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    fileprivate let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let descLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let descContainer : UIView = {
        let view = UIView()
        view.backgroundColor = AppDelegate.main_color
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    fileprivate let sectionTitle : UILabel = {
        let label  = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Ingrediants"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled =  true
        scrollView.isUserInteractionEnabled =  true
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
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
    fileprivate lazy var extrasContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        view.layer.cornerRadius = 8
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius =  4
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive =  true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 32).isActive = true
        return view
    }()
    
    fileprivate lazy var returnButton : UIButton = {
        let button = UIButton()
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setImage(#imageLiteral(resourceName: "arrowleft"), for: .normal)
        return button
    }()
    
    
    var instructions:String = ""
    fileprivate lazy var instructionsButton : UIButton = {
        let button = UIButton()
        button.setTitle("View Instructions", for: .normal)
        button.setTitleColor(AppDelegate.main_color, for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showInstructions)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func dismissView() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        self.view.addSubview(extrasContainer)
        self.view.addSubview(sectionTitle)
        self.view.addSubview(instructionsButton)
        self.view.addSubview(scrollView)
        imageView.addSubview(descContainer)
        imageView.addSubview(returnButton)
        descContainer.addSubview(titleLabel)
        descContainer.addSubview(descLabel)
        
        
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        
        returnButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 32).isActive = true
        returnButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16).isActive = true
        
        descContainer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        descContainer.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 32).isActive = true
        descContainer.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -32).isActive = true
        descContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: descContainer.topAnchor,constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: descContainer.leadingAnchor,constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: descContainer.trailingAnchor).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: descContainer.leadingAnchor,constant: 8).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: descContainer.trailingAnchor).isActive = true
        
        extrasContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        extrasContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 32).isActive = true
        extrasContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -32).isActive = true
        extrasContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sectionTitle.topAnchor.constraint(equalTo: extrasContainer.bottomAnchor,constant: 32).isActive = true
        sectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32).isActive = true
        
        instructionsButton.topAnchor.constraint(equalTo: extrasContainer.bottomAnchor, constant: 32).isActive = true
        instructionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: sectionTitle.bottomAnchor, constant: 32).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32).isActive = true
    }
    @objc func removeFromFavorites() {
        var aString:String?  = ""
        var hot:Bool = false
        if let hotRecipeFav = hotRecipeFav {
            hot = true
            aString = hotRecipeFav.title
            AppDelegate.user.removeFromFavoriteHotRecipes(hotRecipeFav)
        } else if let dishRecipeFav = dishRecipeFav{
            aString = dishRecipeFav.title
            AppDelegate.user.removeFromFavoriteDishRecipes(dishRecipeFav)
            
        }else {
            let alert = UIAlertController(title: "Error", message: "Please try again later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true)
            }))
            return
        }
        CoreData.shared.saveContext()
        let alert = UIAlertController(title: "Removed from favorites", message: "\(aString!) has been removed to favorites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }))
        if hot {
            removingDelegate?.removeFromFavorites(recipe: hotRecipeFav!)
        }else {
            removingDelegate?.removeFromFavorites(recipe: dishRecipeFav!)
        }
        present(alert, animated: true)
        
    }
    
    @objc func addToFavorites() {
        var aString:String?  = ""
        if let hotRecipe = hotRecipe {
            aString = hotRecipe.title
            for o in AppDelegate.user.favoriteHotRecipes?.allObjects as! Array<CoreHotFavoriteRecipe> {
                if hotRecipe.title == o.title {
                    let alert = UIAlertController(title: "Opps..", message: "Seems like you already have \(o.title!) in your favorites!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                        alert.dismiss(animated: true)
                    }))
                    present(alert, animated: true)
                    return
                }
            }
            let cRecipe = CoreHotFavoriteRecipe.init(dishId: hotRecipe.dishId, title: hotRecipe.title ?? "", readyInMinutes: hotRecipe.readyInMinutes, imageUrl: hotRecipe.imageUrl ?? "", glutenFree: hotRecipe.glutenFree, vegan: hotRecipe.vegan, vegetarian: hotRecipe.vegetarian, veryHealthy: hotRecipe.veryHealthy, veryPopular: hotRecipe.veryPopular, ingrediants: hotRecipe.ingrediants ?? [], instructions: hotRecipe.instructions ?? "")
            AppDelegate.user.addToFavoriteHotRecipes(cRecipe)
        } else if let dishRecipe = dishRecipe{
            aString = dishRecipe.title
            for o in AppDelegate.user.favoriteDishRecipes?.allObjects as! Array<CoreDishFavoriteRecipe> {
                if dishRecipe.title == o.title {
                    let alert = UIAlertController(title: "Opps..", message: "Seems like you already have \(o.title!) in your favorites!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                        alert.dismiss(animated: true)
                    }))
                    present(alert, animated: true)
                    return
                }
            }
            let cRecipe = CoreDishFavoriteRecipe.init(dishId: dishRecipe.dishId, title: dishRecipe.title ?? "", readyInMinutes: dishRecipe.readyInMinutes, imageUrl: dishRecipe.imageUrl ?? "", glutenFree: dishRecipe.glutenFree, vegan: dishRecipe.vegan, vegetarian: dishRecipe.vegetarian, veryHealthy: dishRecipe.veryHealthy, veryPopular: dishRecipe.veryPopular, ingrediants: dishRecipe.ingrediants ?? [], instructions: dishRecipe.instructions ?? "")
            
            AppDelegate.user.addToFavoriteDishRecipes(cRecipe)
        }else {
            let alert = UIAlertController(title: "Error", message: "Please try again later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true)
            }))
            return
        }
        CoreData.shared.saveContext()
        let alert = UIAlertController(title: "Added to favorites", message: "\(aString!) has been saved to favorites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
        tabBarController?.selectedIndex = 1
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    @objc func showInstructions() {
        //  let popup:Instructions = Instructions.init(frame: self.view.frame, instructions:self.instructions)
        //self.view.addSubview(popup)
        // print("show")
        let ivc = InstructionsViewController.init()
        ivc.setContentText(text: instructions)
        self.present(ivc, animated: true)
        
    }
    
    func addRightButtonFavorites() {
        let selector:Selector = #selector(removeFromFavorites)
        let rightButton = UIButton()
        self.view.addSubview(rightButton)
        rightButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.setImage(#imageLiteral(resourceName: "remove"), for: .normal)
        rightButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 32).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        rightButton.heightAnchor.constraint(equalTo: returnButton.heightAnchor).isActive = true
        rightButton.heightAnchor.constraint(equalTo: returnButton.widthAnchor).isActive = true
    }
    
    func addRightButtonResturant() {
        let selector:Selector = #selector(addToFavorites)
        let rightButton = UIButton()
        self.view.addSubview(rightButton)
        rightButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        rightButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 32).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        rightButton.heightAnchor.constraint(equalTo: returnButton.heightAnchor).isActive = true
        rightButton.heightAnchor.constraint(equalTo: returnButton.widthAnchor).isActive = true
    }
    
    
    func config(recipe:CoreDishRecipe) {
        dishRecipe = recipe
        let veryHealthy = recipe.veryHealthy
        let veryPopular = recipe.veryPopular
        let readyInMinutes = recipe.readyInMinutes
        let vegan = recipe.vegan
        let vegetarian = recipe.vegetarian
        
        titleLabel.text = recipe.title
        
        var desc = ""
        if veryHealthy {
            desc += "This dish is considered very healthy!, "
        }
        if veryPopular {
            desc += "This Dish is rated 5/5 stars!, "
        }
        if let instructions = recipe.instructions {
            self.instructions = instructions
        }
        desc += "This dish takes \(readyInMinutes) minutes to cook!"
        descLabel.text = desc
        
        let rating = veryPopular ? "5" : Double.random(in: 2.5...4.5).cut()
        dishRatingLabel.text = rating
        dishCookingTimeLabel.text = "\(readyInMinutes)min"
        let diet = vegan ? "vega" : vegetarian ? "vege" : "norm"
        dishDifficultyLabel.text = diet
        
        if let imageUrl = recipe.imageUrl {
            DispatchQueue.global(qos: .userInteractive).async {[weak self] in
                guard let url = URL(string: imageUrl) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        let loader = ViewLoader()
        let textColor = UIColor.gray.darker(by: 10)!
        let ingrediants = recipe.ingrediants as? Array<String>
        guard let descs = ingrediants else {return}
        loader.insertComponentsTo(scrollView: scrollView, textColor: textColor, descs:descs)
    }
    func config(recipe:CoreHotRecipe) {
        hotRecipe = recipe
        let veryHealthy = recipe.veryHealthy
        let veryPopular = recipe.veryPopular
        let readyInMinutes = recipe.readyInMinutes
        let vegan = recipe.vegan
        let vegetarian = recipe.vegetarian
        titleLabel.text = recipe.title
        var desc = ""
        if veryHealthy {
            desc += "This dish is considered very healthy!, "
        }
        if veryPopular {
            desc += "This Dish is rated 5/5 stars!, "
        }
        desc += "This dish takes \(readyInMinutes) minutes to cook!"
        descLabel.text = desc
        
        let rating = veryPopular ? "5" : Double.random(in: 2.5...4.5).cut()
        dishRatingLabel.text = rating
        dishCookingTimeLabel.text = "\(readyInMinutes)min"
        let diet = vegan ? "vega" : vegetarian ? "vege" : "norm"
        dishDifficultyLabel.text = diet
        if let imageUrl = recipe.imageUrl {
            DispatchQueue.global(qos: .userInteractive).async {[weak self] in
                guard let url = URL(string: imageUrl) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        
        let loader = ViewLoader()
        let textColor = UIColor.gray.darker(by: 10)!
        let ingrediants = recipe.ingrediants as? Array<String>
        guard let descs = ingrediants else {return}
        loader.insertComponentsTo(scrollView: scrollView, textColor: textColor, descs:descs)
    }
    
    
    
    func config(recipe:CoreDishFavoriteRecipe) {
        dishRecipeFav = recipe
        let veryHealthy = recipe.veryHealthy
        let veryPopular = recipe.veryPopular
        let readyInMinutes = recipe.readyInMinutes
        let vegan = recipe.vegan
        let vegetarian = recipe.vegetarian
        
        titleLabel.text = recipe.title
        
        var desc = ""
        if veryHealthy {
            desc += "This dish is considered very healthy!, "
        }
        if veryPopular {
            desc += "This Dish is rated 5/5 stars!, "
        }
        if let instructions = recipe.instructions {
            self.instructions = instructions
        }
        desc += "This dish takes \(readyInMinutes) minutes to cook!"
        descLabel.text = desc
        
        let rating = veryPopular ? "5" : Double.random(in: 2.5...4.5).cut()
        dishRatingLabel.text = rating
        dishCookingTimeLabel.text = "\(readyInMinutes)min"
        let diet = vegan ? "vega" : vegetarian ? "vege" : "norm"
        dishDifficultyLabel.text = diet
        
        if let imageUrl = recipe.imageUrl {
            DispatchQueue.global(qos: .userInteractive).async {[weak self] in
                guard let url = URL(string: imageUrl) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        let loader = ViewLoader()
        let textColor = UIColor.gray.darker(by: 10)!
        let ingrediants = recipe.ingrediants as? Array<String>
        guard let descs = ingrediants else {return}
        loader.insertComponentsTo(scrollView: scrollView, textColor: textColor, descs:descs)
    }
    func config(recipe:CoreHotFavoriteRecipe) {
        hotRecipeFav = recipe
        let veryHealthy = recipe.veryHealthy
        let veryPopular = recipe.veryPopular
        let readyInMinutes = recipe.readyInMinutes
        let vegan = recipe.vegan
        let vegetarian = recipe.vegetarian
        titleLabel.text = recipe.title
        var desc = ""
        if veryHealthy {
            desc += "This dish is considered very healthy!, "
        }
        if veryPopular {
            desc += "This Dish is rated 5/5 stars!, "
        }
        desc += "This dish takes \(readyInMinutes) minutes to cook!"
        descLabel.text = desc
        
        let rating = veryPopular ? "5" : Double.random(in: 2.5...4.5).cut()
        dishRatingLabel.text = rating
        dishCookingTimeLabel.text = "\(readyInMinutes)min"
        let diet = vegan ? "vega" : vegetarian ? "vege" : "norm"
        dishDifficultyLabel.text = diet
        if let imageUrl = recipe.imageUrl {
            DispatchQueue.global(qos: .userInteractive).async {[weak self] in
                guard let url = URL(string: imageUrl) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        
        let loader = ViewLoader()
        let textColor = UIColor.gray.darker(by: 10)!
        let ingrediants = recipe.ingrediants as? Array<String>
        guard let descs = ingrediants else {return}
        loader.insertComponentsTo(scrollView: scrollView, textColor: textColor, descs:descs)
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
