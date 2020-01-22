//
//  MainViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 11.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import UserNotifications

enum Actions: String, CaseIterable {
    
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case ourCourses = "Our Courses"
    case uploadImage = "Upload Image"
    case downloadFile = "Download File"
}

private let reuseIdentifier = "Cell"
private let url = "https://jsonplaceholder.typicode.com/posts"
private let uploadImage = "https://api.imgur.com/3/image"

class MainViewController: UICollectionViewController {
    
    let actions = Actions.allCases
    
    private var alert: UIAlertController!
    
    private let dataProvider = DataProvider()
    
    private var filePath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        
        dataProvider.fileLocation = { [weak self] location in
            guard let self = self else { return }
            self.filePath = location.absoluteString
            self.alert.dismiss(animated: true,
                               completion: nil)
            self.postNotification()
        }
    }
    
    private func showAler() {
        alert = UIAlertController(title: "Downloading...",
                                  message: "0%",
                                  preferredStyle: .alert)
        
        let height = NSLayoutConstraint(item: alert.view,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0,
                                        constant: 170)
        height.isActive = true
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive,
                                         handler: { [weak self] action in
                                            guard let self = self else { return }
                                            self.dataProvider.stopDownload()
        })
        alert.addAction(cancelAction)
        present(alert,
                animated: true) { [weak self] in
                    guard let self = self else { return }
                    
                    let size = CGSize(width: 40,
                                      height: 40)
                    let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2,
                                        y: self.alert.view.frame.height / 2 - size.height / 2)
                    let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: point,
                                                                                  size: size))
                    activityIndicator.color = .gray
                    activityIndicator.startAnimating()
                    
                    let progressView = UIProgressView(frame: CGRect(x: 0,
                                                                   y: self.alert.view.frame.height - 44,
                                                                   width: self.alert.view.frame.width,
                                                                   height: 2))
                    progressView.tintColor = .blue
            
                    self.dataProvider.onProgress = { [weak self] progressValue in
                        guard let self = self else { return }
                        progressView.progress = Float(progressValue)
                        self.alert.message = String(Int(progressValue * 100)) + "%"
                    }
                    
                    self.alert.view.addSubview(activityIndicator)
                    self.alert.view.addSubview(progressView)
        }
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        cell.label.text = actions[indexPath.row].rawValue
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .get:
            NetworkManager.getRequest(url: url)
        case .post:
            NetworkManager.postRequest(url: url)
        case .ourCourses:
            performSegue(withIdentifier: "OurCourses", sender: self)
        case .uploadImage:
            NetworkManager.uploadImage(url: uploadImage)
        case .downloadFile:
            showAler()
            dataProvider.startDownload()
        }
    }

}

extension MainViewController {
    
    private func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in
            // nothing
        }
    }
    
    private func postNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Download complete!"
        content.body = "Your background transfer has completed. File path: \(filePath!)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3,
                                                        repeats: false)
        
        let request = UNNotificationRequest(identifier: "Transfer Complete",
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request,
                                               withCompletionHandler: nil)
        
    }
}
