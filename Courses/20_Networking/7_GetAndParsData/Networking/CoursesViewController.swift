//
//  CoursesViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 06.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    private var courses: [Course] = []
    
    private var courseName: String?
    
    private var courseURL: String?

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    private func fetchData() {
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_course"
        
        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
        
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_website_description"
        
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_missing_or_wrong_fields"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                self?.courses = try jsonDecoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch let jsonError {
                print("Error serialization json: ", jsonError)
            }
        }
        
        dataTask.resume()
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.courseNameLabel.text = course.name
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessons.text = "Number of lessons: \(numberOfLessons)"
        }
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        
        DispatchQueue.global().async {
            guard let imageUrlString = course.imageUrl,
                let imageUrl = URL(string: imageUrlString) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imageData)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webViewController = segue.destination as? WebViewController {
            webViewController.selectedCourse = courseName
            
            if let url = courseURL {
                webViewController.courseURL = url
            }
        }
    }

}

// MARK: Table View Data Source

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
}

// MARK: Table View Delegate

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        courseName = course.name
        courseURL = course.link
        
        performSegue(withIdentifier: "Description",
                     sender: self)
    }
}

