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
    var bestCoreArray: [BestScoreModel] = []
    var cityDataArray: [CityModel] = []
    var areaListArray: [AreaList] = []
    
    func getDataFromFirestore(selectedCity city: String, selectedArea area: String, completion: @escaping([AreaDataModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        SingletonGameManager.shared.selectedAreaArray?.removeAll()
        areaDataArray.removeAll()
        print("\(city) , \(area)")
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
    
    func getCity(completion: @escaping([CityModel]) -> Void) {
         let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("CityList").addSnapshotListener { (snapshot, error) in
                 if error != nil {
                     print(error!)
                 } else {
                     if snapshot?.isEmpty != true && snapshot != nil {
                        self.cityDataArray.removeAll()
                         for document in snapshot!.documents {
                            
                            if let areaName = document.get("city") as? String, let areaLongitude = document.get("longitude") as? Double, let areaLatitude = document.get("latitude") as? Double{
                                let data = CityModel(city: areaName, latitude: areaLatitude, longitude: areaLongitude)
                                print(data)
                                self.cityDataArray.append(data)
                             }
                         }
                         DispatchQueue.main.async {
                             completion(self.cityDataArray)
                         }
                     }
                 }
             }
        }

    
    func getBestScore(completion: @escaping([BestScoreModel]) -> Void) {
         let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("BestScore").addSnapshotListener { (snapshot, error) in
                 if error != nil {
                     print(error!)
                 } else {
                     if snapshot?.isEmpty != true && snapshot != nil {
                        self.bestCoreArray.removeAll()
                         for document in snapshot!.documents {
                            if let areaName = document.get("area") as? String, let nickname = document.get("nickname") as? String, let point = document.get("point") as? Int{
                                 
                                let data = BestScoreModel(nickname: nickname, area: areaName, point: point)
                                self.bestCoreArray.append(data)
                             }
                         }
                         DispatchQueue.main.async {
                             completion(self.bestCoreArray)
                         }
                     }
                 }
             }
        }
    
    func setBestScore(nickname:String, areaName: String, point: Int, completion: @escaping(Bool) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        let docData: [String: Any] = [
            "nickname": nickname ,
            "area": areaName,
            "point": point,
        ]
        
        fireStoreDatabase.collection("BestScore").addDocument(data: docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            completion(true)
        }
    }
    
     func getArea(selectedCity city: String, completion: @escaping([AreaList]) -> Void) {
         let fireStoreDatabase = Firestore.firestore()
         SingletonGameManager.shared.selectedAreaArray?.removeAll()
         areaListArray.removeAll()
    fireStoreDatabase.collection(city).addSnapshotListener { (snapshot, error) in
             if error != nil {
                 print(error!)
             } else {
                 if snapshot?.isEmpty != true && snapshot != nil {
                     for document in snapshot!.documents {
//                        print(document.get("area") as? String)
//                        print(document.get("longitude") as? Double)
//                        print(document.get("latitude") as? Double)
                        
                        if let areaName = document.get("area") as? String , let areaLongitude = document.get("longitude") as? Double, let areaLatitude = document.get("latitude") as? Double{
                            self.areaListArray.append(AreaList(area: areaName, areaLatitude: areaLatitude, areaLongitude: areaLongitude))
                        }
                     }
                     DispatchQueue.main.async {
                        completion(self.areaListArray)
                     }
                 }
             }
         }
     }
    
}
