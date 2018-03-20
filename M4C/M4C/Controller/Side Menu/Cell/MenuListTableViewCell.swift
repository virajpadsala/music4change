//
//  MenuListTableViewCell.swift
//  M4C
//
//  Created by Kalpesh Satasiya on 20/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var imgMenu: UIImageView!
    @IBOutlet var lblMenuname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
