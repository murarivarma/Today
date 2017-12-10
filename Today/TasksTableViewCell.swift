//
//  TasksTableViewCell.swift
//  Today
//
//  Created by Murari Varma on 05/12/17.
//  Copyright © 2017 Murari Varma. All rights reserved.
//

import UIKit

protocol TasksTableViewCellDelegate {
    func cellButtonTapped(cell: UITableViewCell, taskCompleted: Bool)
}

class TasksTableViewCell: UITableViewCell {
    
    var taskCompleted: Bool = false
    @IBOutlet weak var taskCompletedButton: UIButton!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    var delegate :TasksTableViewCellDelegate?
    
    @IBAction func taskCompletedButtonTouched(_ sender: UIButton) {
        print("BEFORE: \(taskCompleted)")
        if !taskCompleted  {
            taskCompletedButton.backgroundColor = UIColor.green
            taskCompleted = true
        } else {
            taskCompletedButton.backgroundColor = UIColor.red
            taskCompleted = false
        }
        print("AFTER: \(taskCompleted)")
        delegate?.cellButtonTapped(cell: self, taskCompleted: taskCompleted)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
