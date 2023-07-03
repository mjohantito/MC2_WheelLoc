//
//  FacilityModel.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 03/07/23.
//

import Foundation

struct EscalatorRow: Identifiable {
    let id = UUID()
    var floor: String
    var location: String
}

struct LiftRow: Identifiable {
    let id = UUID()
    var floor: String
    var location: String
}

struct ToiletDisableRow: Identifiable {
    let id = UUID()
    var floor: String
    var location: String
}
