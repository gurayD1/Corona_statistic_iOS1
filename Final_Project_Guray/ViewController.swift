//
//  ViewController.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-12.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableOutlet: UITableView!
    @IBOutlet weak var date_picker: UIDatePicker!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    var resultForCountry : [Country2] = [Country2]();
    
    var countryList : [Country] = [Country]()
    var countryList2 : [Country3] = [Country3]()
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let num = countryList2.firstIndex(where: {$0.country.localizedCaseInsensitiveContains(searchText)})
        if (num != nil){
            countryPicker.selectRow(num!, inComponent: 0, animated: true)
            
            let countryName : String = countryList2[num!].countryInfo.iso2!;
            
            getInformation( country_name : countryName)
            
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellForhistoricalDataTableViewCell
            if(resultForCountry.count > 1){
                cell.label1?.text = String(resultForCountry[resultForCountry.count-1].Confirmed);
                cell.label2?.text = String(resultForCountry[resultForCountry.count-1].Deaths);}
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellForhistoricalDataTableViewCell
            
            if(resultForCountry.count > 1){
                cell.label1?.text = String(resultForCountry[0].Recovered);
                cell.label2?.text = String(resultForCountry[0].Active);}
            
            return cell
            
            // 1.20 dk
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        if (section == 0){
            return "Confirm and Deaths"
            
        }else{
            return "Recovered and Active"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        
        headerText.textAlignment = .center
        if(section == 0){
            headerText.text = "Confirm and Deaths"}
        if(section == 1){
            headerText.text = "Recovered and Active"}
        
        return headerText
    }
    
    // picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //  return countryList.count // 2//result.countries.count;
        return countryList2.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //let title =  countryList[row].Country;
        let title =  countryList2[row].country;
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // let countryName : String = countryList[row].Slug;
        let countryName : String = countryList2[row].countryInfo.iso2!;
        
        
        getInformation( country_name : countryName)
        
    }
    func setCountries()  {
        NetworkService.Shared.getAllCountries() {result in
            switch result{
            case .success(let countryCollection):
                self.countryList = countryCollection
                DispatchQueue.main.async {
                    self.countryPicker.reloadAllComponents()
                    
                }
                break
            case.failure(let error):
                print(error)
                
                break
            }
        }
    }
    
    func setCountries2()  {
        NetworkService.Shared.getSecondCountryList() {result in
            switch result{
            case .success(let countryCollection):
                self.countryList2 = countryCollection
                DispatchQueue.main.async {
                    self.countryPicker.reloadAllComponents()
                    
                }
                break
            case.failure(let error):
                print(error)
                
                break
            }
        }
    }
    
    func getInformation( country_name : String)  {
        let days : [String] = getDays()
        
        NetworkService.Shared.getDataForCountry(countryName: country_name, previousDate : days[0], selectedDate : days[1] ) {result in
            switch result{
            case .success(let countryCollection):
                print(countryCollection)
                self.resultForCountry = countryCollection
                // print(countryCollection)
                DispatchQueue.main.async {
                    self.tableOutlet.reloadData()
                }
                break
            case.failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getDays()-> [String]{
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dataFormatter.string(from: date_picker.date)
        
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: date_picker.date)!
        
        let previousDay = dataFormatter.string(from: modifiedDate)
        
        let days :[String] = [previousDay, selectedDate]
        // print(date_picker.date)
        return days;
    }
    
    @objc func datePickerValueChanged(picker: UIDatePicker)  {
        let todayDate = Date();
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        let yy = dateFormatter.string(from: todayDate);
        
        if(todayDate < date_picker.date){
            date_picker.setDate(todayDate, animated: true)
        }
        let indexNumber : Int = countryPicker.selectedRow(inComponent: 0)
        
        //  let countryName : String = countryList[indexNumber].Slug;
        let countryName : String = countryList2[indexNumber].countryInfo.iso2!;
        
        getInformation( country_name : countryName)
        
    }
    
    
    @IBAction func saveToFavourite(_ sender: Any) {
        let alert = UIAlertController.init(title: "Are You Sure", message: "Do you want to save this country", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "save", style: .default, handler: { action in
            CoreDataService.shared.insertCounrtyInCoreData(myCountry: self.countryList2[self.countryPicker.selectedRow(inComponent: 0)].country , myFlag: self.countryList2[self.countryPicker.selectedRow(inComponent: 0)].countryInfo.flag , myIso2: self.countryList2[self.countryPicker.selectedRow(inComponent: 0)].countryInfo.iso2!, myPopulation: Int32(self.countryList2[self.countryPicker.selectedRow(inComponent: 0)].population) )
            
            CoreDataService.shared.getAllCounrtyFromStorage()
            
        }))
        
        present(alert, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date_picker.addTarget(self, action: #selector(datePickerValueChanged(picker: )), for: .valueChanged)
        setCountries2();
        
    }
}

