//
//  Helper.swift
//  VeeWeather
//
//  Created by Skander Bahri on 20/09/2021.
//

import Foundation

func convertDateStringToDate(formatter: String, dateString: String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatter
    return dateFormatter.date(from: dateString) ?? Date()
}

func convertDatStringToCustomDate(baseFormatter: String, exportFormatter: String, dtString: String?) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = baseFormatter
    let date = dateFormatter.date(from: dtString.orEmpty) ?? Date()
    dateFormatter.dateFormat = exportFormatter
    let dateString = dateFormatter.string(from: date)
    return dateFormatter.date(from: dateString) ?? Date()
}

func convertDatStringToCustomString(baseFormatter: String, exportFormatter: String, dtString: String?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = baseFormatter
    let date = dateFormatter.date(from: dtString.orEmpty) ?? Date()
    dateFormatter.dateFormat = exportFormatter
    let dateString = dateFormatter.string(from: date)
    return dateString
}

func convertDateToString(formatter: String, date: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatter
    return dateFormatter.string(from: date)
}

func convertDoubleToStringWithMaximumFractionDigits(digits: Int, number: Double) -> String {
    let nf = NumberFormatter()
    nf.roundingMode = .down
    nf.maximumFractionDigits = digits
    let t = nf.string(for: number)
    return t.orEmpty
}

func convertKelvinToCelsius(digits: Int, number: Double) -> String {
    let nf = NumberFormatter()
    nf.roundingMode = .down
    nf.maximumFractionDigits = digits
    let tempCelsius = (number - 273.15)
    let t = nf.string(for: tempCelsius)
    return t.orEmpty
}
