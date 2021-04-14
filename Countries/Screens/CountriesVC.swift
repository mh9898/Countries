//
//  ViewController.swift
//  Countries
//
//  Created by MiciH on 4/13/21.
//

import UIKit

class CountriesVC: UIViewController {
    
    let navTitle = "Countries"
    var tableView = UITableView()
    var countries: [Country] = []
    var segmentedControlItem: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestCountries()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        tableViewLayout()
        configureSegmentedControl()
    }
    
    func configureVC(){
        view.backgroundColor = .systemBackground
        title = navTitle
        view.addSubview(tableView)
    }
    
    func configureTableView(){
        tableView.backgroundColor = .systemGray5
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
        tableView.separatorStyle = .none
       
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func tableViewLayout(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
        ])
    }
    
    func configureSegmentedControl(){
        let items = ["A-Z", "Z-A", "S-L", "L-S"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChange(_:)), for: .valueChanged)
        
        view.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 60),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func segmentedControlChange(_ segmentedControl: UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            //A-Z
            segmentedControlItem = 0
            countries.sort{ $0.name.localizedCompare($1.name) == .orderedAscending }
            reloadTableViewOnMain()
        case 1:
            //Z-A
            segmentedControlItem = 1
            countries.sort{ $0.name.localizedCompare($1.name) == .orderedDescending }
            reloadTableViewOnMain()
        case 2:
            //S-L
            segmentedControlItem = 2
            countries.sort{ ($0.area ?? 0) < ($1.area ?? 0) }
            reloadTableViewOnMain()
        case 3:
            //L-S
            segmentedControlItem = 3
            countries.sort{ ($0.area ?? 0) > ($1.area ?? 0) }
            reloadTableViewOnMain()
        default:
            //A-Z
            segmentedControlItem = 0
            countries.sort{ $0.name.localizedCompare($1.name) == .orderedAscending }
            reloadTableViewOnMain()
        }
    }
    
    func reloadTableViewOnMain(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
//            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    func requestCountries(){
        NetworkManager.shard.getCountries { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result{
            case .success(let countries):
                if countries.isEmpty{
                    print("no countries")
                }else{
                    self.countries = countries
                    self.configureSegmentedControlItem()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureSegmentedControlItem(){
        switch segmentedControlItem {
        case 0:
            //A-Z
            countries.sort{ $0.name < $1.name }
            reloadTableViewOnMain()
        case 1:
            //Z-A
            segmentedControlItem = 1
            countries.sort{ $0.name > $1.name }
            reloadTableViewOnMain()
        case 2:
            //S-L
            segmentedControlItem = 2
            countries.sort{ ($0.area ?? 0) < ($1.area ?? 0) }
            reloadTableViewOnMain()
        case 3:
            //L-S
            segmentedControlItem = 3
            countries.sort{ ($0.area ?? 0) > ($1.area ?? 0) }
            reloadTableViewOnMain()
        default:
            //A-Z
            countries.sort{ $0.name < $1.name }
            reloadTableViewOnMain()
        }
    }
    
    func searchCountryFromBorders(alpha3CodeSearch: String) -> String{
        var dictCountryNameBordersName: [String: String] = [:]
        var dictCountryNameNativeBordersName: [String: String] = [:]
    
        for country in countries{
            dictCountryNameBordersName[country.alpha3Code] = country.name
            dictCountryNameNativeBordersName[country.alpha3Code] = country.nativeName
        }
        
        let countryBorderName = dictCountryNameBordersName[alpha3CodeSearch] ?? "No Country Name"
        
        let nativeBorderName = dictCountryNameNativeBordersName[alpha3CodeSearch] ?? "No Native Country Name"
        
        return "\(countryBorderName) : \(nativeBorderName)"
    }

}

extension CountriesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseID) as! CountryCell
        
        let country = countries[indexPath.row]
        cell.set(country: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let country = countries[indexPath.row]
        
        var countriesBordersCode = [String]()
        for countryCode in country.borders{
            countriesBordersCode.append(searchCountryFromBorders(alpha3CodeSearch: countryCode))
        }
    
        let destVC = CountriesBordersVC()
        destVC.country = country
        destVC.countriesBorders = countriesBordersCode
        
        navigationController?.pushViewController(destVC, animated: true)
    }
}

extension Collection where Element: StringProtocol {
    public func localizedSorted(_ result: ComparisonResult) -> [Element] {
        sorted { $0.localizedCompare($1) == result }
    }
    public func caseInsensitiveSorted(_ result: ComparisonResult) -> [Element] {
        sorted { $0.caseInsensitiveCompare($1) == result }
    }
    public func localizedCaseInsensitiveSorted(_ result: ComparisonResult) -> [Element] {
        sorted { $0.localizedCaseInsensitiveCompare($1) == result }
    }
    /// This method should be used whenever file names or other strings are presented in lists and tables where Finder-like sorting is appropriate. The exact sorting behavior of this method is different under different locales and may be changed in future releases. This method uses the current locale.
    public func localizedStandardSorted(_ result: ComparisonResult) -> [Element] {
        sorted { $0.localizedStandardCompare($1) == result }
    }
}

