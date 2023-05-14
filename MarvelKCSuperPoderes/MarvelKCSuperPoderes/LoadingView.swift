//
//  LoadingView.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 11/5/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            /*Image(systemName: "Marvel_Logo.svg")*/
            Image("Marvel_Logo")
                .resizable()
                .frame(height: 100)
                .cornerRadius(10)
                .padding(50)
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
                .padding(50)
            Text("Loading...")
                .font(.title)
                .foregroundColor(.gray)
            Text("Ongi etorria")
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
