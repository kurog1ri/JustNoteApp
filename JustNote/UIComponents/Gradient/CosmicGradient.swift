//
//  CosmicGradient.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct CosmicGradient {
    static let main = LinearGradient(
        colors: [Color(hex: 0x6A5ACD), Color(hex: 0xFF69B4)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let nebulaPalette = [
        Color(hex: 0xFF6B6B),
        Color(hex: 0x4ECDC4),
        Color(hex: 0x45B7D1),
        Color(hex: 0x96CEB4),
        Color(hex: 0xFFEEAD)
    ]
}
