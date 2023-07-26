//
//  GPIP_OutlineApp.swift
//  GPIP Outline
//
//  Created by Albert Huynh on 6/21/23.
//

import SwiftUI
import Firebase


@main
struct GPIP_OutlineApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                RootViewFake()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
