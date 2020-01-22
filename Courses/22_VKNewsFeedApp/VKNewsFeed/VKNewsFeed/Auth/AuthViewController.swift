//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Alexey Danilov on 8/16/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    @IBAction func signInTapped(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AppDelegate.shared.authService
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
