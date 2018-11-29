//this is the data model for the info we are downloading 
import Foundation

class JsonModel {
    var name : String
    var mass : String
    var gender : String
    
    init(name: String, mass: String, gender: String) {
        self.name = name
        self.mass = mass
        self.gender = gender
    }
}
