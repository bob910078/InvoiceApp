//
//  InvoiceView.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/24.
//

import SwiftUI

struct InvoiceView: View {
    @ObservedObject var vm: ViewModel
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 10) {
                
                Picker(selection: $vm.selectedIndex, label: Text("Select")) {
                    
                    Text(vm.segmentItems[0].periodDescription).tag(0).font(.title)
                    Text(vm.segmentItems[1].periodDescription).tag(1).font(.title)
                    
                }.pickerStyle(SegmentedPickerStyle())
                
                VStack {
                    ForEach(vm.displayModel) { model in
                        CellView(model: model)
                    }
                }
                
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
        }
        .padding()
    }
}

struct InvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        vm.message = "test ABC"
        return InvoiceView(vm: vm)
    }
}
