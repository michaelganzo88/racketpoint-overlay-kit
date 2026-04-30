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
        GeometryReader { geo in
            // Stessa formula dell'export video: scaleFactor = maxDim / 1920.
            // Per container landscape maxDim = width.
            let scale = geo.size.width / 1920.0
            // Altezza di riferimento proporzionale all'aspect ratio reale del container
            // (per 16:9 → 1080, ma funziona anche per altri formati).
            let refH = 1920.0 * geo.size.height / geo.size.width

            ZStack(alignment: .topLeading) {
                // Tutto il contenuto viene disposto nello spazio di riferimento 1920×refH,
                // poi scalato come blocco unico. Padding e dimensioni rimangono
                // proporzionali indipendentemente dalla risoluzione del container.
                ZStack {
                    if isVisible {
                        ScoreboardTemplateView(data: data)
                            .padding(.leading, 50)
                            .padding(.bottom, 50)
                            .frame(width: 1920, height: refH, alignment: .bottomLeading)
                    }

                    if showWatermark {
                        WatermarkView()
                            .padding(.trailing, 36)
                            .padding(.bottom, 36)
                            .frame(width: 1920, height: refH, alignment: .bottomTrailing)
                    }
                }
                .frame(width: 1920, height: refH)
                .scaleEffect(scale, anchor: .topLeading)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
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
