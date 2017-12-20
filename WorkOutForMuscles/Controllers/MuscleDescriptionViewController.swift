//
//  MuscleDescriptionViewController.swift
//  WorkOutForMuscles
//
//  Created by golanLeptop on 19/10/2017.
//  Copyright © 2017 golanLeptop. All rights reserved.
//

import UIKit
import CoreData

class MuscleDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var muscle: Muscle?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addFeedbackButton()
        
        navigationItem.title = muscle?.name
        if let imgStr = muscle?.imageName{
        imageView.image = UIImage(named: (imgStr))
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let mus = muscle?.name else{
            return "no name"
        }
        return "best workouts for \(mus)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let n = muscle?.excersices.count else{
            return 0
        }
        return n
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = muscle?.excersices[indexPath.row].name
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let v = EntityExcersice(context:  DBManager.manager.persistentContainer.viewContext)
        
        v.date = NSDate()
        v.name = muscle?.excersices[indexPath.row].name
        v.video_id = muscle?.excersices[indexPath.row].videoId
        v.muscle = muscle?.name
     
        DBManager.manager.saveContext()
    }
 
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? VideoViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == "videoSegue"
        {
            let obj = muscle?.excersices[indexPath.row]
            nextVC.obj = obj
        }
    }
}
