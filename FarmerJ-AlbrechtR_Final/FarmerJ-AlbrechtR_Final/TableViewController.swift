//
//  TableViewController.swift
//  FarmerJ-AlbrechtR_Final
//
//  Created by Jordan Farmer on 12/11/20.
//

import UIKit

class TableViewController: UIViewController {
    
    
    @IBOutlet var MainViewController: UITableView!
    @IBOutlet var theView: UIView!
    
    var containerView = UIView()
    var slideUpView = UITableView()
    var slideUpViewHeight: CGFloat = 200
   
    /*
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadView()
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 


        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TableViewController.longPress(longPressGestureRecognizer:)))
            self.view.addGestureRecognizer(longPressRecognizer)
        
        containerView.frame = theView.frame
        
        MainViewController.delegate = self
        MainViewController.dataSource = self
        StorageHandler.getStorage()
    }

 
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
                setupLongPressOverlay(tableIndex: indexPath.row)
                
                
            }
        }
    }
    
    func setupLongPressOverlay(tableIndex: Int){
        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        let screenSize = UIScreen.main.bounds.size
        slideUpView.frame = CGRect(x: 0, y: screenSize.height - (self.tabBarController?.tabBar.frame.size.height)!, width: screenSize.width, height: slideUpViewHeight)
        slideUpView.separatorStyle = .singleLine
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.containerView.alpha = 0.75
            self.slideUpView.frame = CGRect(x: 0, y: screenSize.height - self.slideUpViewHeight - (self.tabBarController?.tabBar.frame.size.height)!, width: screenSize.width, height:self.slideUpViewHeight)
        }, completion: nil)
        
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(slideUpViewTapped))
        containerView.addGestureRecognizer(tapGesture)
        

        MainViewController.addSubview(containerView)
        MainViewController.addSubview(slideUpView)
    }
    
    @objc func slideUpViewTapped() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.containerView.alpha = 0
            self.slideUpView.frame = CGRect(x: 0, y: screenSize.height -  (self.tabBarController?.tabBar.frame.size.height)!, width: screenSize.width, height:self.slideUpViewHeight)
        }, completion: nil)

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
