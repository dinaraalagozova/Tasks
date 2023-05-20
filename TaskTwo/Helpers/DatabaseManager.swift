//
//  DatabaseManager.swift
//  TaskTwo
//
//  Created by Dinara Alagozova on 19.05.2023.
//

import UIKit
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    private let dbPath: String
    private var db: OpaquePointer?
    
    private init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("favorites.sqlite")
        dbPath = fileURL.path
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("Error opening database")
        }
        
        createTable()
    }
    
    private func createTable() {
        let createTableQuery = "CREATE TABLE IF NOT EXISTS favorites (id INTEGER PRIMARY KEY AUTOINCREMENT, query TEXT, imageURL TEXT);"
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Error creating table")
        }
    }
    
    func insertFavorite(query: String, imageURL: String) {
        let insertQuery = "INSERT INTO favorites (query, imageURL) VALUES (?, ?);"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (query as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (imageURL as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error inserting favorite")
            }
            
            sqlite3_finalize(statement)
        }
    }
    
    func deleteFavorite(id: Int) {
        let deleteQuery = "DELETE FROM favorites WHERE id = ?;"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error deleting favorite")
            }
            
            sqlite3_finalize(statement)
        }
    }
    func getAllFavorites() -> [Favorite] {
            let selectQuery = "SELECT * FROM favorites;"
            var statement: OpaquePointer?
            var favorites: [Favorite] = []
            
            if sqlite3_prepare_v2(db, selectQuery, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    let id = Int(sqlite3_column_int(statement, 0))
                    let query = String(cString: sqlite3_column_text(statement, 1))
                    let imageURL = String(cString: sqlite3_column_text(statement, 2))
                    
                    // Extract the date from the database, assuming it is stored as a string
                    let dateString: String
                    if let dateStringPtr = sqlite3_column_text(statement, 3) {
                        dateString = String(cString: dateStringPtr)
                    } else {
                        dateString = ""
                    }
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    guard let date = dateFormatter.date(from: dateString) else {
                        continue
                    }

                    
                    let favorite = Favorite(id: id, query: query, imageURL: imageURL, date: date)
                    favorites.append(favorite)
                }
                
                sqlite3_finalize(statement)
            }
            
            return favorites
        }
    }

