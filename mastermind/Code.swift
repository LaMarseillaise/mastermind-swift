struct Code: Hashable, Equatable {
    static let length = 4
    static let allPossibilities: Set<Code> = permutations()
    let sequence: [Piece]
    var length: Int {
        get { sequence.count }
    }

    init(_ sequence: [Piece]) {
        self.sequence = Array(
            sequence[0...(min(Code.length, sequence.count) - 1)]
        )
    }

    func exactMatches(with code: Code) -> Int {
        var count: Int = 0

        for i in 0..<length {
            if sequence[i] == code.sequence[i] { count += 1 }
        }
 
        return count
    }

    func partialMatches(with code: Code) -> Int {
        return colorMatches(with: code) - exactMatches(with: code)
    }

    private func countBy(color: Piece) -> Int {
        return sequence.reduce(0, { total, piece in
            piece == color ? total + 1 : total
        })
    }

    private func colorMatches(with code: Code) -> Int {
        return Piece.colors.reduce(0, { total, color in
            total + min(countBy(color: color), code.countBy(color: color))
        })
    }

    static func makeRandom() -> Code {
        var sequence: [Piece] = []

        for _ in 0..<length {
            sequence.append(Piece.colors.randomElement()!)
        }

        return Code(sequence)
    }

    private static func permutations(length: Int = length) -> Set<Code> {
        var perms: Set<Code> = []

        if length <= 1 {
            for color in Piece.colors {
                perms.insert(Code([color]))
            }
        } else {
            for permutation in permutations(length: length - 1) {
                for color in Piece.colors {
                    perms.insert(
                        Code(permutation.sequence + [color])
                    )
                }
            }
        }

        return perms
    }
}
