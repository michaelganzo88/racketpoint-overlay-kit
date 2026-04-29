import SwiftUI

public struct ScoreboardTemplateView: View {
    public var data: ScoreboardData

    public init(data: ScoreboardData) {
        self.data = data
    }

    public var body: some View {
        VStack(spacing: 0) {
            teamRow(
                name: data.teamAName,
                sets: data.setsA,
                game: data.currentGameA,
                score: data.currentScoreA,
                isServing: data.isTeamAServing
            )

            Divider().background(Color.gray.opacity(0.5))

            teamRow(
                name: data.teamBName,
                sets: data.setsB,
                game: data.currentGameB,
                score: data.currentScoreB,
                isServing: !data.isTeamAServing
            )

            if let label = bottomLabel {
                Divider().background(Color.gray.opacity(0.4))
                Text(label)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)
                    .background(Color.white)
            }
        }
        .background(data.backgroundStyle == .solid ? Color.black : Color.black.opacity(0.85))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .fixedSize(horizontal: true, vertical: true)
    }

    private var bottomLabel: String? {
        switch data.scoreStyle {
        case .goldenPoint:
            return "GOLDEN POINT"
        case .deuce:
            let num = data.currentScoreA.dropFirst()
            return "DEUCE \(num)"
        case .normal:
            let advScore = data.currentScoreA.hasPrefix("AD") ? data.currentScoreA
                         : data.currentScoreB.hasPrefix("AD") ? data.currentScoreB
                         : nil
            if let adv = advScore {
                let num = adv.dropFirst(2)
                return "ADVANTAGE \(num)"
            }
            return nil
        }
    }

    @ViewBuilder
    private func teamRow(name: String, sets: [Int], game: Int, score: String, isServing: Bool) -> some View {
        HStack(spacing: 0) {
            HStack(spacing: 5) {
                Text(name.uppercased())
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(Color(white: 0.9))
                    .lineLimit(1)

                Spacer(minLength: 20)

                Image(systemName: "asterisk")
                    .font(.system(size: 14, weight: .black))
                    .foregroundColor(Color(white: 0.8))
                    .opacity(isServing ? 1 : 0)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider().background(Color.gray.opacity(0.5))

            ForEach(0..<sets.count, id: \.self) { index in
                Text("\(sets[index])")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 30, height: 35)
                    .background(Color(white: 0.95))

                Divider().background(Color.gray.opacity(0.5))
            }

            Text("\(game)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 30, height: 35)
                .background(Color.gray.opacity(0.6))

            Divider().background(Color.gray.opacity(0.5))

            scoreCellView(score: score)
        }
    }

    @ViewBuilder
    private func scoreCellView(score: String) -> some View {
        switch data.scoreStyle {
        case .deuce:
            Text(score)
                .font(.system(size: 15, weight: .heavy, design: .monospaced))
                .foregroundColor(.white)
                .frame(width: 44, height: 35)
                .background(Color(red: 0.5, green: 0.15, blue: 0.85).opacity(0.9))

        case .goldenPoint:
            Text(score)
                .font(.system(size: 15, weight: .heavy, design: .monospaced))
                .foregroundColor(score.isEmpty ? .clear : .black)
                .frame(width: 44, height: 35)
                .background(
                    LinearGradient(
                        colors: [Color(red: 1.0, green: 0.84, blue: 0.0),
                                 Color(red: 0.85, green: 0.65, blue: 0.0)],
                        startPoint: .top, endPoint: .bottom
                    )
                )

        case .normal:
            Text(score)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 44, height: 35)
                .background(Color.gray.opacity(0.4))
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ScoreboardTemplateView(data: ScoreboardData(
            teamAName: "SANZ / NIETO",
            teamBName: "GUTIERREZ / ALFONSO",
            setsA: [6], setsB: [3],
            currentGameA: 4, currentGameB: 2,
            currentScoreA: "30", currentScoreB: "15",
            isTeamAServing: true
        ))

        ScoreboardTemplateView(data: ScoreboardData(
            teamAName: "SANZ / NIETO",
            teamBName: "GUTIERREZ / ALFONSO",
            setsA: [6], setsB: [3],
            currentGameA: 4, currentGameB: 2,
            currentScoreA: "D1", currentScoreB: "D1",
            isTeamAServing: false,
            scoreStyle: .deuce
        ))

        ScoreboardTemplateView(data: ScoreboardData(
            teamAName: "SANZ / NIETO",
            teamBName: "GUTIERREZ / ALFONSO",
            setsA: [6], setsB: [3],
            currentGameA: 4, currentGameB: 2,
            currentScoreA: "GP", currentScoreB: "GP",
            isTeamAServing: true,
            scoreStyle: .goldenPoint
        ))
    }
    .padding()
    .background(Color.gray)
}
