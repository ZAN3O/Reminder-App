//
//  Stockage.swift
//  Reminder
//
//  Created by Simon Steuer on 09/06/2021.
//  Copyright © 2021 Simon Steuer. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth


struct CardListView: View {
    @ObservedObject var cardListViewModel:CardListViewModel
    @State private var showingForm = false
    @State private var showPassed = false
    
    var cardViewModel:CardViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                Toggle(isOn: $showPassed, label: {
                    Text("\(showPassed ? "Cacher ":"Montrer ")les rappels terminés")
                })
                List {
                    ForEach(cardListViewModel.cardViewModels.filter{
                        $0.studyCard.passed == showPassed
                    }) {
                        cardVM in CardView(cardViewModel: cardVM)
                            .onTapGesture(count: 2, perform: {
                                var studyCard = cardVM.studyCard
                                studyCard.passed.toggle()
                                cardListViewModel.update(studyCard)
                                
                            })
                            
                                
                            
                    }.onDelete(perform: delete)
                }
                .listStyle(InsetListStyle())
                .navigationTitle("Rappels")

                HStack {
                    Button(action: {
                        showingForm = true
                        
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                           if success {
                               print("User Accepted")
                           } else if let error = error {
                               print(error.localizedDescription)
                          }
                        }
                        let content = UNMutableNotificationContent()
                        content.title = "Daily Notification"
                        content.body = "Daily Notification is Ready"
                        content.sound = UNNotificationSound.default //you can play with it
                        
                        var dateComponents = cardViewModel.studyCard.date
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
                        let date = dateFormatter.date(from: dateComponents)
                        let calendar = Calendar.current

                        let hour = calendar.component(.hour, from: date!)
                        let minutes = calendar.component(.minute, from: date!)
                    
                        
                        var dateComponent = DateComponents()
                        dateComponent.hour = hour
                        dateComponent.minute = minutes
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                        
                    }) {
                        Circle()
                            .fill(Color.green)
                            .frame(height:60)
                            .overlay(Image(systemName: "plus").foregroundColor(.white))
                    }.sheet(isPresented: $showingForm) {
                        FormView { (studyCard) in
                            cardListViewModel.add(studyCard)
                            showingForm = false
                        }
                    }
                    Button(action: {
                        
                        try! Auth.auth().signOut()
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        
                    }) {
                        
                        Text("Log out")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
            }
        }
    }
    private func delete(at offsets:IndexSet) {
        offsets.map{ cardListViewModel.cardViewModels[$0].studyCard}.forEach(cardListViewModel.remove)
    }
}

