import SwiftUI

public struct ScoreboardOverlayView: View {
    public let data: ScoreboardData
    public let isVisible: Bool
    public let showWatermark: Bool

    public init(data: ScoreboardData, isVisible: Bool, showWatermark: Bool) {
        self.data = data
        self.isVisible = isVisible
        self.showWatermark = showWatermark
    }

    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            if isVisible {
                ScoreboardTemplateView(data: data)
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            }

            if showWatermark {
                WatermarkView()
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color(red: 0.1, green: 0.2, blue: 0.15)

        ScoreboardOverlayView(
            data: ScoreboardData(
                teamAName: "SANZ / NIETO",
                teamBName: "GUTIERREZ / ALFONSO",
                setsA: [6], setsB: [3],
                currentGameA: 4, currentGameB: 2,
                currentScoreA: "30", currentScoreB: "15",
                isTeamAServing: true
            ),
            isVisible: true,
            showWatermark: true
        )
    }
    .frame(width: 640, height: 360)
}
