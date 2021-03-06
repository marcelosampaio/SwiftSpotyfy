//
//  AudioViewController.swift
//  SwiftSpotyfy
//
//  Created by Marcelo Sampaio on 11/28/16.
//  Copyright © 2016 Marcelo Sampaio. All rights reserved.
//

import UIKit
import AVFoundation



class AudioViewController: UIViewController {

    // Working Variables
    var image = UIImage()
    var mainSongTitle = String()
    var previewURL = String()
    
    // Outlets
    
    @IBOutlet var background: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var playAndPauseButton: UIButton!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up UI
        songTitle.text = mainSongTitle

        background.image=image
        mainImageView.image=image
        
        // play music preview
        self.downloadFileFromURL(url: URL(string: previewURL)!)
        
        
        
    }
    
    
    // MARK: - Music Preview
    
    private func downloadFileFromURL(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (customURL, response, error) in
            self.play(url: customURL!)
        })
        
        downloadTask.resume()
    }
    
    
    private func play(url: URL) {
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            playerIsRunning = true
        }
        catch{
            print(error)
        }
        
    }

    // MARK: UI Action
    @IBAction func playAndPause(_ sender: Any) {
        if player.isPlaying{
            player.pause()
            playerIsRunning=false
            playAndPauseButton.setTitle("Play", for: UIControlState.normal)
        }else{
            // play music preview
            player.play()
            playerIsRunning=true
            playAndPauseButton.setTitle("Pause", for: UIControlState.normal)
            
        }
    }
    
    
    

}
