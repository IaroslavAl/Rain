//
//  Rain.swift
//  Rain
//
//  Created by BELDIN Yaroslav on 22.09.2023.
//

import SwiftUI

/// A view representing an animated rain effect using text characters.
///
/// This view generates multiple `Drop` instances that animate vertically to create a rain effect.
/// - Parameters:
///   - character: The character to use for each drop.
///   - direction: The direction of the rain, either from top to bottom or from bottom to top.
struct Rain: View {
    let character: Character
    let direction: Direction

    var body: some View {
        ForEach(0..<25, id: \.self) { index in
            Drop(character: character, direction: direction, number: index)
        }
    }
}

/// A private view representing a single drop in the rain animation.
///
/// This view uses state animation to move a character vertically across the screen.
/// - Parameters:
///   - character: The character to display.
///   - direction: The direction in which the drop should move.
///   - number: A unique identifier for each drop to customize animations.
private struct Drop: View {
    private let character: Character
    private let direction: Direction
    private let number: Int
    private let fontSize: CGFloat
    private let initialOpacity: Double
    private let finalOpacity: Double
    private let initialYOffset: CGFloat
    private let finalYOffset: CGFloat
    private let paddingValue: CGFloat

    @State private var isAnimation: Bool = false

    init(character: Character, direction: Direction, number: Int) {
        self.character = character
        self.direction = direction
        self.number = number
        fontSize = .random(in: 30...50)
        initialOpacity = direction == .top ? 2 : 1
        finalOpacity = direction == .top ? -0.5 : 1
        initialYOffset = direction == .top ? -510 : 500
        finalYOffset = direction == .top ? 500 : -510
        paddingValue = .random(in: 0...360)
    }

    var body: some View {
        Text(String(character))
            .font(.system(size: fontSize))
            .fixedSize()
            .opacity(isAnimation ? finalOpacity : initialOpacity)
            .padding(number.isMultiple(of: 2) ? .leading : .trailing, paddingValue)
            .offset(y: isAnimation ? finalYOffset : initialYOffset)
            .onAppear(perform: animationAction)
    }

    /// Animates the drop moving it vertically and changing its opacity.
    ///
    /// This function sets up the animation to start when the drop appears on screen.
    func animationAction() {
        withAnimation(.linear(duration: Double.random(in: 12...14))
            .delay(Double(number))
            .repeatForever(autoreverses: false)) {
                isAnimation = true
            }
    }
}

/// Enum to specify the direction of the rain effect.
enum Direction {
    case top
    case bottom
}
