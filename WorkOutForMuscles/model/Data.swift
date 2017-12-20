//
//  Data.swift
//  WorkOutForMuscles
//
//  Created by golanLeptop on 19/10/2017.
//  Copyright © 2017 golanLeptop. All rights reserved.
//

import Foundation

class Muscle{
    let name: String
    let imageName: String
    let excersices: [Excersice]
    
    init(_ dict : Dictionary<String, Any>) {
        self.name = dict["name"] as? String ?? ""
        self.imageName = dict["image_name"] as? String ?? ""
        let arr =  dict["excs"] as? [Dictionary<String, Any>] ?? []
        self.excersices = arr.flatMap{Excersice($0)}
        
    }
    
    class func readData() ->[Muscle]{
        guard let path = Bundle.main.path(forResource: "data", ofType: "plist")else{
            print("file not found")
            return []
        }
        guard let rawArray = NSArray(contentsOfFile: path)else{
            print("file is not array")
            return []
        }
        let arr = rawArray as? [Dictionary<String, Any>] ?? []
        return arr.flatMap{Muscle($0)}
    }
}

class Excersice{
    let name: String
    let videoId: String

    init(_ dict : [String: Any]){
        self.name = dict["name"] as? String ?? ""
        self.videoId = dict["youtube_id"] as? String ?? ""
    }
    init(_ entity: EntityExcersice) {
        self.name = entity.name ?? ""
        self.videoId = entity.video_id ?? ""
        }
    }

