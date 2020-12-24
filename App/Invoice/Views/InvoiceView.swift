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
            Text("\(vm.message)")
//                .font(.largeTitle)
                .foregroundColor(Color.white)
                
//            Text("\(self.weatherVM.humidity)")
//                .foregroundColor(Color.white)
//                .opacity(0.7)
            
            Picker(selection: $vm.selectedIndex, label: Text("Select")) {
                
                Text(vm.segmentItems[0].periodDescription).tag(0)
                Text(vm.segmentItems[1].periodDescription).tag(1)
                
            }.pickerStyle(SegmentedPickerStyle())
            
        }
        .padding()
        .frame(width: 300)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
    
    }
}

struct InvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        vm.message = "test ABC"
        return InvoiceView(vm: vm)
    }
}
