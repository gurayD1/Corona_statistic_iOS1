//
//  ModelClasses.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-12.
//

import Foundation
// for historical data
class Country2 : Codable{
    var Country : String = "";
    var Confirmed : Int = 0;
    var Deaths : Int = 0;
    var Recovered : Int = 0;
    var Active : Int = 0;
    
}

// for current days data
class CountryInfo : Codable{
    var iso2 : String? 
    var flag : String = "";

}
// for current days data
class Country3 : Codable{
    var country : String = "";
    var countryInfo : CountryInfo = CountryInfo();
    var cases : Int = 0;
    var todayCases : Int = 0;
    var deaths : Int = 0;
    var todayDeaths : Int = 0;
    var recovered : Int = 0;
    var todayRecovered : Int = 0;
    var active : Int = 0;
    var critical : Int = 0;
   var population : Int = 0;
    
}
