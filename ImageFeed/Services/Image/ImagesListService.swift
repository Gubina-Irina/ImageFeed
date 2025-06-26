//
//  Untitled.swift
//  ImageFeed
//
//  Created by Irina Gubina on 23.06.2025.
//

import Foundation

enum ImagesListServiceError: Error {
    case invalidRequest
}

class ImagesListService {
    private (set) var photos: [Photo] = []
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    static let shared = ImagesListService()
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private let dateFormatter = ISO8601DateFormatter()
    
    private var lastLoadedPage: Int?
    private let perPage = 10
    
    
    private init() {}
    
    private func fetchPhotosNextPage() {
        guard task == nil else {return}
        
        let nextPage = (lastLoadedPage ?? 0) + 1
        
        guard let request = makePhotosRequest(page: nextPage, perPage: perPage) else {
            print("[ImagesListService] Invalid request")
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let photoResults):
                    self.lastLoadedPage = nextPage
                    let newPhotos = photoResults.map { photoResult in
                        return Photo(id: photoResult.id,
                                     size: CGSize(width: photoResult.width, height: photoResult.height),
                                     createdAt: self.dateFormatter.date(from: photoResult.createdAt),
                                     welcomeDescription: photoResult.description,
                                     thumbImageURL: photoResult.urls.thumb,
                                     largeImageURL: photoResult.urls.full,
                                     isLiked: photoResult.likedByUser)
                    }
                    self.photos.append(contentsOf: newPhotos)
                    
                    NotificationCenter.default.post(
                        name: ImagesListService.didChangeNotification,
                        object: self
                    )
                    
                case .failure(let error):
                    print("❌ [ImagesListService] Network error: \(error.localizedDescription)")
                }
                self.task = nil
            }
        }
        self.task = task
        task.resume()
    }
    
    private func makePhotosRequest(page: Int, perPage: Int) -> URLRequest? {
        guard let url = URL(string: "https://unsplash.com/photos") else {
            assertionFailure("[ImagesListService] Invalid URL")
            return nil
        }
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "unsplash.com"
        urlComponents.path = "/photos"
        
        let queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("[ImagesListService] Invalid URL components")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(OAuth2TokenStorage().token ?? "")", forHTTPHeaderField: "Authorization")
        return request
        
    }
}
