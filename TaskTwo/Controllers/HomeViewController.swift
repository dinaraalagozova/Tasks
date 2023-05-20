//
//  ViewController.swift
//  TaskTwo
//
//  Created by Dinara Alagozova on 19.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let queryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a request"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate", for: .normal)
        button.addTarget(self, action: #selector(generateButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to favorites", for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var favorites: [Favorite] = []
    private let maxFavoritesCount = 10 // Максимальное количество картинок в избранном
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        favorites = DatabaseManager.shared.getAllFavorites()
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(queryTextField)
        view.addSubview(generateButton)
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            queryTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            generateButton.topAnchor.constraint(equalTo: queryTextField.bottomAnchor, constant: 16),
            generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 16),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private dynamic func generateButtonTapped() {
        guard let query = queryTextField.text, !query.isEmpty else {
            showError("Enter a request")
            return
        }
        
        if let favorite = favorites.first(where: { $0.query == query }) {
            loadImage(withURL: favorite.imageURL)
        } else {
            generateImage(withQuery: query)
        }
    }
    
    private func generateImage(withQuery query: String) {
        let imageURL = "https://dummyimage.com/500x500&text=\(query)"
        loadImage(withURL: imageURL)
        
        saveFavorite(query: query, imageURL: imageURL)
    }
    
    private func loadImage(withURL url: String) {
        guard let imageURL = URL(string: url) else {
            print("Invalid URL: \(url)")
            return
        }
        
        ImageLoader.loadImageFromURL(url: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                        self?.imageView.image = image
            }
        }
    }
    
    private func saveFavorite(query: String, imageURL: String) {
        if favorites.count >= maxFavoritesCount {
            deleteOldestFavorite()
        }
        
        DatabaseManager.shared.insertFavorite(query: query, imageURL: imageURL)
        favorites = DatabaseManager.shared.getAllFavorites()
    }
    
    private func deleteOldestFavorite() {
        if let oldestFavorite = favorites.min(by: { $0.date < $1.date }) {
            guard let index = favorites.firstIndex(where: {$0.id == oldestFavorite.id}) else {
                return
            }
            DatabaseManager.shared.deleteFavorite(id: oldestFavorite.id)
            favorites.remove(at: index)
        }
    }
    
    @objc private dynamic func favoriteButtonTapped() {
        guard let query = queryTextField.text, !query.isEmpty else {
            showError("Unable to add an empty query to favorites")
            return
        }
        
        if favorites.contains(where: { $0.query == query }) {
            showError("This request is already in the favorites")
            return
        }
        
        if let imageURL = imageView.image.flatMap({ $0.pngData()?.base64EncodedString() }) {
            saveFavorite(query: query, imageURL: imageURL)
            showAlert("Image added to favorites")
        } else {
            showError("Unable to add image to favorites")
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Succes", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


