//
//  ScoreBoardController.swift
//  DiscoverCity
//
//  Created by ferhan akkan on 4.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class ScoreBoardController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    let firestorm = FirestormManager()
    lazy var bestScoreArray : [BestScoreModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        title = "Best's Score Board"
        firestorm.getBestScore { (data) in
            self.bestScoreArray = data.sorted(by: { $0.point > $1.point })
            LoadingView.hide()
            self.tableView.reloadData()
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ScoreCell", bundle: nil), forCellReuseIdentifier: "ScoreCell")
    }
    

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 1
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        cell.nicknameLabel.text = bestScoreArray[indexPath.section].nickname
        cell.pointLabel.text = String(bestScoreArray[indexPath.section].point)
        cell.areaLabel.text = bestScoreArray[indexPath.section].area
        cell.cornerRadius = 20
        
        let myColor = UIColor.rouge
        
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = myColor.cgColor

        return cell
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return bestScoreArray.count
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
