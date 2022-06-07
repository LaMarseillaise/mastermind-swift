import Darwin

class ConsolePlayer: Player {
    let name: String

    init(name: String) {
        self.name = name
    }

    func makeSecret() -> Code {
        print("\(name): What will the secret code be?", terminator: " ")

        return parse(readLine()!)
    }

    func makeGuess(for game: Game) -> Code {
        return parse(readLine()!)
    }

    private func parse(_ digits: String) -> Code {
        var sequence: [Piece] = []
        var i = 0

        for digit in digits {
            if let selection = parse(digit) {
                sequence.append(selection)
                i += 1
                if i >= Code.length { break }
            }
        }

        for _ in sequence.count..<Code.length {
            sequence.append(Piece.colors.randomElement()!)
        }

        return Code(sequence)
    }

    private func parse(_ digit: Character) -> Piece? {
        switch digit {
        case "1": return Piece.Black
        case "2": return Piece.Blue
        case "3": return Piece.Green
        case "4": return Piece.Red
        case "5": return Piece.White
        case "6": return Piece.Yellow
        case "q": exit(0)
        default: return nil
        }
    }
}
