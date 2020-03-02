//
//  AreaController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import CLTypingLabel


class AreaController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textLabel: CLTypingLabel!
    
    var areaViewModel = AreaViewModel()
    var firestorm = FirestormManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationController()
        areaViewModel.setTableviewArea(selection: SingletonGameManager.shared.selectedCity!)
        textLabel.charInterval = 0.05
        textLabel.text = K.areaLabel
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaViewModel.areaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableSelectionCell" , for: indexPath) as! TableSelectionCell
        cell.backgroundColor = .clear
        cell.nameLabel.text = String(areaViewModel.areaArray[indexPath.row])
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LoadingView.show()
        SingletonGameManager.shared.selectedArea = areaViewModel.areaArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        firestorm.getDataFromFirestore(selectedCity: SingletonGameManager.shared.selectedCity!, selectedArea: SingletonGameManager.shared.selectedArea!) { (data) in
            self.areaViewModel.startGame(owner: self,data: data)
        }
    }
}

//MARK: - SetNavigationController

extension AreaController {
    func setNavigationController() {
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
    }
}
