//
//  RandomUnsplashRequest.swift
//  UnsplashPhotoPicker
//
//  Created by Peter Wiesner on 2022. 04. 27..
//  Copyright © 2022. Unsplash. All rights reserved.
//

import Foundation

//https://unsplash.com/documentation#get-a-random-photo
class RandomUnsplashRequest : UnsplashRequest {
    
    var items = [UnsplashPhoto]()
    
    let count:Int
    let query: String?
    
    init(count:Int, query: String? = nil) {
        self.count = count
        self.query = query
        super.init()
    }
    
    override var endpoint: String {
        return "/photos/random"
    }
    
    override func prepareParameters() -> [String: Any]? {
        return [
            "count" : self.count,
            "query" : query ?? ""
        ]
    }
    
    override func processResponseData(_ data: Data?) {
        if let photos = photosFromResponseData(data) {
            self.items = photos
            completeOperation()
        }
        super.processResponseData(data)
    }
    
    func photosFromResponseData(_ data: Data?) -> [UnsplashPhoto]? {
        guard let data = data else { return nil }

        do {
            return try JSONDecoder().decode([UnsplashPhoto].self, from: data)
        } catch {
            self.error = error
            return nil
        }
    }
}
