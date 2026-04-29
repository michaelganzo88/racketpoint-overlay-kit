import SwiftUI

public struct WatermarkView: View {
    public init() {}

    public var body: some View {
        Image("RacketPointTVLogo", bundle: .module)
            .resizable()
            .scaledToFit()
            .frame(height: 80)
            .shadow(color: .black.opacity(0.7), radius: 3, x: 0, y: 1)
            .opacity(0.55)
    }
}

#Preview {
    ZStack {
        Color(red: 0.1, green: 0.2, blue: 0.15)
            .frame(width: 400, height: 225)

        WatermarkView()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(12)
    }
    .frame(width: 400, height: 225)
}
