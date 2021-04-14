//
//  CountryCell.swift
//  Countries
//
//  Created by MiciH on 4/13/21.
//

import UIKit

class CountryCell: UITableViewCell {
    
    static let reuseID = "CountryCell"
    let countyName = CTTitleLabel(textAlignment: .left, fontSize: 18, weight: .bold, color: .label)
    let nativeName = CTTitleLabel(textAlignment: .left, fontSize: 16, weight: .regular, color: .secondaryLabel)
    let area = CTTitleLabel(textAlignment: .right, fontSize: 16, weight: .regular, color: .label)
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        UILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(country: Country){
        countyName.text = country.name
        nativeName.text = country.nativeName
        if let area = country.area{
            self.area.text = String(area)
        }
        else{
            area.text = "U/N"
        }
    }
    
    private func configure(){
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 20
        backgroundColor = .clear
        addSubview(countyName)
        addSubview(nativeName)
        addSubview(area)
        
    }
    
    private func UILayout(){
        
        let padding: CGFloat = 24
        
        NSLayoutConstraint.activate([
            
            countyName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            countyName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            countyName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            
            nativeName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            nativeName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nativeName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            
            area.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            area.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            area.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
        ])
    }
    
}
