//
//  Firestorm.swift
//  DiscoverCity
//
//  Created by Ferhan Akkan on 21.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//


import Firebase
import Kingfisher


class FirestormManager {

    var areaDataArray: [AreaDataModel] = []
    
    func getDataFromFirestore(selectedCity city: String, selectedArea area: String, completion: @escaping([AreaDataModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        SingletonGameManager.shared.selectedAreaArray?.removeAll()
        areaDataArray.removeAll()
   fireStoreDatabase.collection(city).document(area).collection("Area").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.areaDataArray.removeAll()
                    for document in snapshot!.documents {
                        
                        if let areaName = document.get("areaName") as? String, let areaHistory = document.get("areaHistory") as? String, let areaQuestion = document.get("areaQuestion") as? String, let areaAnswer = document.get("areaAnswer") as? String , let areaAnswerA = document.get("areaAnswerA") as? String, let areaAnswerB = document.get("areaAnswerB") as? String, let areaAnswerC = document.get("areaAnswerC") as? String, let areaAnswerD = document.get("areaAnswerD") as? String, let imageUrl = document.get("areaImage") as? String {
                            
                            if let areaLatitude = document.get("areaLatitude") as? Double, let areaLongitude = document.get("areaLongitude") as? Double {
                                if let point = document.get("point") as? Int {
                                    
                                    let data = AreaDataModel(areaName: areaName, areaLatitude: areaLatitude, areaLongitude: areaLongitude, areaPhoto: imageUrl, areaHistory: areaHistory, areaQuesiton: areaQuestion, areaAnswerA: areaAnswerA, areaAnswerB: areaAnswerB, areaAnswerC: areaAnswerC, areaAnswerD: areaAnswerD, areaAnswer: areaAnswer, point: point)
                                    
                                    self.areaDataArray.append(data)

                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        completion(self.areaDataArray)
                    }
                }
            }
        }
    }
    
}
