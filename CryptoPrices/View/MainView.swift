//
//  ContentView.swift
//  CryptoPrices
//
//  Created by Halil Kaya on 18.09.2021.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView{
            List(cryptoListViewModel.cryptoList, id:\.id){ crypto in
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.navigationTitle("Crypto Prices")
        }.onAppear {
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://api.nomics.com/v1/prices?key=c91dd10d9bdf56f33a168bde4bde112b05a9008e")!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
