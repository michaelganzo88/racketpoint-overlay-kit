import Foundation

public enum ScoreStyle {
    case normal
    case deuce
    case goldenPoint
}

public enum ScoreboardBackgroundStyle {
    case transparent
    case solid
}

public struct ScoreboardData {
    public var teamAName: String
    public var teamBName: String
    public var setsA: [Int]
    public var setsB: [Int]
    public var currentGameA: Int
    public var currentGameB: Int
    public var currentScoreA: String
    public var currentScoreB: String
    public var isTeamAServing: Bool
    public var scoreStyle: ScoreStyle
    public var backgroundStyle: ScoreboardBackgroundStyle

    public init(
        teamAName: String,
        teamBName: String,
        setsA: [Int],
        setsB: [Int],
        currentGameA: Int,
        currentGameB: Int,
        currentScoreA: String,
        currentScoreB: String,
        isTeamAServing: Bool,
        scoreStyle: ScoreStyle = .normal,
        backgroundStyle: ScoreboardBackgroundStyle = .transparent
    ) {
        self.teamAName = teamAName
        self.teamBName = teamBName
        self.setsA = setsA
        self.setsB = setsB
        self.currentGameA = currentGameA
        self.currentGameB = currentGameB
        self.currentScoreA = currentScoreA
        self.currentScoreB = currentScoreB
        self.isTeamAServing = isTeamAServing
        self.scoreStyle = scoreStyle
        self.backgroundStyle = backgroundStyle
    }
}
