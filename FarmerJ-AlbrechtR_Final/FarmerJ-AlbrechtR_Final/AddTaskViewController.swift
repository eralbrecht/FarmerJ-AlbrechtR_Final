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
    
    var activeTextField: UITextField? = nil
    
    var activeTextView: UITextView? = nil
    
    @IBAction func clickSave(_ sender: Any) {

        let thisTitle = TitleText.text ?? ""
        let thisDate = ChosenDate.date
        let thisNotes = NotesText.text ?? ""
        let thisTask = Task(title: thisTitle, date: thisDate, notes: thisNotes)
        StorageHandler.set(value: thisTask)
        for (key, value) in UserDefaults.standard.dictionaryRepresentation(){
            print("\(key) = \(value) \n")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view
        //This gives the "Notes" text a border that looks like the "Title" text field
        self.NotesText.layer.borderColor = UIColor.lightGray.cgColor
        self.NotesText.layer.borderWidth = 0.5
        self.NotesText.layer.cornerRadius = 5
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddTaskViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddTaskViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddTaskViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        TitleText.delegate = self
        NotesText.delegate = self
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

          guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {

            // if keyboard size is not available for some reason, dont do anything
            return
          }

          var shouldMoveViewUp = false

          // if active text field is not nil

    
        if let activeTextView = activeTextView {
            
            let bottomOfTextView = activeTextView.convert(activeTextView.bounds, to: self.view).maxX
    
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            // if the bottom of textView is below the top of keyboard, move up
            
            if bottomOfTextView > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if let activeTextField = activeTextField {

            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
              shouldMoveViewUp = true
            }
          }

          if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
          }
        }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    @objc func didTapView() {
        self.view.endEditing(true)
    }
}

extension AddTaskViewController : UITextFieldDelegate {
  // when user select a textfield, this method will be called
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // set the activeTextField to the selected textfield
    self.activeTextField = textField
  }
    
  // when user click 'done' or dismiss the keyboard
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.activeTextField = nil
  }
}

extension AddTaskViewController: UITextViewDelegate {
    // when user selects a textview, this method will be called
    func textViewDidBeginEditing(_ textView: UITextView) {
        //set the activeTextView to the selected textView
        self.activeTextView = textView
    }
    
    //when user clicks 'done' or dismisses the keyboard
    func textViewDidEndEditing(_ textView: UITextView) {
        self.activeTextView = nil
    }
}
