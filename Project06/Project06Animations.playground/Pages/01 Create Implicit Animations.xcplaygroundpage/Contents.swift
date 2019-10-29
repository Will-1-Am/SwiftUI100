import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.default)
//    .blur(radius: (animationAmount - 1) * 3)
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host
