//
//  cellTableViewCell.swift
//  WorkOutForMuscles
//
//  Created by golanLeptop on 25/10/2017.
//  Copyright © 2017 golanLeptop. All rights reserved.
//

import UIKit

class cell: UITableViewCell {

    @IBOutlet weak var excersiceLabel: UILabel!
    @IBOutlet weak var muscleLabel: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    func configure(with excersice: EntityExcersice){
        excersiceLabel.text = excersice.name
        muscleLabel.text = excersice.muscle
        if let date = excersice.date{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yy"
            let myStringafd = formatter.string(from: date as Date)
            dateLable.text = myStringafd
        }
    }
    
}
