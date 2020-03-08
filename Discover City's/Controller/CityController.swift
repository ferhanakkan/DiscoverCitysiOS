//
//  WelcomeController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import CoreLocation

class CityController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var cityViewModel = CityViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        cityViewModel.setCity { (bool) in
            LoadingView.hide()
            self.tableView.reloadData()
        }
       textLabel.setTextWithTypeAnimation(typedText: K.cityLabel, characterDelay:  5)
        setNavigationController()
        
        tableView.register(UINib(nibName: "TableSelectionCell", bundle: nil), forCellReuseIdentifier: "TableSelectionCell")
    }
    
    func setNavigationController() {
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
    }
}
//MARK: - TableViewDelegate

extension CityController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SingletonGameManager.shared.setSelectedCity(selectedCity: cityViewModel.cityModel[indexPath.section].city)
        tableView.deselectRow(at: indexPath, animated: true)
        if let toArea = Bundle.main.loadNibNamed(K.area, owner: self, options: nil)?.first as? AreaController {
            LoadingView.show()
            self.navigationController?.show(toArea, sender: nil)
        }
    }
    

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          return 1
      }

      
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableSelectionCell" , for: indexPath) as! TableSelectionCell
        cell.backgroundColor = .clear
        cell.nameLabel.text = cityViewModel.cityModel[indexPath.section].city
        cell.distanceLabel.text = cityViewModel.getDistance(indexpath: indexPath.section)
        cell.cornerRadius = 20
        
        let myColor = UIColor.rouge
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = myColor.cgColor
        
        return cell
      }
    
      func numberOfSections(in tableView: UITableView) -> Int {
        return cityViewModel.cityModel.count
       }

       // Set the spacing between sections
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 7
       }
      
      // Make the background color show through
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let headerView = UIView()
          headerView.backgroundColor = UIColor.clear
          return headerView
      }
    
}
        


