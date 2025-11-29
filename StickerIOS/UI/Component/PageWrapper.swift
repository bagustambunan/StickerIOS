import SwiftUI

struct PageWrapper<Content: View>: View {
    let content: Content
    let pageTitle: String
    
    init(pageTitle: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.pageTitle = pageTitle
    }
    
    var scrollView: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                content
                    .padding(.horizontal)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var body: some View {
        Group {
            if #available(iOS 15.0, *) {
                scrollView
                    .background(
                        Image("paper")
                            .resizable(resizingMode: .tile)
                            .ignoresSafeArea()
                    )
            } else {
                scrollView
                    .background(
                        Image("paper")
                            .resizable(resizingMode: .tile)
                    )
            }
        }
        .navigationTitle(pageTitle)
    }
}

#Preview {
    PageWrapper(pageTitle: "Hello, World!") {
        Text("Content")
    }
}
