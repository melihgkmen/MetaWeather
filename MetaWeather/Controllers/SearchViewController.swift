//
//  ViewController.swift
//  metaweatherAppCent
//
//  Created by Melih Gökmen on 27.01.2022.
//

import UIKit
import CoreData


protocol SearchCityDelegate {
    func userEnteredANewCityName(city: String)
}


class SearchViewController: UIViewController, LocationManagerDelegate,UITextFieldDelegate {
    func locationUpdated() {
        //        print("yo what it do\(locationManager.location)")
        //        print("\(searchTextField.text)")
        if let location = locationManager.location.first{
            
            if let text = self.searchTextField.text{
                
                let newResult = SearchResult(context: self.context)
                newResult.title = text
                newResult.woeid = Int64(location.woeid)
                newResult.timeStamp = getTimeStamp()
                newResult.type = location.location_type
                self.results.append(newResult)
                self.saveSearchResults()
            }
        }
        
    }
    
    func locationUpdateFailed() {
        
    }
    
    
    var delegate: SearchCityDelegate?
    
    let locationManager = LocationManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var results = [SearchResult]()
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.reloadData()
        loadSearchResults()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            goButtonPressed(self)
            return false
        }
        return true
    }
    
    func loadSearchResults() {
        //specify data type
        let request: NSFetchRequest<SearchResult> = SearchResult.fetchRequest()
        tableView.reloadData()
        fetchRequest(request: request)
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        let text = searchTextField.text
        if text != "" {
            locationManager.query = text
            locationManager.reloadData()
            locationManager.getWoeid()
            
            delegate?.userEnteredANewCityName(city: text!)
            self.navigationController?.popViewController(animated: true)
        }else{
            searchTextField.endEditing(true)
        }
    }
    
    func getTimeStamp() -> String {
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        // get the date time String from the date object
        return formatter.string(from: currentDateTime)
    }
    
    
    func saveSearchResults(){
        
        do{
            try context.save()
            
        }catch{
            print("error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    func fetchRequest(request: NSFetchRequest<SearchResult>){
        do {
            results = try context.fetch(request)
        } catch  {
            print("error \(error)")
        }
        
    }

}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultTableViewCell
        let city = results[indexPath.row]
        cell.cityLabel.text = "Name: \(city.title!)"
        cell.typeLabel.text = "Location Type: \(city.type!)"
        cell.woeidLabel.text = "WOEID: \(city.woeid)"
        cell.timeStampLabel.text = "Time: \(city.timeStamp!)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = results[indexPath.row].title else { return  }
        delegate?.userEnteredANewCityName(city: city)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
