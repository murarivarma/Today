//
//  AddTaskViewController.swift
//  Today
//
//  Created by Murari Varma on 05/12/17.
//  Copyright © 2017 Murari Varma. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var sectionClicked = "Work"
    
    @IBOutlet weak var workSection: UIButton!
    @IBOutlet weak var personalSection: UIButton!
    @IBOutlet weak var addTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        workSection.layer.borderColor = UIColor.black.cgColor
        workSection.layer.borderWidth = 2.0
        personalSection.layer.borderWidth = 2.0
        personalSection.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sectionSelected(_ sender: UIButton) {
        if sender.titleLabel?.text == "Work" {
            sectionClicked = "Work"
            workSection.layer.borderColor = UIColor.black.cgColor
            personalSection.layer.borderColor = UIColor.clear.cgColor
        } else if sender.titleLabel?.text == "Personal" {
            sectionClicked = "Personal"
            personalSection.layer.borderColor = UIColor.black.cgColor
            workSection.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        
        if addTaskTextField.text != nil {
            
            sender.layer.borderColor = UIColor.black.cgColor
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let task = Task(context: context)
            
            task.taskText = addTaskTextField.text
            task.isFinished = false
            task.section = sectionClicked
            
            //save data to coredata
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
            
        } 
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
