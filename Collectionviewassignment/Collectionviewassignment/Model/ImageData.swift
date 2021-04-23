//
//  Imagedata.swift
//  Collectionviewassignment
//
//  Created by Sahana B on 22/04/21.
//

import Foundation

struct ImageData: Codable{
    let results:[Result]
}

struct  Result: Codable{
    let urls: Urls
}

struct Urls: Codable{
    let thumb : String
}
