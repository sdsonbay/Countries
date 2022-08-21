//
//  FavoritesViewController.swift
//  Countries
//
//  Created by Deniz Sonbay on 20.08.2022.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    let elements = ["Turkey", "USA", "France", "Germany", "Brazil", "Argentina", "Chili", "Italy", "Belgium", "England"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.cellView.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.cellView.layer.cornerRadius = 7.5
        cell.countryLabel.text = FavoriteCountries.favoriteCountryNames[indexPath.row]
        cell.countryLabel.layer.name = FavoriteCountries.favoriteCountryNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteCountries.favoriteCountryNames.count
    }
    
}

