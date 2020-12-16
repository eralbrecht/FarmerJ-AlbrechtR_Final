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

extension TableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageHandler.storageCount()
    }
    
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
