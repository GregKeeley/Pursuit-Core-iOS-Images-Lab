//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Gregory Keeley on 12/13/19.
//  Copyright © 2019 Gregory Keeley. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var pokemon = [Pokemon]() {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
    }
    
}
