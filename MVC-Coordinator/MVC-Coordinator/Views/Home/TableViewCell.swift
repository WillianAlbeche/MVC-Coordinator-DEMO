//
//  TableViewCell.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    
    static let id:String = "MovieCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
