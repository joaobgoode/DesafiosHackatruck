import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    
    func show() -> some View {
        HStack {
            Text(name)
            Spacer()
            Image(systemName: icon)
        }
        .padding()
    }
}

struct ListView: View {
    
    private var items = [
        Item(name: "Pink", icon: "paintbrush.fill"),
        Item(name: "Blue", icon: "paintbrush.pointed.fill"),
        Item(name: "Pink", icon: "paintpalette.fill")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("List")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding()
            
            ForEach(items) { item in
                item.show()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ListView()
}
