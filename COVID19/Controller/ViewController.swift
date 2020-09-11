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

    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var newCasesLabel: UILabel!
    @IBOutlet weak var newDeathsLabel: UILabel!
    @IBOutlet weak var newRecoveredLabel: UILabel!
//    @IBOutlet weak var learnMoreButton: UIButton!
   
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundViews.forEach({
            $0.layer.cornerRadius = 16.0
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.2
            $0.layer.shadowOffset = CGSize(width: 0, height: 1.5)
            $0.layer.shadowRadius = 4.0
        })
        
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
    
//    @IBAction func learnMoreButtonTapped(_ sender: UIButton) {
//        guard let url = URL(string: "https://www.coronavirus.gov/") else {
//            return
//        }
//        let vc = SFSafariViewController(url: url)
//        present(vc, animated: true)
//    }

}








