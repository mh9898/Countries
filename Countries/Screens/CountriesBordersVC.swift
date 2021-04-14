//
//  CountryCodeVC.swift
//  Countries
//
//  Created by MiciH on 4/13/21.
//

import UIKit

class CountriesBordersVC: UIViewController {
    
    var stackView = UIStackView()
    var countryBorderView = CTBorderItemView()
    var country: Country?
    var countriesBorders: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureStackView()
        configureStackViewLayout()
        addBordersToStackView()
    }
    
    func configureVC(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false
        title = "\(country?.name ?? "No") []"
        
        view.backgroundColor = .systemGray5
    }
    
    func configureStackView(){
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
    }
    
    func configureStackViewLayout(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
    func addBordersToStackView(){
        guard let countriesBorders = countriesBorders else {
            return
        }
        if countriesBorders.isEmpty{
            let borderView = CTBorderItemView()
            borderView.set(labelText: "Sorry, country has No Border, start swimming", color: .systemGray5)
            stackView.addArrangedSubview(borderView)
        }
        
        for border in countriesBorders{
            let borderView = CTBorderItemView()
            borderView.set(labelText: border)
            stackView.addArrangedSubview(borderView)
        }
    }
    
}
