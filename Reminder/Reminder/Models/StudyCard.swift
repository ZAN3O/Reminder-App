//
//  StudyCard.swift
//  Email Login Page
//
//  Created by Simon Steuer on 09/06/2021.
//  Copyright © 2021 Simon Steuer. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct StudyCard: Identifiable, Codable {
    @DocumentID var id:String?
    var date:String
    var remind: String
    var passed:Bool = false
}
