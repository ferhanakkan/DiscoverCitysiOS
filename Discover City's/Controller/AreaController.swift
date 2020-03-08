//
//  AreaController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class AreaController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textLabel: UILabel!
    
    var areaViewModel = AreaViewModel()
    var firestorm = FirestormManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firestorm.getArea(selectedCity: SingletonGameManager.shared.selectedCity!) { (data) in
            self.areaViewModel.areaArray = data
            LoadingView.hide()
            self.tableView.reloadData()
        }

        
        
        setTableView()
        setNavigationController()
        textLabel.setTextWithTypeAnimation(typedText: K.areaLabel, characterDelay:  5)
        tableView.register(UINib(nibName: "TableSelectionCell", bundle: nil), forCellReuseIdentifier: "TableSelectionCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LoadingView.hide()
    }
}

//MARK: - TableViewDelegate

extension AreaController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableSelectionCell" , for: indexPath) as! TableSelectionCell
        cell.backgroundColor = .clear
        cell.nameLabel.text = areaViewModel.areaArray[indexPath.section].area
        cell.distanceLabel.text = areaViewModel.getDistance(indexpath: indexPath.section)
        cell.cornerRadius = 20
        let myColor = UIColor.rouge
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = myColor.cgColor
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LoadingView.show()
        SingletonGameManager.shared.selectedArea = areaViewModel.areaArray[indexPath.section].area 
        tableView.deselectRow(at: indexPath, animated: true)
        
        firestorm.getDataFromFirestore(selectedCity: SingletonGameManager.shared.selectedCity!, selectedArea: SingletonGameManager.shared.selectedArea!) { (data) in
            self.areaViewModel.startGame(owner: self,data: data)
        }
        
    }
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          return 1
      }

    
      func numberOfSections(in tableView: UITableView) -> Int {
        return areaViewModel.areaArray.count
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

//MARK: - SetNavigationController

extension AreaController {
    func setNavigationController() {
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
    }
}
