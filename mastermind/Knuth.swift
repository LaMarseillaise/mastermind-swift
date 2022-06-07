class Knuth: Player {
    let name: String
    private var maxRemainingAfter: [Code: Int] = [:]

    init(name: String) {
        self.name = name
    }

    func makeSecret() -> Code {
        return Code.makeRandom()
    }

    func makeGuess(for game: Game) -> Code {
        var candidates = Code.allPossibilities

        if game.turns.count == 0 {
            return makeInitialGuess()
        } else {
            for turn in game.turns {
                candidates = prune(candidates, with: turn)
            }
        }

        if candidates.count == 1 {
            return candidates.first!
        } else {
            return makeExploratoryGuess(candidates: candidates)
        }
    }

    private func prune(_ candidates: Set<Code>, with turn: Turn) -> Set<Code> {
        return candidates.filter({ code in
            turn.guess != code &&
            turn.exact == code.exactMatches(with: turn.guess) &&
            turn.partial == code.partialMatches(with: turn.guess)
        })
    }

    private func makeInitialGuess() -> Code {
        let first = Piece.colors.randomElement()!
        var second: Piece

        repeat {
            second = Piece.colors.randomElement()!
        } while first == second

        return Code([first, first, second, second])
    }

    private func makeExploratoryGuess(candidates: Set<Code>) -> Code {
        maxRemainingAfter = [:]
        let maxScoring = getMaxScoringGuesses(for: candidates)
        return (
            maxScoring.intersection(candidates).randomElement() ??
            maxScoring.randomElement() ??
            Code.makeRandom()
        )
    }

    private func getMaxScoringGuesses(for candidates: Set<Code>) -> Set<Code> {
        let minimumMatches = minMaxRemaining(in: candidates)
        return Code.allPossibilities.filter({ guess in
            maxRemaining(in: candidates, after: guess) == minimumMatches
        })
    }

    private func minMaxRemaining(in candidates: Set<Code>) -> Int {
        return (
            Code.allPossibilities
                .reduce(candidates.count, { least, guess in
                    min(least, maxRemaining(in: candidates, after: guess))
                })
        )
    }

    private func maxRemaining(
        in candidates: Set<Code>,
        after guess: Code
    ) -> Int {
        if let result = maxRemainingAfter[guess] {
            return result
        }

        var counts: [Int] = Array(repeating: 0, count: 21)

        for candidate in candidates {
            let i = candidate.exactMatches(with: guess) * 5 +
                    candidate.partialMatches(with: guess)
            counts[i] += 1
        }

        let most = counts.max()!
        maxRemainingAfter[guess] = most

        return most
    }
}
