//
//  xkcdComicModel.swift
//  ImagesLab
//
//  Created by Gregory Keeley on 12/13/19.
//  Copyright © 2019 Gregory Keeley. All rights reserved.
//

import Foundation

struct xkcdComic: Decodable {
    let month: String
    let num: Int
    let link: String
    let year: String
    let safe_title: String
    let transcript: String
    let alt: String
    let img: String // URL
    let title: String
    let day: String
}
