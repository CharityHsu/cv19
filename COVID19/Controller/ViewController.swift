//
//  ViewController.swift
//  COVID19
//
//  Created by Charity Hsu on 8/18/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import UIKit
import SafariServices

 var countryTotalCases = 0

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var newCasesLabel: UILabel!
    @IBOutlet weak var newDeathsLabel: UILabel!
    @IBOutlet weak var newRecoveredLabel: UILabel!
    @IBOutlet weak var learnMoreButton: UIButton!
   
    
    let url = URL(string: "https://api.covid19api.com/summary")!
    let dateFormatter = DateFormatter()
    let dateFormatterTwo = DateFormatter()
    var dateString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.cornerRadius = 10.0
        learnMoreButton.layer.cornerRadius = 8.0
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSZ"
        
        dateFormatterTwo.locale = .current
        dateFormatterTwo.dateFormat = "MMMM d, yyyy"
        
        getData(from: url)
        
        let date = dateFormatter.date(from: dateString)
        titleLabel.text = dateFormatterTwo.string(from: date ?? Date())
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    @IBAction func learnMoreButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/index.html") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    

    private func getData(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("failed to decode \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.dateString = json.Date
                
                self.totalCasesLabel.text = json.Global.TotalConfirmed.withCommas()
                self.newCasesLabel.text = json.Global.NewConfirmed.withCommas()
                self.totalDeathsLabel.text = json.Global.TotalDeaths.withCommas()
                self.newDeathsLabel.text = json.Global.NewDeaths.withCommas()
                self.totalRecoveredLabel.text = json.Global.TotalRecovered.withCommas()
                self.newRecoveredLabel.text = json.Global.NewRecovered.withCommas()
                
                countryTotalCases = json.Countries[1].TotalConfirmed
            }
            
        }
        task.resume()
    }
    
}





struct CountryData: Codable {
    let Country: String
    let TotalConfirmed: Int
    let TotalDeaths: Int
}

struct GlobalData: Codable {
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
}
