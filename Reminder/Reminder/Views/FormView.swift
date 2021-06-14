//
//  FormView.swift
//  Reminder
//
//  Created by Simon Steuer on 10/06/2021.
//

import SwiftUI

struct FormView: View {
    @State private var remind :String = ""
    var didAddCard:(_ studyCard:StudyCard) -> Void
    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
        let loc = Locale(identifier: "fr-FR")
            formatter.dateStyle = .long
        formatter.locale = loc
            formatter.dateFormat = "dd MMMM yyyy HH:mm"
            return formatter
        }()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Form {
                        TextField("Nom du rappel", text:$remind).frame(height:30)
                            .font(Font.system(size: 20, design: .default))
                        DatePicker(
                                "Date",
                                 selection: $date,
                                 in: dateRange,
                                 displayedComponents: [.date, .hourAndMinute]
                        ).padding(.top, 25)
                        .environment(\.locale, Locale.init(identifier: "fr-FR"))
                            
                        
                    }.padding(.top, 25)
                }
                Button("Créer le rappel") {
                    let card = StudyCard(date: dateFormatter.string(from: date), remind: remind)
                    didAddCard(card)
                }.disabled(remind.isEmpty).padding()
                .foregroundColor(.white)
                .background(Color("Color"))
                .cornerRadius(10)
                
            }.navigationTitle("Nouveau Rappel")
        }
    }
}

