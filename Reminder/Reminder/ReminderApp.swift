//
//  ReminderApp.swift
//  Reminder
//
//  Created by Simon Steuer on 09/06/2021.
//

import SwiftUI
import Firebase

@main
struct StudyCardsApp:App {
    init() {
        FirebaseApp.configure()
    
    }
    var body: some Scene {
        WindowGroup {
            Home()
            
        }
    }
}
