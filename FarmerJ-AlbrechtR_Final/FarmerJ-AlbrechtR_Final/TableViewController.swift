//
//  TableViewController.swift
//  FarmerJ-AlbrechtR_Final
//
//  Created by Jordan Farmer on 12/11/20.
//

import UIKit

class TableViewController: UIViewController {
    
    //private let reuseIdentifier = "TaskCell"
    
    @IBOutlet var MainViewController: UITableView!
    
   /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadView()
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        MainViewController.delegate = self
        MainViewController.dataSource = self
        StorageHandler.getStorage()

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TableViewController.longPress(longPressGestureRecognizer:)))
            self.view.addGestureRecognizer(longPressRecognizer)
    }
    

    
    var containerView = UIView()
    var slideUpView = UITableView()
    let slideUpViewHeight: CGFloat = 200
 
    //var currentlySelectedTask: IndexPath = []
    
    
    /*let slideUpViewDataSource: [Int: (String)] = [
        0: ("Delete Task"),
        1: ("Edit Task"),
        3: ("View Task Details")
    ]
 */

}

extension TableViewController: UITableViewDelegate{
    
}

extension TableViewController{
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = MainViewController.indexPathForRow(at: touchPoint) {
                print("Long Press Detected")
            }
        }
    }

}


extension TableViewController: UITableViewDataSource{
    
    //How many rows do we need?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageHandler.storageCount()
    }
    
    //Populating the table cells with title and date of the task
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellTasksArray = TaskManager.taskCollection
        let cellTaskArray = cellTasksArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        cell.textLabel!.text = cellTaskArray.title

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let dateString = dateFormatter.string(from: cellTaskArray.date)

        cell.detailTextLabel!.text = dateString
        
    
        
        return cell
    }
    
   
    
}
