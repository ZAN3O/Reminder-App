//
//  CardViewModel.swift
//  Reminder
//
//  Created by Simon Steuer on 09/06/2021.
//
import SwiftUI
import Combine

final class CardViewModel: ObservableObject, Identifiable {
    private let cardRepository = CardRepository()
    @Published var studyCard: StudyCard
    
    var id = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(studyCard: StudyCard) {
        self.studyCard = studyCard
        $studyCard
            .compactMap { $0.id }
            .assign(to: \.id, on : self)
            .store(in: &cancellables)
    }
}
