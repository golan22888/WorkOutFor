//
//  HistoryViewController.swift
//  WorkOutForMuscles
//
//  Created by golanLeptop on 24/10/2017.
//  Copyright © 2017 golanLeptop. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {

    var tableArray: [EntityExcersice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "History"
        addFeedbackButton()
        tableArray = DBManager.manager.fetchExersices()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cell
        cell.configure(with: tableArray[indexPath.row])
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? VideoViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == "videoSegue"{
            
            let obj = tableArray[indexPath.row]
            let exc: Excersice = Excersice(obj)
            nextVC.obj = exc
        }
    }
}
