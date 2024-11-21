//
//  ImageCacheManager.swift
//
//  Created by DJ A on 11/19/24.
//

import Foundation
import SwiftUI

class ImageCacheManager {
    
    private enum ImageCacheError: Error {
        case urlCreationError, unexpectedStatusCode, unknown, dataToUIImageConversion
    }
    
    static let instance = ImageCacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func loadImages(recipes: [Recipe]) async -> [String:Image] {
        var images = [String:Image]()
        do {
            try await withThrowingTaskGroup(of: (String, Image).self) { group in
                for recipe in recipes {
                    group.addTask {
                        return try await (recipe.uuid, self.loadImage(recipe: recipe))
                    }
                }
                for try await (recipeId, image) in group {
                    images[recipeId] = image
                }
            }
        } catch(let error) {
            print("error loading images: \(error)")
        }
        return images
    }
    
    
    private func loadImage(recipe: Recipe) async throws -> Image {
        if let cachedImageData = fetch(name: recipe.uuid) {
            return Image(uiImage: cachedImageData)
        } else {
            if let urlString = recipe.photoUrlSmall, let url = URL(string: urlString) {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ImageCacheError.unexpectedStatusCode }
                    if let uiImage = UIImage(data: data) {
                        add(image: uiImage, name: recipe.uuid)
                        return Image(uiImage: uiImage)
                    } else {
                        throw ImageCacheError.dataToUIImageConversion
                    }
                } catch {
                    throw ImageCacheError.unknown
                }
            } else {
                throw ImageCacheError.urlCreationError
            }
        }
    }
    
    private func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    private func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    private func fetch(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}
