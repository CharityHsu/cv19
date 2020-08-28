//
//  ViewController.swift
//  COVID19
//
//  Created by Charity Hsu on 8/18/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var newCasesLabel: UILabel!
    @IBOutlet weak var newDeathsLabel: UILabel!
    @IBOutlet weak var newRecoveredLabel: UILabel!
    @IBOutlet weak var learnMoreButton: UIButton!
   
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.cornerRadius = 10.0
        iconBackgroundView.layer.cornerRadius = 10.0
        learnMoreButton.layer.cornerRadius = 8.0
        
        Network.getData(from: Constants.url) { (result) in
            DispatchQueue.main.async {
                self.displayDateData(response: result)
                self.displayGlobalData(response: result)
            }
        }
    }
    
    // MARK: - Methods
    
    private func displayDateData(response: Response) {
        let dateFormatter = DateFormatter()
        let dateFormatterTwo = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSZ"
        
        dateFormatterTwo.locale = .current
        dateFormatterTwo.dateFormat = "MMMM d, yyyy"
        
        let dateString = response.Date
        let date = dateFormatter.date(from: dateString)
        titleLabel.text = dateFormatterTwo.string(from: date ?? Date())
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    private func displayGlobalData(response: Response) {
        totalCasesLabel.text = response.Global.TotalConfirmed.withCommas()
        newCasesLabel.text = response.Global.NewConfirmed.withCommas()
        totalDeathsLabel.text = response.Global.TotalDeaths.withCommas()
        newDeathsLabel.text = response.Global.NewDeaths.withCommas()
        totalRecoveredLabel.text = response.Global.TotalRecovered.withCommas()
        newRecoveredLabel.text = response.Global.NewRecovered.withCommas()
    }
    
    // MARK: - Actions
    
    @IBAction func learnMoreButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://www.coronavirus.gov/") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

}








