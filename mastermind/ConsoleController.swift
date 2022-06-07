import Darwin

class ConsoleController {
    static func play() {
        let (codemaker, codebreaker) = getPlayers()
        let secret = getSecret(from: codemaker)
        let game = Game(secret: secret)
        var winner: Player?

        print("\(codebreaker.name) must guess the code.")
        print(ConsoleView.gradingScheme())
        print(ConsoleView.topBorder())

        while winner == nil {
            let guess = codebreaker.makeGuess(for: game)
            game.takeGuess(guess)
            print(ConsoleView.attemptLine(turn: game.turns.last!))
            winner =
                game.winner(codemaker: codemaker, codebreaker: codebreaker)
        }

        print(ConsoleView.bottomBorder())
        print("\(winner!.name) wins! (\(game.turns.count) guesses)")
    }

    static func getPlayers() -> (Player, Player) {
        print(
            """
            \n\nWho will be the code maker?
            1. Player
            2. Computer
            """
        )

        let input = readLine()!
        switch input {
        case "q": exit(0)
        case "2": return (
            Knuth(name: "Computer"),
            ConsolePlayer(name: "Player")
        )
        default: return (
            ConsolePlayer(name: "Player"),
            Knuth(name: "Computer")
        )
        }
    }

    static func getSecret(from codemaker: Player) -> Code {
        print(ConsoleView.colorCodes())
        return codemaker.makeSecret()
    }
}
