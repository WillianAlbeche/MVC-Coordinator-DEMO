//
//  TableViewCellTitleDetails.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class TableViewCellTitleDetails: UITableViewCell {
    
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var ratingCell: UILabel!
    @IBOutlet weak var categoryCell: UILabel!
    @IBOutlet weak var titleCell: UILabel!
    
    static let id:String = "TitleMovieDetails"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCell.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
