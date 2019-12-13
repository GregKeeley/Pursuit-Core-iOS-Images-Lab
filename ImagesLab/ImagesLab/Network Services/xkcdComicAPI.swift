//
//  xkcdComicAPI.swift
//  ImagesLab
//
//  Created by Gregory Keeley on 12/13/19.
//  Copyright © 2019 Gregory Keeley. All rights reserved.
//

import Foundation

struct xkcdComicAPI {
    static func getTodaysComic(for comicID: String, completion: @escaping (Result<xkcdComic, AppError>) -> ()) {
        let comicID = comicID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let comicEndpointURL = "http://xkcd.com/\(comicID)info.0.json"
        guard let url = URL(string: comicEndpointURL) else {
            completion(.failure(.badURL(comicEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let comic = try JSONDecoder().decode(xkcdComic.self, from: data)
                    completion(.success(comic))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
