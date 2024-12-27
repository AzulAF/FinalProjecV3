//
//  MainView.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//

import Foundation
import SwiftUI



struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: RemoteListView()) {
                    Image(systemName: "network")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: LocalListView()) {
                    Image(systemName: "tray.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Pantalla Principal")
        }
    }
}
