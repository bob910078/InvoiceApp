//
//  InvoiceService.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/23.
//

import Foundation

final class InvoiceService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private var appID: String {
         return "YOUR_APP_ID"
    }
    
    /// 查詢指定期間的中獎發票號碼
    /// - Parameters:
    ///   - invTerm: 欲取得資料的民國年份與月份，必須為雙數月。例如：10906
    ///   - completion: 異步的方式返回結果
    func qryWinningList(invTerm: String, completion: @escaping ( Result<InvoiceQryWinningList, Error> ) -> Void) {
        
        let parameters: [String:String] = [
            "version": "0.2",
            "action": "QryWinningList",
            "invTerm": invTerm,
            "appID": appID,
        ]
        
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.einvoice.nat.gov.tw"
        comp.path = "/PB2CAPIVAN/invapp/InvApp"
        let reqURL = comp.url!
        
        var req = URLRequest(url: reqURL)
        req.httpMethod = "POST"
        req.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        req.httpBody = parameters.map({ "\($0.key)=\($0.value)" }).joined(separator: "&").data(using: .utf8)

        let parse: (Data) throws -> InvoiceQryWinningList = {
            let decoder = JSONDecoder()
            return try decoder.decode(InvoiceQryWinningList.self, from: $0)
        }
        
        let task = urlSession.dataTask(with: req) { (dataOrNil, responseOrNil, errorOrNil) in
            if let error = errorOrNil {
                completion(.failure(error))
                return
            }
            guard let data = dataOrNil else {
                completion(.failure(APIResponseError.noData))
                return
            }
            do {
                let dataModel = try parse(data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(APIResponseError.parsing))
            }
        }
        
        task.resume()
    }
    
}


// MARK: - InvoiceQryWinningList
struct InvoiceQryWinningList: Codable {
    let v, code, msg, updateDate: String
    let invoYm, superPrizeAmt, superPrizeNo, spcPrizeAmt: String
    let spcPrizeNo, spcPrizeNo2, spcPrizeNo3, firstPrizeAmt: String
    let firstPrizeNo1, firstPrizeNo2, firstPrizeNo3, firstPrizeNo4: String
    let firstPrizeNo5, firstPrizeNo6, firstPrizeNo7, firstPrizeNo8: String
    let firstPrizeNo9, firstPrizeNo10, secondPrizeAmt, thirdPrizeAmt: String
    let fourthPrizeAmt, fifthPrizeAmt, sixthPrizeAmt, sixthPrizeNo1: String
    let sixthPrizeNo2, sixthPrizeNo3, sixthPrizeNo4, sixthPrizeNo5: String
    let sixthPrizeNo6: String
    let timeStamp: TimeStamp
    struct TimeStamp: Codable {
        let date, hours, seconds, month: Int
        let timezoneOffset, year, minutes, time: Int
        let day: Int
    }
}


enum APIResponseError: Error {
    case network, parsing, request, noData
}

struct PrizeNumbers: Codable {
    
    var superPrizeNo: [String]
    var spcPrizeNo: [String]
    var firstPrizeNo: [String]
    var sixthPrizeNo: [String]
    
    init(superPrizeNo: [String], spcPrizeNo: [String], firstPrizeNo: [String], sixthPrizeNo: [String]) {
        self.superPrizeNo = superPrizeNo
        self.spcPrizeNo = spcPrizeNo
        self.firstPrizeNo = firstPrizeNo
        self.sixthPrizeNo = sixthPrizeNo
    }
    
}
