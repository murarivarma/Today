//
//  TasksTableViewCell.swift
//  Today
//
//  Created by Murari Varma on 05/12/17.
//  Copyright © 2017 Murari Varma. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    var taskCompleted: Bool?
    @IBOutlet weak var taskCompletedButton: UIButton!
    @IBOutlet weak var cellTextLabel: UILabel!
    @IBAction func taskCompletedButtonTouched(_ sender: UIButton) {
        if taskCompleted != nil, !taskCompleted! {
            taskCompletedButton.backgroundColor = UIColor.green
            taskCompleted = true
        } else {
            taskCompletedButton.backgroundColor = UIColor.red
            taskCompleted = false
        }
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
