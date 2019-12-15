//
//  ViewController.swift
//  ImagesLab
//
//  Created by Gregory Keeley on 12/13/19.
//  Copyright © 2019 Gregory Keeley. All rights reserved.
//

import UIKit

class xkcdViewController: UIViewController {

    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicTextField: UITextField!
    @IBOutlet weak var comicStepper: UIStepper! // not needed
    @IBOutlet weak var mostRecentButton: UIButton! // not needed
    @IBOutlet weak var randomComicButton: UIButton! // Not needed
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var transcriptLabel: UILabel!
    
    
    var currentComic: xkcdComic?
    var comicNum = "600"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getComics()
        loadData()
    }
    func getComics() {
        xkcdComicAPI.getTodaysComic(for: "\(comicNum)" + "/", completion: { (result) in
            switch result {
            case .failure(let AppError):
                print("Error: \(AppError)")
            case .success(let comic):
                self.currentComic = comic
            }
        })
    }
    func loadData() {
        dateLabel.text = String(("\(currentComic?.month)/\(currentComic?.day)/\(currentComic?.year)"))
        xkcdComicAPI.getTodaysComic(for: "") { (result) in
            switch result {
            case .failure(let AppError):
                print("error: \(AppError)")
            case .success(let comic):
                self.currentComic = comic
                ImageClient.fetchImage(for: comic.img) { (result) in
                    switch result {
                    case .failure(let AppError):
                        print("error: \(AppError)")
                    case .success(let image):
                        self.comicImage.image = image
                    }
                }
            }
        }
    
        
    }
}
