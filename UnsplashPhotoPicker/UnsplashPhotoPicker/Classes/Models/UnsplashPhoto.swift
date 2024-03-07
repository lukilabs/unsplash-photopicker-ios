//
//  UnsplashPhoto.swift
//  Submissions
//
//  Created by Olivier Collet on 2017-04-10.
//  Copyright © 2017 Unsplash. All rights reserved.
//

import UIKit

/// A struct representing a photo from the Unsplash API.
public struct UnsplashPhoto: Codable {

    public enum URLKind: String, Codable {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
    public struct Links: Codable {
        var `self`: URL?
        var html: URL?
        var alternative_html: [String: URL]?
        var download: URL?
        var download_location: URL?
    }

    public let identifier: String
    public let height: Int
    public let width: Int
    public let color: UIColor?
    public let exif: UnsplashPhotoExif?
    public let user: UnsplashUser
    public let urls: [URLKind: URL]
    public let links: Links
    public let likesCount: Int
    public let downloadsCount: Int?
    public let viewsCount: Int?
    public let blurHash: String?

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case height
        case width
        case color
        case exif
        case user
        case urls
        case links
        case likesCount = "likes"
        case downloadsCount = "downloads"
        case viewsCount = "views"
        case blurHash = "blur_hash"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)

        if let hexString = try? container.decode(String.self, forKey: .color) {
            color = UIColor(hexString: hexString)
        } else {
            color = nil
        }

        exif = try? container.decode(UnsplashPhotoExif.self, forKey: .exif)
        user = try container.decode(UnsplashUser.self, forKey: .user)
        urls = try container.decode([URLKind: URL].self, forKey: .urls)
        links = try container.decode(Links.self, forKey: .links)
        likesCount = try container.decode(Int.self, forKey: .likesCount)
        downloadsCount = try? container.decode(Int.self, forKey: .downloadsCount)
        viewsCount = try? container.decode(Int.self, forKey: .viewsCount)
        blurHash = try? container.decode(String.self, forKey: .blurHash)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(height, forKey: .height)
        try container.encode(width, forKey: .width)
        try? container.encode(color?.hexString, forKey: .color)
        try? container.encode(exif, forKey: .exif)
        try container.encode(user, forKey: .user)
        try container.encode(urls.convert({ ($0.key.rawValue, $0.value.absoluteString) }), forKey: .urls)
        try container.encode(links, forKey: .links)
        try container.encode(likesCount, forKey: .likesCount)
        try? container.encode(downloadsCount, forKey: .downloadsCount)
        try? container.encode(viewsCount, forKey: .viewsCount)
        try? container.encode(blurHash, forKey: .blurHash)
    }

}
