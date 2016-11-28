//
//  AudioViewController.swift
//  SwiftSpotyfy
//
//  Created by Marcelo Sampaio on 11/28/16.
//  Copyright © 2016 Marcelo Sampaio. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {

    // Working Variables
    var image = UIImage()
    var mainSongTitle = String()
    
    // Outlets
    
    @IBOutlet var background: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var songTitle: UILabel!
    
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up UI
        songTitle.text = mainSongTitle

        background.image=image
        mainImageView.image=image
        
        
    }

    
    
    

}
