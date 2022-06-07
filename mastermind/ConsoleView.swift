struct ConsoleView {
    static let paddingLeft = 4
    static let TOP_LEFT_CORNER = "┏"
    static let TOP_MIDDLE_INTER = "┳"
    static let TOP_RIGHT_CORNER = "┓"
    static let BOTTOM_LEFT_CORNER = "┗"
    static let BOTTOM_MIDDLE_INTER = "┻"
    static let BOTTOM_RIGHT_CORNER = "┛"
    static let HORIZONTAL = "➖"
    static let SIDE = "┃"

    // piece colors
    static let BLACK = "⚫️"
    static let BLUE = "🔵"
    static let GREEN = "🟢"
    static let RED = "🔴"
    static let WHITE = "⚪️"
    static let YELLOW = "🟡"

    // grading
    static let EXACT = "🔴"
    static let PARTIAL = "⚪️"
    static let NON_MATCH = "▪️"

    static func introduction() -> String {
        return "MASTERMIND"
    }

    static func gradingScheme() -> String {
        return "\(EXACT): matched color and position \(PARTIAL): matched color"
    }

    static func colorCodes() -> String {
        var current: Int = 0
        return Piece.colors.map {
            current += 1
            return "\(current): \(pieceIcon($0))"
        }.joined(separator: "  ") + "  q: exit"
    }

    static func pieceIcon(_ piece: Piece) -> String {
        switch piece {
        case .Black: return BLACK
        case .Blue: return BLUE
        case .Green: return GREEN
        case .Red: return RED
        case .White: return WHITE
        case .Yellow: return YELLOW
        }
    }

    static func topBorder() -> String {
        return (
            String(repeating: " ", count: paddingLeft) +
            TOP_LEFT_CORNER +
            String(repeating: HORIZONTAL, count: Code.length) +
            TOP_MIDDLE_INTER +
            String(repeating: HORIZONTAL, count: Code.length) +
            TOP_RIGHT_CORNER
        )
    }

    static func bottomBorder() -> String {
        return (
            String(repeating: " ", count: paddingLeft) +
            BOTTOM_LEFT_CORNER +
            String(repeating: HORIZONTAL, count: Code.length) +
            BOTTOM_MIDDLE_INTER +
            String(repeating: HORIZONTAL, count: Code.length) +
            BOTTOM_RIGHT_CORNER
        )
    }

    static func attemptLine(turn: Turn) -> String {
        return (
            "\(turn.number):".padding(
                toLength: paddingLeft,
                withPad: " ",
                startingAt: 0
            ) +
            SIDE +
            guessBar(sequence: turn.guess.sequence) +
            SIDE +
            feedbackLine(exact: turn.exact, partial: turn.partial) +
            SIDE
        )
    }

    static func feedbackLine(exact: Int, partial: Int) -> String {
        let nonMatches = (Code.length - exact - partial)
        return (
            String(repeating: EXACT, count: exact) +
            String(repeating: PARTIAL, count: partial) +
            String(repeating: NON_MATCH, count: nonMatches)
        )
    }
    
    static func guessBar(sequence: [Piece]) -> String {
        return sequence.map { pieceIcon($0) }.joined()
    }
}

