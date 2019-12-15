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
    @IBOutlet weak var comicSearchBar: UISearchBar!
    @IBOutlet weak var comicStepper: UIStepper! // not needed
    @IBOutlet weak var mostRecentButton: UIButton! // not needed
    @IBOutlet weak var randomComicButton: UIButton! // Not needed
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var transcriptTextView: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var searchNum: UILabel!
    
    var currentComic: xkcdComic? {
        didSet {
            loadData(String(comicNum))

        }
    }
    var mostRecentComicNum = 0
    
    var comicNum = 2241
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cancelButton.isEnabled = false
        searchNum.isHidden = true
        transcriptTextView.isEditable = false
        loadData(String(comicNum))
        comicSearchBar.delegate = self
                    mostRecentComicNum = self.currentComic?.num ?? 2241
    }
    
    func loadData(_ comicNum: String) {
        
        xkcdComicAPI.getTodaysComic(for: "\(comicNum)" + "/") { [weak self] (result) in
            switch result {
            case .failure(let AppError):
                print("error: \(AppError)")
            case .success(let comic):
                self?.currentComic = comic
                ImageClient.fetchImage(for: comic.img) { (result) in
                    switch result {
                    case .failure(let AppError):
                        print("error: \(AppError)")
                    case .success(let image):
                        
                        DispatchQueue.main.async {
                            self?.transcriptTextView.text = self?.currentComic?.transcript
                            self?.comicImage.image = image
                            self?.titleLabel.text = self!.currentComic?.title
                            self?.dateLabel.text = ("\(self?.currentComic!.month.description ?? "12")/\(self?.currentComic!.day.description ?? "31")/\(self?.currentComic!.year.description ?? "2019")")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        comicNum = Int(sender.value)

    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        comicNum = Int.random(in: 0...mostRecentComicNum)
        print(comicNum)
        print(mostRecentComicNum)
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
        comicNum = mostRecentComicNum
        print(comicNum)
        print(mostRecentComicNum)
    }
    @IBAction func cancelClicked() {
        comicSearchBar.resignFirstResponder()
        //cancelButton.isEnabled = false
    }
}

extension xkcdViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                print(searchBar.text!)
        cancelButton.isEnabled = true
        searchNum.isHidden = false
        searchNum.text = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cancelButton.isEnabled = true
        print(comicNum)
        print(mostRecentComicNum)
        searchNum.isHidden = true
        var searchInt: Int
        searchInt = Int(searchBar.text!) ?? mostRecentComicNum
        
        if !searchBar.text!.isEmpty {
        if searchInt <= mostRecentComicNum {
        comicNum = Int(searchBar.text!) ?? 0
        loadData(String(comicNum))
        } else {
            DispatchQueue.main.async {
                self.showAlert(title: "App Error", message: "Comic out of range")
            }
            print("search out of range")
        }
            comicSearchBar.resignFirstResponder()
        } else {
            DispatchQueue.main.async {
                self.showAlert(title: "Search Field Empty", message: "Please enter valid number up to \(self.mostRecentComicNum)")
            }
            comicSearchBar.resignFirstResponder()
        }
    }
}
