//
//  ResturantViewController.swift
//  GoldenDish
//
//  Created by נדב אבנון on 16/02/2021.
//

import UIKit

class ResturantViewController: UIViewController {
    
    private var recipes:[CoreDishRecipe] = {
        return AppDelegate.user.coreDishRecipes?.allObjects as! Array<CoreDishRecipe>
    }()
    
    private var hotRecipes:[CoreHotRecipe] = {
        return AppDelegate.user.coreHotRecipes?.allObjects as! Array<CoreHotRecipe>
    }()
    
    private let collectionViewCellHeight:CGFloat = 150
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: collectionViewCellHeight - 30 )
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        let cView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cView.backgroundColor = .clear
        cView.register(ResturantCollectionViewCell.self, forCellWithReuseIdentifier: ResturantCollectionViewCell.identifier)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        return cView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(ResturantTableViewCell.self, forCellReuseIdentifier: ResturantTableViewCell.identifier)
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ((self.navigationController?.isNavigationBarHidden) != nil) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = AppDelegate.main_color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = UIColor.black
        bottomBorder.frame = CGRect(x: 0, y: self.navigationController?.navigationBar.frame.size.height ?? 0 - 0.5, width: self.navigationController?.navigationBar.frame.size.width ?? 0, height: 0.5)
        self.navigationController?.navigationBar.addSubview(bottomBorder)
        
        // Trends
        self.view.addSubview(collectionView)
        self.view.addSubview(tableView)
        let label  = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Trending now"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let viewAllButton = UIButton()
        viewAllButton.translatesAutoresizingMaskIntoConstraints = false
        viewAllButton.setTitle("View All", for: .normal)
        viewAllButton.setTitleColor(AppDelegate.main_color, for: .normal)
        let attrStr = NSAttributedString(string: "View All", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : AppDelegate.main_color])
        viewAllButton.setAttributedTitle(attrStr, for: .normal)
        let arrow = UIImageView()
        arrow.image = #imageLiteral(resourceName: "arrow")
        arrow.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(arrow)
        self.view.addSubview(viewAllButton)
        self.view.addSubview(label)
        // button constraints
        viewAllButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        arrow.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 18).isActive = true
        arrow.widthAnchor.constraint(equalToConstant: 18).isActive = true
        viewAllButton.trailingAnchor.constraint(equalTo: arrow.leadingAnchor, constant: -3).isActive = true
        arrow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16).isActive = true
        // label constraints
        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16).isActive = true
        
        // Trends Collection View
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 4).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewCellHeight + 70).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 50, right: 0)
        
        
        
        
        
        
        
        let secondlabel  = UILabel()
        secondlabel.font = UIFont.boldSystemFont(ofSize: 22)
        secondlabel.textColor = .black
        secondlabel.textAlignment = .center
        secondlabel.text = "Hot Recipes"
        secondlabel.translatesAutoresizingMaskIntoConstraints = false
        
        let secondViewAllButton = UIButton()
        secondViewAllButton.translatesAutoresizingMaskIntoConstraints = false
        secondViewAllButton.setTitle("View All", for: .normal)
        secondViewAllButton.setTitleColor(AppDelegate.main_color, for: .normal)
        let secondattrStr = NSAttributedString(string: "View All", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : AppDelegate.main_color])
        secondViewAllButton.setAttributedTitle(secondattrStr, for: .normal)
        let secondArrow = UIImageView()
        secondArrow.image = #imageLiteral(resourceName: "arrow")
        secondArrow.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(secondArrow)
        self.view.addSubview(secondlabel)
        self.view.addSubview(secondViewAllButton)
        
        secondViewAllButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        secondArrow.topAnchor.constraint(equalTo:  collectionView.bottomAnchor, constant: 24).isActive = true
        secondArrow.heightAnchor.constraint(equalToConstant: 18).isActive = true
        secondArrow.widthAnchor.constraint(equalToConstant: 18).isActive = true
        secondViewAllButton.trailingAnchor.constraint(equalTo: secondArrow.leadingAnchor, constant: -3).isActive = true
        secondArrow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16).isActive = true
        // label constraints
        secondlabel.topAnchor.constraint(equalTo:  collectionView.bottomAnchor, constant: 16).isActive = true
        secondlabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16).isActive = true
        
        // tableview constraints
        tableView.topAnchor.constraint(equalTo: secondlabel.bottomAnchor,constant: 16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        loadTrendyRecipes()
        loadHotRecipes()
    }
    
    
    func loadHotRecipes() {
        let ds = RecipesDataSource()
        if hotRecipes.isEmpty  {
            ds.getMultiRecipes { [weak self] (response, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                guard let response = response else {return}
                DispatchQueue.global(qos: .userInteractive).async {
                    let dishes = response.recipes
                    dishes.forEach { (dish) in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        if let title = dish.title, let dishId = dish.dishId , let readyInMinutes = dish.readyInMinutes, let imageUrl = dish.image, let glutenFree = dish.glutenFree, let vegan = dish.vegan, let vegetarian = dish.vegetarian,
                           let veryHealthy = dish.veryHealthy, let veryPopular = dish.veryPopular, let instructions = dish.instructions {
                            let dishIdInt64 = Int64(dishId)
                            let readyinMinutes64 = Int64(readyInMinutes)
                            var ingsArray:[String] = []
                            if let ings = dish.extendedIngredients, ings.count > 0 {
                                ingsArray = ings.map({ (ing)  in
                                    return ing.desc!
                                })
                            }
                            let nsArray = ingsArray as NSArray
                            let corehotRecipe:CoreHotRecipe = CoreHotRecipe(dishId: dishIdInt64, title: title, readyInMinutes: readyinMinutes64, imageUrl: imageUrl, glutenFree: glutenFree, vegan: vegan, vegetarian: vegetarian, veryHealthy: veryHealthy, veryPopular: veryPopular,ingrediants: nsArray,instructions: instructions/*.replacingOccurrences(of: "<li>", with: "").replacingOccurrences(of: "</li>", with: "").replacingOccurrences(of: "<ol>", with: "").replacingOccurrences(of: "</ol>", with: "")*/)
                            AppDelegate.user.insertHotRecipe(recipe: corehotRecipe)
                        }
                        CoreData.shared.saveContext()
                        self?.hotRecipes = AppDelegate.user.coreHotRecipes?.allObjects as! Array<CoreHotRecipe>
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    func loadTrendyRecipes() {
        let ds = RecipesDataSource()
        
        if recipes.isEmpty {
            ds.getMultiRecipes { [weak self] (response, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                guard let response = response else {return}
                DispatchQueue.global(qos: .userInteractive).async {
                    let dishes = response.recipes
                    dishes.forEach { (dish) in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        if let title = dish.title, let dishId = dish.dishId , let readyInMinutes = dish.readyInMinutes, let imageUrl = dish.image, let glutenFree = dish.glutenFree, let vegan = dish.vegan, let vegetarian = dish.vegetarian,
                           let veryHealthy = dish.veryHealthy, let veryPopular = dish.veryPopular, let instructions = dish.instructions {
                            let dishIdInt64 = Int64(dishId)
                            let readyinMinutes64 = Int64(readyInMinutes)
                            var ingsArray:[String] = []
                            if let ings = dish.extendedIngredients, ings.count > 0 {
                                ingsArray = ings.map({ (ing)  in
                                    return ing.desc!
                                })
                            }
                            let nsArray = ingsArray as NSArray
                            let coredishRecipe:CoreDishRecipe = CoreDishRecipe(dishId: dishIdInt64, title: title, readyInMinutes: readyinMinutes64, imageUrl: imageUrl, glutenFree: glutenFree, vegan: vegan, vegetarian: vegetarian, veryHealthy: veryHealthy, veryPopular: veryPopular,ingrediants: nsArray,instructions: instructions/*.replacingOccurrences(of: "<li>", with: "").replacingOccurrences(of: "</li>", with: "").replacingOccurrences(of: "<ol>", with: "").replacingOccurrences(of: "</ol>", with: "")*/)
                            AppDelegate.user.insertDishRecipe(recipe: coredishRecipe)
                        }
                        CoreData.shared.saveContext()
                        self?.recipes = AppDelegate.user.coreDishRecipes?.allObjects as! Array<CoreDishRecipe>
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
}


extension ResturantViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hotRecipes.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ResturantTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ResturantTableViewCell = tableView.dequeueReusableCell(withIdentifier: ResturantTableViewCell.identifier, for: indexPath) as! ResturantTableViewCell
        let recipe = hotRecipes[indexPath.row]
        cell.populate(recipe: recipe)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:RecipeIDViewController = RecipeIDViewController(nibName: nil, bundle: nil)
        let recipe = hotRecipes[indexPath.row]
        vc.config(recipe: recipe)
        vc.addRightButtonResturant()
        tableView.deselectRow(at: indexPath, animated: true)
        self.show(vc, sender: self)
    }
    
    
}

extension ResturantViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:RecipeIDViewController = RecipeIDViewController(nibName: nil, bundle: nil)
        let recipe = recipes[indexPath.row]
        vc.config(recipe: recipe)
        vc.addRightButtonResturant()
        self.show(vc, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ResturantCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ResturantCollectionViewCell.identifier, for: indexPath) as! ResturantCollectionViewCell
        let recipe = recipes[indexPath.row]
        cell.configure(recipe:recipe)
        return cell
    }
    
    
}
