//
//  ViewController.swift
//  Countries
//
//  Created by Deniz Sonbay on 17.08.2022.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var myDict = [String: String]()
    
    static var clickedCountryID: String!
    static var clickedCountryName: String!
    
    var countryAbbreviations = [String]()
    
    var countryNames = [String]()
    
    
    
    static var favoriteCountryNames = [String]()
    
    var favoriteCountries: Set<String> = []
    
    
    static var favs = FavoriteCountries()
    	
    var favoriteVC = FavoritesViewController()
        
    override func viewDidLoad() {
        apiCall()
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        addToFavorites(favoriteButton: sender)
        print(ViewController.favoriteCountryNames)
    }
    
    func getCountryName(button: UIButton) -> String{
        var lblText: String = ""
        for view in button.superview!.subviews{
            if view.isKind(of: UILabel.self){
                let lbl = view as! UILabel
                lblText = lbl.text!
            }
        }
        return lblText
    }
    
    func addToFavorites(favoriteButton: UIButton){
   
        var isFavorite = false
        if favoriteButton.configuration?.baseForegroundColor == .black{
            favoriteButton.configuration?.baseForegroundColor = .systemGray5
           
            isFavorite = false
        } else{
            favoriteButton.configuration?.baseForegroundColor = .black
            isFavorite = true
        }
        
        if isFavorite{
            FavoriteCountries.favoriteCountryNames.append(getCountryName(button: favoriteButton))
            self.favoriteVC.tableView?.reloadData()
           
        } else{
            let index = FavoriteCountries.favoriteCountryNames.firstIndex(of: getCountryName(button: favoriteButton))
            //ViewController.favoriteCountryNames.remove(at: index!)
            FavoriteCountries.favoriteCountryNames.remove(at: index!)
            self.favoriteVC.tableView?.reloadData()
        
        }
        

    }
    
    func apiCall(){
        let headers = [
            "X-RapidAPI-Key": "c8bf4b032amsh638f731fd757160p14a864jsn99077c612ea7",
            "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
                
                DispatchQueue.main.async {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions(rawValue: 0))
                        guard let dictionary = jsonObject as? Dictionary<String, Any> else {
                            print("Not a Dictionary")
                            return
                        }
                        
                        let countryArray =  dictionary["data"] as! NSArray
                        for x in countryArray{
                            let temp = x as! Dictionary<String, Any>
                            self.countryNames.append(temp["name"] as! String)
                            self.countryAbbreviations.append(temp["code"] as! String)
                        }
                        self.tableView?.reloadData()
                    }
                    catch let error as NSError {
                        print("Found an error - \(error)")
                    }
                }
                
                
            }
        })

        dataTask.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.cellView.layer.borderWidth = 1.5
        cell.cellView.layer.borderColor = UIColor.black.cgColor
        cell.cellView.layer.cornerRadius = 7.5
        cell.countryLabel.text = countryNames[indexPath.row]
        cell.countryLabel.layer.name = countryNames[indexPath.row]
        
        for view in cell.cellView.subviews{
            if view.isKind(of: UIButton.self){
                let btn = view as! UIButton
                if FavoriteCountries.favoriteCountryNames.contains(cell.countryLabel.text!){
                    btn.configuration?.baseForegroundColor = .black
                } else{
                    btn.configuration?.baseForegroundColor = .systemGray5
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow;
        ViewController.clickedCountryID = countryAbbreviations[indexPath!.last ?? 0]
        ViewController.clickedCountryName = countryNames[indexPath!.last ?? 0]
    }
    
   
}
