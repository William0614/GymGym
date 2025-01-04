//
//  GymGymApp.swift
//  GymGym
//
//  Created by 김보윤 on 8/20/24.
//


import SwiftUI
//import FirebaseCore

////firebase initialisation code
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct GymGymApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    // register app delegate for Firebase setup
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(workoutManager) // WorkoutManager를 환경 객체로 주입
        }
    }
}
