//
//  SecondViewController.swift
//  GCD
//
//  Created by Alexey Danilov on 9/28/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicatoView: UIActivityIndicatorView!
    
    private var imageUrl: URL?
    
    private var image: UIImage? {
        set {
            activityIndicatoView.stopAnimating()
            activityIndicatoView.isHidden = true
            imageView.image = newValue
            imageView.contentMode = .scaleAspectFill
            imageView.sizeToFit()
        }
        
        get {
            return imageView.image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()
    }
    
    private func fetchImage() {
        imageUrl = URL(string: "https://pixabay.com/get/52e4d4454d52ac14f6d1867dda6d49214b6ac3e45657784f712f7dd59f/eiffel-tower-4416700_1920.jpg")
        activityIndicatoView.isHidden = false
        activityIndicatoView.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [weak self] in
            guard let strongSelf = self else { return }
            guard let imageUrl = strongSelf.imageUrl,
                let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                strongSelf.image = UIImage(data: imageData)
            }
        }
    }
}
