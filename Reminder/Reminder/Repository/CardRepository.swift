//
//  CardRepository.swift
//  Reminder
//
//  Created by Simon Steuer on 09/06/2021.
//  Copyright © 2021 Simon Steuer. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

import Combine

final class CardRepository:ObservableObject {
    private let store = Firestore.firestore()
    private let path = Auth.auth().currentUser?.uid
    @Published var studyCards:[StudyCard] = []
    
    init() {
        get()
    }
    
    func get() {
        if path != nil {
            store.collection(path!).addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error)
                    return
                }
                self.studyCards = snapshot?.documents.compactMap{
                    try? $0.data(as: StudyCard.self)
                } ?? []
            }
        }
        else { return }
    }
    
    func add(_ studyCard:StudyCard) {
        if path != nil {
            do {
                _ = try store.collection(path!).addDocument(from: studyCard)
            } catch {
                fatalError("Adding a study card failed")
            }
        } else {return}
    }
    
    func remove(_ studyCard:StudyCard) {
        if path != nil {
            guard let documentId = studyCard.id else { return }
            store.collection(path!).document(documentId).delete() { error in
                if let error = error {
                    print("Unable to remove the card: \(error.localizedDescription)")
                }
            }
        } else {return}
    }
    
    func update(_ studyCard:StudyCard) {
        if path != nil {
            guard let documentId = studyCard.id else { return }
            do {
                try store.collection(path!).document(documentId).setData(from: studyCard)
            } catch {
                fatalError("Update a study card failed")
            }
        }else { return }
        
    }
}
