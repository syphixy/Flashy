//
//  Flashy_AppApp.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI

@main


struct Flashy_AppApp: App {
    
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
