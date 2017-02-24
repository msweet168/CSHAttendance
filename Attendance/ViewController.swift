//
//  ViewController.swift
//  Attendance
//
//  Created by Mitchell Sweet on 2/23/17.
//  Copyright © 2017 Mitchell Sweet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets for the UI elements that we want to change with code.
    //We make these UI elements to we can ...
    @IBOutlet weak var attendanceCounter:UILabel! //Change the number
    @IBOutlet weak var textField: UITextField!//Get entered text and
    @IBOutlet weak var theTableView: UITableView!//Setup the table view.
    
    var nameArray = [String]() //This is an array which stores the names in the attendance list.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Runs the table view setup method.
        tableViewSetup()
        //Runs the getdefaults method to retreive saved data at app launch and set the array.
        getDeafults()
    }
    
    
    //This action is connected to the done button of the text field.
    @IBAction func doneTyping(sender: UITextField) {
        //Dismisses the keyboard.
        sender.resignFirstResponder()
        
        //Checks to make sure something is entered in the text field.
        if let typed = sender.text {
            //If there is, it appends it to the array
            saveToArr(name: typed)
            //and sets the text of the text field to nothing.
            sender.text = ""
        }
        
    }
    
    //This action is attached to the clear button.
    @IBAction func clearAll(sender:AnyObject) {
        //Removes all data from the array
        nameArray.removeAll()
        //Runs the set defaults method to update the array saved on the phone
        setDefaults()
        //Reloads the table view so it shows the info in the array.
        theTableView.reloadData()
    }
    
    
    //This function saves an entered name to the array of names.
    func saveToArr(name: String) {
        //Appends the name to the array
        nameArray.append(name)
        //Creates an index to add the name to in the table view.
        let index = IndexPath(row: nameArray.count-1, section: 0)
        //Adds the name to the table view and does a right animation.
        theTableView.insertRows(at: [index], with: .right)
        //Prints the array to the log.
        print(nameArray.description)
        //Sets defaults to save the updated array to the phone.
        setDefaults()
    }
    
    //This function saves the current state of the name array to the phone using user defaults and also updates the counter for the list.
    func setDefaults() {
        //Saves the array to defaults.
        UserDefaults.standard.set(nameArray, forKey: "savedNames")
        //Sets the counter to the current length of the array.
        attendanceCounter.text = "\(nameArray.count)"
    }
    
    //This function retreives the saved array from the user defaults.
    func getDeafults() {
        //Checks to make sure that there is something saved.
        if let savedArray = UserDefaults.standard.array(forKey: "savedNames") {
            //If there is something saved, the name array is set to it.
            nameArray = savedArray as! [String]
            //Prints to the log that an array was found.
            print("Found saved array")
        }
        else {
            //If there is nothing found, the current empty name array is set to the defaults by running setdefaults. This happens when the app is launched for the first time.
            setDefaults()
            //Prints to the log that no array was found and a blank array was saved to defaults.
            print("No array found, setting blank to defaults")
        }
        attendanceCounter.text = "\(nameArray.count)"
    }
    
    
    //This function does basic table view setup and is called in the view did load when the app loads up.
    func tableViewSetup() {
        
        //Creates the cell
        self.theTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //Sets the table's seperator colors.
        theTableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //Sets the row height of the table view to 60
        theTableView.rowHeight = 60
        //Sets the background of the table view to clear.
        theTableView.backgroundColor = UIColor.clear
        
    }
    
    //This table view function returns the number of rows that will be in the table view. It returns the length of the array because thats how long the table view will be.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //This table view function sets up the table view cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creates the cell object
        var cell:UITableViewCell = self.theTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        //Sets the type of cell
        cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        //Sets the text label of the cell
        cell.textLabel?.text = self.nameArray[indexPath.row]
        //Sets the background of the cells to clear.
        cell.backgroundColor = UIColor.clear
        //Sets the font of the text label in the cell to Avenir Next.
        cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 25)
        //Sets the text color of the cell to white.
        cell.textLabel?.textColor = UIColor.white
        
        //Returns the created cell.
        return cell
    }
    
    //This table view function sets the value to true for the user to be allowed to edit the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //This table view function sets the editing style of the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //If the user is trying to delete the cell...
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //Remove the value from the array
            nameArray.remove(at: indexPath.row)
            //delete the cell from the table view
            theTableView.deleteRows(at: [indexPath], with: .automatic)
            //update the defaults. 
            setDefaults()
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

