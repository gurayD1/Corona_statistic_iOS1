//
//  NetworkService.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-12.
//

import Foundation
import UIKit


class NetworkService {
    
    
    static var Shared = NetworkService()
    
    // get historical data from api
    func getDataForCountry(countryName : String,  previousDate : String, selectedDate : String,
                           completionHandler : @escaping (Result <[Country2], Error>)->Void )  {
        
        let url = "https://api.covid19api.com/country/\(countryName)?from=\(previousDate)&to=\(selectedDate)"
        let urlObj = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: urlObj)
        { data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                print ("Incorrect response ")
                return
            }
            
            if let jsonData = data {
                
                let decoder =  JSONDecoder()
                do {
                    let result = try decoder.decode([Country2].self, from: jsonData)
                    completionHandler(.success(result))
                }
                catch {
                    print (error)
                }
            }
        }
        task.resume()
    }
    
    
    // get currents data from api
    func getTodayDataForCountry(countryName : String,
                                completionHandler : @escaping (Result <Country3, Error>)->Void )  {
        let url = "https://disease.sh/v3/covid-19/countries/\(countryName)";
    
        guard let urlObj = URL(string: url) else{
           return
        }
        
        let task = URLSession.shared.dataTask(with: urlObj)
        { data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                print ("Incorrect response ")
                return
            }
            
            if let jsonData = data {
                
                let decoder =  JSONDecoder()
                do {
                    let result = try decoder.decode(Country3.self, from: jsonData)
                    completionHandler(.success(result))
                }
                catch {
                    print (error)
                }
            }
        }
        task.resume()
    }
    
    // get all countries from api
    func getSecondCountryList(
        completionHandler : @escaping (Result <[Country3], Error>)->Void )  {
            let url = "https://disease.sh/v3/covid-19/countries";
            
            let urlObj = URL(string: url)!
            
            let task = URLSession.shared.dataTask(with: urlObj)
            { data, response, error in
                guard error == nil else {
                    completionHandler(.failure(error!))
                    return
                }
                guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                    print ("Incorrect response ")
                    return
                }
                
                if let jsonData = data {
                    
                    let decoder =  JSONDecoder()
                    do {
                        let result = try decoder.decode([Country3].self, from: jsonData)
                        completionHandler(.success(result))
                    }
                    catch {
                        print (error)
                    }
                }
            }
            task.resume()
        }
    // download image by url
    func getImage(url: String , completionHandler : @escaping (Result <UIImage, Error>)->Void){
        let urlObj = URL(string: url)!
        let task = URLSession.shared.dataTask(with: urlObj)
        { data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                print ("Incorrect response ")
                return
            }
            if let imageData = data {
                let image = UIImage(data: imageData)
                completionHandler(.success(image!))
            }
        }
        task.resume()
        
    }
    
    
}
