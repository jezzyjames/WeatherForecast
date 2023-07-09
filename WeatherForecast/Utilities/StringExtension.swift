//
//  StringExtension.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import Foundation

extension String {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newDate = dateFormatter.date(from: self) ?? Date()
        
        return newDate
    }
    
    var dateFormat: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "en_US")
        dateFormatterPrint.dateFormat = "EE dd MMM, HH:mm"

        if let date = dateFormatterGet.date(from: self) {
            let dateString = dateFormatterPrint.string(from: date)
            return dateString
        } else {
           return ""
        }
    }
}
