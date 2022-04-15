//
//  ModelClasses.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-12.
//

import Foundation
class Country : Codable{
    
    var Country : String = "";
    var Slug : String = "";
    var ISO2 : String = "";
    // var countryInfo : CountryInfo = CountryInfo();
    
    // var timeline : TimeLine = TimeLine() ;
    
    //    var todayCases : Int = 0;
    //    var todayDeaths : Int = 0;
    
}

class Country2 : Codable{
    var Country : String = "";
    var Confirmed : Int = 0;
    var Deaths : Int = 0;
    var Recovered : Int = 0;
    var Active : Int = 0;
    
}

class CountryCollection : Codable{
    static var countries : [Country] = [Country]()
}

class CountryInfo : Codable{
    var iso2 : String? 
    var flag : String = "";
   
   // var _id : Int = 0;
}


class TimeLine : Codable{
    
    var cases :Cases = Cases()
    var deaths: Deaths = Deaths()
    var recovered: Recovered = Recovered()
}

class Cases : Codable{
    
    
}
class Deaths : Codable{
    var deaths : [Date: Int]  = [Date: Int]()
}
class Recovered : Codable{
    var recovered : [Date : Int]  = [Date: Int]()
}

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
