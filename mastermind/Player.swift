protocol Player {
    var name: String { get }
    func makeSecret() -> Code
    func makeGuess(for game: Game) -> Code
}
