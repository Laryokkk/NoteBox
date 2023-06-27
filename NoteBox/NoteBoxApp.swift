//
//  NoteBoxApp.swift
//  NoteBox
//
//  Created by Laryokkk on 26/06/23.
//

import SwiftUI
import Firebase


@main
struct NoteBoxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured Firebase")
        
        return true
    }
}
