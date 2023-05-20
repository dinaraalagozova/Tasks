//
//  ImageLoader.swift
//  TaskTwo
//
//  Created by Dinara Alagozova on 19.05.2023.
//

import Foundation
import UIKit
//
//class ImageLoader {
//    static func loadImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                
//                if let error = error {
//                    print("Error loading image: \(error.localizedDescription)")
//                    completion(nil)
//                    return
//                }
//                
//                guard let httpResponse = response as? HTTPURLResponse,
//                      httpResponse.statusCode == 200,
//                      let data = data else {
//                    print("Invalid response or data")
//                    completion(nil)
//                    return
//                }
//                
//                let image = UIImage(data: data)
//                completion(image)
//            }.resume()
//        }
//
//}

class ImageLoader {
    static func loadImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completion(image)
            } catch {
                print("Failed to load image from URL: \(url), error: \(error)")
                completion(nil)
            }
        }
    }
}
