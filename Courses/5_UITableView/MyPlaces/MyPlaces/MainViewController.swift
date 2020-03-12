//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Alexey Danilov on 11/5/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let places = Place.getPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]
        
        cell.nameLabel?.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlaceImageView?.image = UIImage(named: place.image)
        cell.imageOfPlaceImageView?.layer.cornerRadius = cell.imageOfPlaceImageView.frame.size.height / 2
        cell.imageOfPlaceImageView?.clipsToBounds = true
        
        return cell
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) { }
    
    // MARK: - Table View Delegate
}
