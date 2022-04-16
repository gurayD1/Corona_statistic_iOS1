//
//  FavouriteCounrtyListVC.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-14.
//

import UIKit

class FavouriteCounrtyListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelForCountryName: UILabel!
    @IBOutlet weak var countryListTable: UITableView!
    @IBOutlet weak var countryDataTable: UITableView!
    var todaysData : Country3 = Country3()
    @IBOutlet weak var countryResultTable: UITableView!
    
    // when user search something in the searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        // when the search bar is empty
        if searchText.count == 0{
            
        }else {
            // get the counry instance from coreDataService
            let foundCountry = CoreDataService.shared.getCountryStartWith(text: searchText)
            //if country has been found
            if(!foundCountry.isEmpty){
                // get the index number of the country in the array
                let num =  CoreDataService.shared.getAllCounrtyFromStorage().firstIndex(of: foundCountry[0])
                
                if(num != nil){
                    // select the row on the table
                    let indexPath = IndexPath(row: num!, section: 0)
                    countryListTable.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
                    countryListTable.delegate?.tableView!(countryListTable, didSelectRowAt: indexPath)}
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.tag == 3){
            return 1;}
        if(tableView.tag == 4){
            return CoreDataService.shared.getAllCounrtyFromStorage().count
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView.tag == 3){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellForTodaysDataTableViewCell
            if(indexPath.section == 0){
                // display cases deaths and active cases information
                cell.label1.text = String(todaysData.cases);
                cell.label2.text = String(todaysData.deaths);
                cell.label3.text = String(todaysData.active);
            }
            if(indexPath.section == 1){
                // display cases deaths and recovered person information
                cell.label1.text = String(todaysData.todayCases);
                cell.label2.text = String(todaysData.todayDeaths);
                cell.label3.text = String(todaysData.todayRecovered);
            }
            
            return cell}
        if(tableView.tag == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! cellForCountryTableViewCell
            // display country name and population
            cell.label1.text = CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row].country
            cell.label2.text = String(CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row].population)
            return cell;
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // ask user to confirm if they want to delete the selected row
            let alert = UIAlertController(title: "Are you sure you want to delete this task??", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                //get the instance of the country for the selected row
                let  myfavouriteCountry : MyFavouriteCountry =  CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row]
                // delete the data
                CoreDataService.shared.deleteFromStorage(favouriteCountry: myfavouriteCountry)
                self.countryListTable.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView.tag == 3){
            return 2}
        if(tableView.tag == 4){
            return 1
        }
        return 1
    }
    
    // header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textAlignment = .center
        if(tableView.tag == 3){
            if(section == 0){
                headerText.text = "Total Cases - Deaths and Active Cases"
            }
            if(section == 1){
                headerText.text =  "Today's Cases - Deaths and Recovered "
            }
        }
        if(tableView.tag == 4){
            headerText.text =  "Country Name and Population"
        }
        return headerText
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView.tag == 4){
            // when user select a row in the table, get the country name and flag url
            let country_name = CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row].country;
            let flag = CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row].flag;
            // set the text label with the country name
            labelForCountryName.text = country_name
            // set the flag picture in the imageView
            NetworkService.Shared.getImage(url: flag!, completionHandler: {result in
                switch result{
                case .success(let myImage):
                    DispatchQueue.main.async {
                        self.imageView.image = myImage
                    }
                    break
                case .failure(_):
                    break
                }
            })
            // get the current data and display it on the table
            NetworkService.Shared.getTodayDataForCountry(countryName: country_name!, completionHandler: {result in
                switch result{
                case .success(let countryCollection):
                    self.todaysData = countryCollection
                    DispatchQueue.main.async {
                        self.countryDataTable.reloadData()
                    }
                    break
                case.failure(let error):
                    print(error)
                    break
                }
            }
                                                         
            )
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
