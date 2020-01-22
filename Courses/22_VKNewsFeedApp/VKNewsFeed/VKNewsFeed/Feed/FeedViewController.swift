//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Alexey Danilov on 8/16/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        networkService.getFeed()
        
    }

}
