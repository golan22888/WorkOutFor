//
//  VideoViewController.swift
//  WorkOutForMuscles
//
//  Created by golanLeptop on 19/10/2017.
//  Copyright © 2017 golanLeptop. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoViewController: UIViewController, YTPlayerViewDelegate {
    var obj : Excersice?
    @IBOutlet weak var playerView: YTPlayerView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        loadingIndicator.stopAnimating()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
        navigationItem.rightBarButtonItem = shareButton
        
        addFeedbackButton()
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        self.playerView.delegate = self
        if let videoId = obj?.videoId{
            playerView.load(withVideoId: videoId)
        }
        navigationItem.title = obj?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func shareAction(){
        
        if let videoId: String = obj?.videoId{
        
            let controller = UIActivityViewController(activityItems: [videoId], applicationActivities: nil)
        
            self.present(controller, animated: true, completion: nil)
        }
    }
}
