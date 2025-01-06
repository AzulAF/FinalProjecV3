//
//  ImagesShow.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 05/01/25.
//

import Foundation


struct ImagesShowResponse: Decodable{
    let imagesResponse: [ImagesShow]
}

struct ImagesShow: Decodable {
    let id: String
    let imagen: String
}
