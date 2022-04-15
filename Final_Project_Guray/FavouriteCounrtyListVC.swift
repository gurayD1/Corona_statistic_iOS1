//
//  FavouriteCounrtyListVC.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-14.
//

import UIKit

class FavouriteCounrtyListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countryListTable: UITableView!
    @IBOutlet weak var countryDataTable: UITableView!
    var todaysData : Country3 = Country3()
    @IBOutlet weak var countryResultTable: UITableView!
    
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
                cell.label1.text = String(todaysData.cases);
                cell.label2.text = String(todaysData.deaths);
                cell.label3.text = String(todaysData.active);
                
               
                
            }
            if(indexPath.section == 1){
                cell.label1.text = String(todaysData.todayCases);
                cell.label2.text = String(todaysData.todayDeaths);
                cell.label3.text = String(todaysData.todayRecovered);
            }
            
            
            return cell}
        if(tableView.tag == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! cellForCountryTableViewCell
            
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
           // tableView.deleteRows(at: [indexPath], with: .fade)
          let  myfavouriteCountry : MyFavouriteCountry =  CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row]
            CoreDataService.shared.deleteFromStorage(favouriteCountry: myfavouriteCountry)
            countryListTable.reloadData()
            
            
            
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        if(tableView.tag == 3){
            if (section == 0){
                return "Total Cases - Deaths and Active Cases"
                
            }else if(section == 1){
                return "Today's Cases - Deaths and Recovered "
            }
            
        }
        if(tableView.tag == 4){
            return "Country Name and Population"
        }
        return "";
    }
    
    
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
        
        
       // let flag = CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row].flag;
        
        
//        NetworkService.Shared.getImage(url: flag!, completionHandler: {result in
//            switch result{
//            case .success(let myImage):
//                DispatchQueue.main.async {
//                    self.imageView.image = myImage
//                }
//                break
//            case .failure(_):
//                break
//            }
//            
//            
//        })
        
        if(tableView.tag == 4){
            let country_name = CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row].country;
            let flag = CoreDataService.shared.getAllCounrtyFromStorage()[indexPath.row].flag;
            
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
            
            
            
            NetworkService.Shared.getTodayDataForCountry(countryName: country_name!, completionHandler: {result in
                switch result{
                case .success(let countryCollection):
                    // print(countryCollection)
                    self.todaysData = countryCollection
                    // print(countryCollection)
                    DispatchQueue.main.async {
                        self.countryDataTable.reloadData()
                    }
                    break
                case.failure(let error):
                    print(error)
                    break
                }
            })}}
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
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
