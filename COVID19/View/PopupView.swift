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
    
    let totalCasesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        // label.text = country
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
        addSubview(totalCasesLabel)
        totalCasesLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        totalCasesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        totalCasesLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12).isActive = true
        totalCasesLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func dismiss() {
        delegate?.dismiss()
    }

}
