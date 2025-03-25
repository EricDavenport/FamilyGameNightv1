import SwiftUI

struct NoKidsSymbolView: View {
    var body: some View {
        ZStack {
            // Circle with slash
            Circle()
                .stroke(Color.red, lineWidth: 2)
                .frame(width: 24, height: 24)
            
            // Diagonal line
            Rectangle()
                .fill(Color.red)
                .frame(width: 2)
                .rotationEffect(.degrees(45))
                .frame(width: 24, height: 24)
            
            // Kid symbol
            Image(systemName: "figure.child")
                .font(.system(size: 14))
                .foregroundColor(.red)
        }
    }
}

#Preview {
    NoKidsSymbolView()
        .padding()
} 