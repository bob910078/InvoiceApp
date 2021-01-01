//
//  TermHelper.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/23.
//

import Foundation

class TermHelper {
    
    func getPriceNumberReleaseDate(today: Date) -> Date {
        
        let cal = Calendar.current
        let yer = cal.component(.year, from: today)
        let mon = cal.component(.month, from: today)
        let day = cal.component(.day, from: today)
        
        // 開獎日期
        var tYer = yer
        var tMon = mon
        let tDay = 25
        
        if mon.isOdd {
            if day <= 25 {
                let theday = cal.date(byAdding: .month, value: -2, to: today)!
                tMon = cal.component(.month, from: theday)
                tYer = cal.component(.year, from: theday)
            } else {
                tMon = mon
            }
        } else {
            let theday = cal.date(byAdding: .month, value: -1, to: today)!
            tMon = cal.component(.month, from: theday)
            tYer = cal.component(.year, from: theday)
        }
        
        let dateString = String(format: "%.3d-%.2d-%.2d", tYer, tMon, tDay)
        let releaseDate: Date = Date(dateString: dateString)!
        
        return releaseDate
    }
    
    func getRequestString(releaseDate: Date) -> [TermData] {
        
        let cal = Calendar.current
        
        // 民國元年
        let rocFirstYear = 1911
        
        // 最近一期
        let date1 = cal.date(byAdding: .month, value: -1, to: releaseDate)!
        let year1 = cal.component(.year, from: date1) - rocFirstYear
        let mont1 = cal.component(.month, from: date1)
        let m: String = String(format: "%d%.2d", year1, mont1)
        let mm: String = String(format: "%d 年 %.2d-%.2d 月", year1, mont1-1, mont1)
        
        // 最近一期的再上一期
        let date2 = cal.date(byAdding: .month, value: -3, to: releaseDate)!
        let year2 = cal.component(.year, from: date2) - rocFirstYear
        let mont2 = cal.component(.month, from: date2)
        let n: String = String(format: "%d%.2d", year2, mont2)
        let nn: String = String(format: "%d 年 %.2d-%.2d 月", year2, mont2-1, mont2)
        
        return [
            TermData(requestCode: n, periodDescription: nn),
            TermData(requestCode: m, periodDescription: mm),
        ]
        
    }
    
}

struct TermData: Equatable, Hashable {
    let requestCode: String
    let periodDescription: String
}

extension Int {
    var isOdd: Bool {
        return (self % 2) == 1
    }
}

extension Date {
    
    init?(dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            self = date
        } else {
            return nil
        }
    }
        
}
