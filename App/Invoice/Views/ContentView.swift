//
//  ContentView.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: ViewModel
    var body: some View {
        
        if vm.loadingState == .none {
            Button(action: {
                print("follow")
                vm.update()
            }) {
                Text("follow")
                    .font(.system(size: 30))
                    .background(Color.yellow)
                    .foregroundColor(.red)
            }
        } else if vm.loadingState == .loading {
            LoadingView()
        } else if vm.loadingState == .success {
            InvoiceView(vm: vm)
        } else if vm.loadingState == .failed {
            ErrorView(message: vm.message)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        vm.loadingState = .none
        return ContentView(vm: vm)
    }
}
