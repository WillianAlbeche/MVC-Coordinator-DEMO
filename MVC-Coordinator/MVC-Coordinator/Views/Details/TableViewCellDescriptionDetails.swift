//
//  TableViewCellDescriptionDetails.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class TableViewCellDescriptionDetails: UITableViewCell {
    
    
    @IBOutlet weak var resumeCell: UILabel!
    
    
    static let id:String = "ResumeCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
