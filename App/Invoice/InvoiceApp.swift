//
//  InvoiceApp.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/23.
//

import SwiftUI

@main
struct InvoiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ViewModel())
        }
    }
}
