//
//  ViewModel.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/23.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var segmentItems: [TermData] = []
    @Published var message: String = ""
    @Published var loadingState: LoadingState = .none
    
    @Published var selectedIndex: Int = 1 {
        didSet {
            update()
        }
    }
    
    private var value: PrizeNumbers?
    
    var displayModel: [CellViewModel] {
        guard let value = value else {
            return [
                CellViewModel(title: "??元", numbers: ["123", "456"]),
                CellViewModel(title: "??元", numbers: ["123", "456"]),
                CellViewModel(title: "??元", numbers: ["123", "456"]),
                CellViewModel(title: "??元", numbers: ["123", "456"]),
            ]
        }
        return [
            CellViewModel(title: "1000萬", numbers: value.superPrizeNo),
            CellViewModel(title: "200萬", numbers: value.spcPrizeNo),
            CellViewModel(title: "20萬", numbers: value.firstPrizeNo),
            CellViewModel(title: "200元", numbers: value.sixthPrizeNo),
        ]
    }
    
    init() {
        let today = Date()
        let releaseDate = TermHelper().getPriceNumberReleaseDate(today: today)
        self.segmentItems = TermHelper().getRequestString(releaseDate: releaseDate)
    }
    
    func update() {
        
        loadingState = .loading
        
        let thisMonth = segmentItems[selectedIndex]
        request(byRequestCode: thisMonth.requestCode) { value in
            
            DispatchQueue.main.async {
                
                guard let value = value else {
                    self.message = "no data!!"
                    self.loadingState = .failed
                    return
                }
                
                self.loadingState = .success
                self.value = value
            }
            
        }
    }
    
    private func request(byRequestCode: String, completion: @escaping (PrizeNumbers?) -> Void) {
        // 使用該開獎日去取得該期中獎號碼資料
        let a = InvoiceService()
        a.qryWinningList(invTerm: byRequestCode) { ret in
            switch ret {
            case .failure(_):
                completion(nil)
            case .success(let dataModel):
                let value = PrizeNumbers(superPrizeNo: [dataModel.superPrizeNo],
                                         spcPrizeNo: [dataModel.spcPrizeNo],
                                         firstPrizeNo: [dataModel.firstPrizeNo1, dataModel.firstPrizeNo2, dataModel.firstPrizeNo3],
                                         sixthPrizeNo: [dataModel.sixthPrizeNo1, dataModel.sixthPrizeNo2])
                completion(value)
            }
        }
    }
    
}


enum LoadingState {
    case none
    case loading
    case success
    case failed
}

struct CellViewModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let numbers: [String]
}
