//
//  AddTaskViewController.swift
//  FarmerJ-AlbrechtR_Final
//
//  Created by Jordan Farmer on 12/11/20.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var ChosenDate: UIDatePicker!
    @IBOutlet weak var NotesText: UITextView!
    @IBOutlet weak var SaveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view
        
        //This gives the "Notes" text a border that looks like the "Title" text field
        self.NotesText.layer.borderColor = UIColor.lightGray.cgColor
        self.NotesText.layer.borderWidth = 0.5
        self.NotesText.layer.cornerRadius = 5
        
    }
}
