//
//  InfoCell.swift
//  Echo
//
//  Created by Kasito on 22.09.2020.
//

import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet weak var chrLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    class var reuseIdentifier: String {
        return "infoCellID"
    }
}
