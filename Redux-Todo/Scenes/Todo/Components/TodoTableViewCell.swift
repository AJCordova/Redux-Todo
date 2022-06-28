//
//  TodoTableViewCell.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/27/22.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var completedIndicator: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
