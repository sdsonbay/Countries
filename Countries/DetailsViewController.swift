//
//  DetailsViewController.swift
//  Countries
//
//  Created by Deniz Sonbay on 20.08.2022.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var flagImage: WKWebView!
    var wikicode: String!
    @IBOutlet weak var detailsFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var countryAbbreviationLabel: UILabel!
    override func viewDidLoad() {

        apiCall()
        
        super.viewDidLoad()
        
        if FavoriteCountries.favoriteCountryNames.contains(ViewController.clickedCountryName){
            detailsFavoriteButton.tintColor = .black
        }else{
            detailsFavoriteButton.tintColor = .systemGray5
        }
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toTableViewVC", sender: self)
    }
    
    func apiCall(){
        let headers = [
            "X-RapidAPI-Key": "c8bf4b032amsh638f731fd757160p14a864jsn99077c612ea7",
            "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/" + ViewController.clickedCountryID)! as URL,
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
                            // put in function
                            return
                        }
                        print("JSON Dictionary! \(dictionary)")
                        
                        let countryDetails =  dictionary["data"] as! Dictionary<String, Any>
                        self.countryAbbreviationLabel.text = ViewController.clickedCountryID
                        self.wikicode = countryDetails["wikiDataId"] as! String
                        self.navigationItem.title = countryDetails["name"] as! String
                    
                        var htmlString = "<img src =\""  + (countryDetails["flagImageUri"] as! String) + "\" "
                        
                        htmlString = htmlString + "width=\"100%\" "
                        htmlString = htmlString + "height=\"100%\" >"
                        
                        self.flagImage.loadHTMLString(htmlString, baseURL: nil)
                        
                        
                        
                    }
                    catch let error as NSError {
                        print("Found an error - \(error)")
                    }
                }
            }
        })

        dataTask.resume()
    }
    @IBAction func infoButtonTapped(_ sender: Any) {
        print(ViewController.clickedCountryID)
        var url = "https://www.wikidata.org/wiki/" + wikicode
        UIApplication.shared.open(URL(string: url)!)
    }
    

}
