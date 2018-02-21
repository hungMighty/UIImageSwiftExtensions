//
//  ViewController.swift
//  UIImageSwiftExtensions
//
//  Created by Giacomo Boccardo on 15/09/16.
//  Copyright © 2016 Giacomo Boccardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var myImageView: UIImageView!
    
    fileprivate let imageNames = ["Childhood World", "Android 21", "Ahri icon",
                                  "Jax", "Star Guardian Ahri", "Android 21 Big Portrait",
                                  "Candy Loli", "Couple Combo", "Female Joker"]
    
    fileprivate var isPortrait = true
    fileprivate var curIndex = 0
    fileprivate var curImage: UIImage?
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 30.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let orientation = UIApplication.shared.statusBarOrientation
        isPortrait = orientation == .portrait || orientation == .portraitUpsideDown
        loadImageAt(index: curIndex)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        isPortrait = UIDevice.current.orientation.isPortrait
        adjustContentMode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func touchLeftArrow(_ sender: Any) {
        loadImageAt(index: curIndex - 1)
    }
    
    @IBAction func touchRightArrow(_ sender: Any) {
        loadImageAt(index: curIndex + 1)
    }
    
}

// MARK: - Image Processing

extension ViewController {
    
    fileprivate func loadImageAt(index i: Int) {
        guard i >= 0 && i < imageNames.count else {
            return
        }
        
        curIndex = i
        if let image = UIImage(named: imageNames[i]) {
            curImage = image
            adjustContentMode()
            myImageView.image = image
        }
    }
    
    fileprivate func adjustContentMode() {
        guard let image = curImage else {
            return
        }
        var imageRatio = image.size.height / image.size.width
        if !isPortrait {
            imageRatio = image.size.width / image.size.height
        }
        
        // Image with same ratio as iPhone portrait
        if imageRatio >= 1.5 {
            myImageView.contentMode = .scaleAspectFill
        } else {
            myImageView.contentMode = .scaleAspectFit
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImageView
    }
    
}

