//
//  RandomDataSource.swift
//  UnsplashPhotoPicker
//
//  Created by Peter Wiesner on 2022. 04. 27..
//  Copyright © 2022. Unsplash. All rights reserved.
//

import Foundation

public class RandomDataSource {
    
    public init(){}
    
    private lazy var operationQueue = OperationQueue(with: "com.unsplash.randomDataSource")
    
    public func fetchRandomImages(count:Int = 6, query: String? = nil, completionBlock:@escaping ([UnsplashPhoto]?,Error?) -> ()) {
        let request = RandomUnsplashRequest(count: count, query: query)
        request.completionBlock = {
            if let error = request.error {
                completionBlock(nil, error)
                return
            }

            let items = request.items
                
            completionBlock(items,nil)
        }

        operationQueue.addOperationWithDependencies(request)
    }
}

