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
    
    func getAllCountries(
        completionHandler : @escaping (Result <[Country], Error>)->Void )  {
            //  let url = "https://corona.lmao.ninja/v2/countries?yesterday&sort";
            let url = "https://api.covid19api.com/countries"
            
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
                        let result = try decoder.decode([Country].self, from: jsonData)
                        completionHandler(.success(result))
                    }
                    catch {
                        print (error)
                    }
                }
            }
            task.resume()
        }
    
    
    func getDataForCountry(countryName : String,  previousDate : String, selectedDate : String,
                           completionHandler : @escaping (Result <[Country2], Error>)->Void )  {
        //  let url = "https://corona.lmao.ninja/v2/historical/\(countryName)?lastdays=30";
        
        // let url =  "https://disease.sh/v3/covid-19/historical/\(countryName)?lastdays=720"
        
        //  let url2 = "https://api.covid19api.com/country/\(countryName)/status/confirmed?from=\(previousDate)&to=\(selectedDate)"
        let url3 = "https://api.covid19api.com/country/\(countryName)?from=\(previousDate)&to=\(selectedDate)"
        let urlObj = URL(string: url3)!
        
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
    
    
    
    func getTodayDataForCountry(countryName : String,
                           completionHandler : @escaping (Result <Country3, Error>)->Void )  {
        let url = "https://disease.sh/v3/covid-19/countries/\(countryName)";
      
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
