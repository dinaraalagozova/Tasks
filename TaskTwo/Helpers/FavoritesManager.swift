//
//  FavoritesManager.swift
//  TaskTwo
//
//  Created by Dinara Alagozova on 19.05.2023.
//

import Foundation
import UIKit

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let maxFavoritesCount = 10 // Максимальное количество элементов в избранном
    private var favorites: [Favorite] = [] // Массив избранных элементов
    
    private init() {
        // Загрузка избранных элементов из базы данных или другого хранилища при инициализации
        favorites = DatabaseManager.shared.getAllFavorites()
    }
    
    // Метод для добавления элемента в избранное
    func addFavorite(_ favorite: Favorite) {
        if favorites.count >= maxFavoritesCount {
            deleteOldestFavorite()
        }
       
        DatabaseManager.shared.insertFavorite(query: favorite.query, imageURL: favorite.imageURL)
        favorites.append(favorite)
    }
    
    // Метод для удаления элемента из избранного
    func removeFavorite(_ favorite: Favorite) {
        DatabaseManager.shared.deleteFavorite(id: favorite.id)
        if let index = favorites.firstIndex(of: favorite) {
            favorites.remove(at: index)
        }
    }
    
    // Метод для получения всех избранных элементов
    func getAllFavorites() -> [Favorite] {
        return favorites
    }
    
    // Метод для удаления самого старого элемента из избранного
    private func deleteOldestFavorite() {
        if let oldestFavorite = favorites.min(by: { $0.date < $1.date }) {
            removeFavorite(oldestFavorite)
        }
    }
}

