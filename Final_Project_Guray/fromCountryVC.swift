//
//  fromCountryVC.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-14.
//

import UIKit

class fromCountryVC: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    var countryList : [Country3] = [Country3]()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {


        return countryList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = countryList[row].country
        return title
    }


    func setCountries()  {
        NetworkService.Shared.getSecondCountryList() {result in
            switch result{
            case .success(let countryCollection):
                self.countryList = countryCollection
                DispatchQueue.main.async {
                    self.myCountries.reloadAllComponents()

                }
                break
            case.failure(let error):
                print(error)

                break
            }
        }
    }


    @IBOutlet weak var myCountries: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCountries()
        // Do any additional setup after loading the view.
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
