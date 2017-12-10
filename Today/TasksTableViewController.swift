//
//  TasksTableViewController.swift
//  Today
//
//  Created by Murari Varma on 05/12/17.
//  Copyright © 2017 Murari Varma. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController, TasksTableViewCellDelegate {
    
    var workTasks = [Task]()
    var personalTasks = [Task]()
    //var taskData: [String: [Task]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //get data from database
        getData()
        
        //reload the table view
        tableView.reloadData()
    }
    
    //Mark: - Get Tasks from CoreData
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        workTasks = []
        personalTasks = [] // To empty the array again
        
        do {
            let tasks:[Task] = try context.fetch(Task.fetchRequest())
            
            
            
            for t in tasks {
                if t.section == "Work" {
                    workTasks.append(t)
                }
                else if t.section == "Personal" {
                    personalTasks.append(t)
                }
            }
        } catch {
            print("Retrieving data failed")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //            return Array(taskData!)[section].key
        
        if section == 0 {
            return "Work"
        }
        else if section == 1 {
            return "Personal"
        } else {
            return ""
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //            return Array(taskData!)[section].value.count
        
        if section == 0 {
            return workTasks.count
        }
        else if section == 1 {
            return personalTasks.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TasksTableViewCell
        
        //cell.tag = indexPath.section // Assigning tag for cell as section value - to detect which section of the cell
        cell.delegate = self
        
        if indexPath.section == 0 {
            cell.cellTextLabel.text = workTasks[indexPath.row].taskText
            if workTasks[indexPath.row].isFinished  {
                cell.taskCompletedButton.backgroundColor = UIColor.green
            } else {
                cell.taskCompletedButton.backgroundColor = UIColor.red
            }
        }
        else if indexPath.section == 1 {
            cell.cellTextLabel.text = personalTasks[indexPath.row].taskText
            if personalTasks[indexPath.row].isFinished  {
                cell.taskCompletedButton.backgroundColor = UIColor.green
            } else {
                cell.taskCompletedButton.backgroundColor = UIColor.red
            }
        }
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            if indexPath.section == 0 {
                context.delete(workTasks[indexPath.row])
                workTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                context.delete(personalTasks[indexPath.row])
                personalTasks.remove(at: indexPath.row)
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //     else if editingStyle == .insert {
        //     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //     }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // Mark: - TableViewCell Delegate Cell
    
    func cellButtonTapped(cell: UITableViewCell, taskCompleted: Bool) {
        // update if task completed in coredata
        
        updateData(thecell: cell, isTaskComplete: taskCompleted)
    }
    
    func updateData(thecell: UITableViewCell, isTaskComplete: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let tableCellSection = tableView.indexPath(for: thecell)?.section
        let tableCellIndexPathRow = tableView.indexPath(for: thecell)?.row
        
        if tableCellSection! == 0 {
            let task = workTasks[tableCellIndexPathRow!]
            task.setValue(isTaskComplete, forKey: "isFinished")
            do {
                var tasks:[Task] = try managedObjectContext.fetch(Task.fetchRequest())
                let i = tasks.index(of: task)
                try managedObjectContext.save()
                tasks.remove(at: i!)
                tasks.insert(task, at: i!)
                print(tasks[i!])
                
                self.workTasks.remove(at: tableCellIndexPathRow!)
                self.workTasks.insert(task, at: tableCellIndexPathRow!)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } else if tableCellSection! == 1 {
            let task = personalTasks[tableCellIndexPathRow!]
            task.setValue(isTaskComplete, forKey: "isFinished")
            do {
                try managedObjectContext.save()
                self.personalTasks.remove(at: tableCellIndexPathRow!)
                self.personalTasks.insert(task, at: tableCellIndexPathRow!)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
