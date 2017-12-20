//
//  ViewController.swift
//  WorkOutForMuscles
//
//  Created by golanLeptop on 16/10/2017.
//  Copyright © 2017 golanLeptop. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI


class MainViewController: UIViewController, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func rateAction(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        let appStoreAdress: String = "https://itunes.apple.com/us/app/visual-anatomy-lite/id523422151?mt=8"
                
                let controller = UIActivityViewController(activityItems: [appStoreAdress], applicationActivities: nil)
                
                self.present(controller, animated: true, completion: nil)
    }
    
    let muscleArray: [Muscle] = Muscle.readData()
    
    @IBAction func moveToExcersices(_ sender: UIButton) {
        performSegue(withIdentifier: "descSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Work Out"
        
        addFeedbackButton()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIButton else{
            return
        }
        
        let m : Muscle = muscleArray[button.tag]
        let nextVC = segue.destination as? MuscleDescriptionViewController
        nextVC?.muscle = m
    }
    
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
}

extension UIViewController{
    
    func addFeedbackButton(){
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_feedback"), style: .done, target: self, action: #selector(startFeedback))
        
        
        button.isEnabled = MFMailComposeViewController.canSendMail()
        
        var arr = navigationItem.rightBarButtonItems ?? []
        arr.append(button)
        navigationItem.rightBarButtonItems = arr
    }
    
    @objc func startFeedback(){
        
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = configuredMailComposeViewController()
            self.present(mailComposeViewController, animated: true, completion: nil)
        } 
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        if let screenCaptured = captureScreen() {
        if let imageDataToSend: Data = UIImagePNGRepresentation(screenCaptured) {
          
            mailComposerVC.addAttachmentData(imageDataToSend, mimeType: "image/png", fileName: "imageName")
        }
    }
        
        mailComposerVC.setToRecipients(["golanwork22888@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("\(UIDevice.current.name) \(UIDevice.current.model) \(UIDevice.current.systemVersion) \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "unknown Version")", isHTML: false)
        
        
        return mailComposerVC
    }
    
    func captureScreen() -> UIImage? {
        guard let context = UIGraphicsGetCurrentContext() else { return .none }
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    // MARK: MFMailComposeViewControllerDelegate Method
    @objc(mailComposeController:didFinishWithResult:error:) func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
    
    

