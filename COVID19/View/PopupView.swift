//
//  PopupView.swift
//  COVID19
//
//  Created by Charity Hsu on 8/26/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import UIKit

protocol PopupDelegate {
    func dismiss()
}

class PopupView: UIView {

    // MARK: - Properties
    
    var delegate: PopupDelegate?
    
    var country: String = ""
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "test"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalCasesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalDeathsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newCasesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newDeathsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
        addSubview(countryLabel)
        countryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        
        addSubview(totalCasesLabel)
        totalCasesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        totalCasesLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 30).isActive = true
        
        addSubview(totalDeathsLabel)
        totalDeathsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        totalDeathsLabel.topAnchor.constraint(equalTo: totalCasesLabel.bottomAnchor, constant: 12).isActive = true
        
        addSubview(newCasesLabel)
        newCasesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        newCasesLabel.topAnchor.constraint(equalTo: totalDeathsLabel.bottomAnchor, constant: 30).isActive = true
        
        addSubview(newDeathsLabel)
        newDeathsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        newDeathsLabel.topAnchor.constraint(equalTo: newCasesLabel.bottomAnchor, constant: 12).isActive = true
        
        
       
    }
    
    // MARK: - Selectors
    
    @objc func dismiss() {
        delegate?.dismiss()
    }

}
