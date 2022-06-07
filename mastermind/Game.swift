class Game {
    static let maxAttempts = 12
    private let secret: Code
    private(set) var turns: [Turn] = []

    init(secret: Code = Code.makeRandom()) {
        self.secret = secret
    }

    func takeGuess(_ guess: Code) {
        if isOver() { return }

        let turn = Turn(
            number: turns.count + 1,
            guess: guess,
            exact: guess.exactMatches(with: secret),
            partial: guess.partialMatches(with: secret)
        )

        turns.append(turn)
    }

    func isOver() -> Bool {
        return !hasAttemptsRemaining() || isSolved()
    }

    func winner(codemaker: Player, codebreaker: Player) -> Player? {
        if isSolved() { return codebreaker }
        if !hasAttemptsRemaining() { return codemaker }

        return nil
    }

    private func hasAttemptsRemaining() -> Bool {
        return turns.count < Game.maxAttempts
    }

    private func isSolved() -> Bool {
        return turns.contains(where: { $0.guess == secret })
    }
}
