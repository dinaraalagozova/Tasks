//
//  FavoritesViewController.swift
//  TaskTwo
//
//  Created by Dinara Alagozova on 19.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let tableView = UITableView()
    var favorites: [Favorite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    private func loadFavorites() {
        favorites = FavoritesManager.shared.getAllFavorites()
        tableView.reloadData()
    }
}

extension FavoritesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.query
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let alertController = UIAlertController(title: "Remove Favorite", message: "Are you sure you want to remove this favorite?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { _ in
            FavoritesManager.shared.removeFavorite(favorite)
            self.loadFavorites()
        }
        alertController.addAction(removeAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
