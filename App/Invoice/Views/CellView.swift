//
//  CellView.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/24.
//

import SwiftUI

struct CellView: View {
    var model: CellViewModel
    var body: some View {
        HStack {
            Text(model.title)
                .font(.title2)
            Spacer()
            Text(model.numbers.joined(separator: "\n"))
                .font(.system(.title, design: .monospaced))
                .foregroundColor(Color(.brown))
        }
        .padding()
        .background(Color(.brown).opacity(0.3))
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        let testModel = CellViewModel(title: "200元增開",
                                      numbers: ["651", "341"])
        return CellView(model: testModel)
    }
}
