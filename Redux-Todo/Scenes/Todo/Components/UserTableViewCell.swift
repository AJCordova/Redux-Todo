//
//  UserTableViewCell.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
