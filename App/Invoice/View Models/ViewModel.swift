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
    
    @Published var selectedIndex: Int = 0 {
        didSet {
            print("---> \(selectedIndex)")
            update()
        }
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
                self.message = """
                開獎名單:
                \(value.superPrizeNo[0])
                \(value.spcPrizeNo[0])
                \(value.firstPrizeNo[0])
                \(value.sixthPrizeNo[0])
                """
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
                                         sixthPrizeNo: [dataModel.sixthPrizeNo1])
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
