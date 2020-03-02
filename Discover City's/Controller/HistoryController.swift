//
//  HistoryController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Kingfisher
import CLTypingLabel
import Firebase

class HistoryController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var historyLabel: CLTypingLabel!
    
    var historyViewModel = HistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setNavigationController()
        historyLabel.charInterval = 0.03
        setOutlets()
    }
    
    func setOutlets() {
        let storage = Storage.storage()
        let gsReference = storage.reference(forURL: historyViewModel.getHistoryImage())
        
        gsReference.downloadURL { url, error in
            if error != nil {
                print(error!)
            } else {
                self.imageView.kf.setImage(with: url)
            }
        }
        historyLabel.text = historyViewModel.getHistoryLabel()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        historyViewModel.toQuestion(owner: self)
    }
    
}

//MARK: - SetNavigationController

extension HistoryController {
    func setNavigationController() {
        navigationItem.hidesBackButton = true
        
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
        if #available(iOS 13.0, *) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leaveGame))
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func leaveGame() {
        SingletonGameManager.shared.overTimer()
        let message = SingletonGameManager.shared.leaveGame(self)
        self.present(message, animated: true)
    }
}
