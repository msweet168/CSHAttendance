//
//  ViewController.swift
//  Attendance
//
//  Created by Mitchell Sweet on 2/23/17.
//  Copyright © 2017 Mitchell Sweet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var attendanceCounter:UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var theTableView: UITableView!
    
    var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewSetup()
        getDeafults()
    }
    
    
    @IBAction func doneTyping(sender: UITextField) {
        sender.resignFirstResponder()
        
        if let typed = sender.text {
            saveToArr(name: typed)
            sender.text = ""
        }
        
    }
    
    @IBAction func fuckGoBack(sender:AnyObject) {
        nameArray.removeAll()
        setDefaults()
        theTableView.reloadData()
    }
    
    
    func saveToArr(name: String) {
        
        
        nameArray.append(name)
        let index = IndexPath(row: nameArray.count-1, section: 0)
        theTableView.insertRows(at: [index], with: .right)
        print(nameArray.description)
        setDefaults()
        
        
    }
    
    func setDefaults() {
        UserDefaults.standard.set(nameArray, forKey: "savedNames")
        attendanceCounter.text = "\(nameArray.count)"
    }
    
    func getDeafults() {
        if let savedArray = UserDefaults.standard.array(forKey: "savedNames") {
            nameArray = savedArray as! [String]
            print("Found saved array")
        }
        else {
            setDefaults()
            print("No array found, setting blank to defaults")
        }
        attendanceCounter.text = "\(nameArray.count)"
    }
    
    
    func tableViewSetup() {
        self.theTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        theTableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        theTableView.rowHeight = 60
        theTableView.backgroundColor = UIColor.clear
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.theTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.nameArray[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 25)
        cell.textLabel?.textColor = UIColor.white
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            nameArray.remove(at: indexPath.row)
            theTableView.deleteRows(at: [indexPath], with: .automatic)
            setDefaults()
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

