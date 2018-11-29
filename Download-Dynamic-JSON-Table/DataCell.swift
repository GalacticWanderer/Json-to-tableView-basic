//this class extends UITableViewCell

import UIKit

//this class contains connections to the datacell attributes and is used to build cells
class DataCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var gender: UILabel!
    
}
