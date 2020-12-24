//
//  LoadingView.swift
//  Invoice
//
//  Created by Bob Chang on 2020/12/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.body)
                .foregroundColor(Color.white)
          
        }
        .padding()
        .frame(width:300, height: 150)
        .background(Color.orange)
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
    
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
