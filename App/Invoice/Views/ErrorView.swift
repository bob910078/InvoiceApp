//
//  ErrorView.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/24.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.body)
                .foregroundColor(Color.white)
            
        }
        .padding()
        .frame(width:300, height: 150)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "sorry, try again later.")
    }
}
