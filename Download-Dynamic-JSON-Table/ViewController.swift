//
//  ViewController.swift
//  Download-Dynamic-JSON-Table
//
//  Created by Joy Paul on 11/24/18.
//  Copyright © 2018 Joy Paul. All rights reserved.
//

//In this exercise I will download Json from an api and insert them into a tableview using the default table view style
//Usings pods Alamofire, and SwiftyJSON
import UIKit
import Alamofire
import SwiftyJSON

//extends UITableView and DataSource
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //an array to hold the data from the api using ModelJson
    var jsonArray : [JsonModel] = [JsonModel]()
    
    @IBOutlet weak var dataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //the below two lines for tableView and dataSource
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        //below are couple of attributes you can modify within the table view
        dataTableView.rowHeight = 70//setting the cell height
        dataTableView.allowsSelection = false//diabling the 'onTap', good idea if no screen is hooked up
        dataTableView.separatorColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)//color of the cell separator
        //dataTableView.separatorStyle = .none to remove the lines
        //func to fetchData from the internet
        getData()
    }
    
    //the api we are downloading from
    var API_URL = "https://swapi.co/api/people"
    
    //func to download the json
    func getData(){
        Alamofire.request(API_URL, method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                let resultCount = JSON(response.result.value!)["results"].count
                print(resultCount)
                //for loop to append data to jsonarray as stringvalue
                for x in 0...resultCount-1{
                    let name = JSON(response.result.value!)["results"][x]["name"].stringValue
                    let mass = JSON(response.result.value!)["results"][x]["mass"].stringValue
                    let gender = JSON(response.result.value!)["results"][x]["gender"].stringValue
                    
                    //using the jsonModel class to set the values before appending
                    let data = JsonModel(name: name, mass: mass, gender: gender)
                    //using a func to print to console
                    self.printValues(name: data.name, mass: data.mass, gender: data.gender)
                    //appending data
                    self.jsonArray.append(data)
                    self.dataTableView.reloadData()//reload data after adding the data
                }
            }
            
            else{
                //consider displaying a popup box if this happens
                //or add some null values to jsonarray but that's very ghetto
                print("couldn't retrieve items")
            }
        }
    }
    
    //func that returns how many rows the tableView will have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    //func to return the data for the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! DataCell
        
        cell.name.text = jsonArray[indexPath.row].name
        cell.mass.text = jsonArray[indexPath.row].mass
        cell.gender.text = jsonArray[indexPath.row].gender
        
        return cell
    }
  
   //func to just print out the elements we downloaded
    func printValues(name: String, mass: String, gender : String){
        print(name, mass, gender)
    }
}

