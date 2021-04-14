//
//  CTBoderItemView.swift
//  Countries
//
//  Created by MiciH on 4/14/21.
//

import UIKit

//Border

class CTBorderItemView: UIView {

    let countryBorderLabel = CTTitleLabel(textAlignment: .center, fontSize: 14, weight: .light, color: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        self.backgroundColor = .systemBackground
        layer.cornerRadius = 20
        addSubview(countryBorderLabel)
    }
    
    func configureLayout(){
        NSLayoutConstraint.activate([
            countryBorderLabel.topAnchor.constraint(equalTo: self.topAnchor),
            countryBorderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countryBorderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countryBorderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func set(labelText: String, color: UIColor = .systemBackground){
        countryBorderLabel.text = labelText
        backgroundColor = color
    }
    
}
