import SwiftUI
import MapKit


struct ContentView: View {
    @State private var position: MapCameraPosition
    @StateObject var praiaView = PraiaView()
    @StateObject var quiosqueView = QuiosqueView()

    init() {
        let fortalezaCenter = CLLocationCoordinate2D(latitude: -3.7319, longitude: -38.5267)
        _position = State(initialValue: .region(
            MKCoordinateRegion(
                center: fortalezaCenter,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        ))
    }

    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(praiaView.praias) { praia in
                    Annotation(praia.nome, coordinate: praia.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
                
                ForEach(quiosqueView.quiosque) { quiosque in
                    Annotation(quiosque.nome, coordinate: quiosque.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
            }
            .id(praiaView.praias)
            .ignoresSafeArea()
        }
        .onAppear {
            praiaView.fetch()
            quiosqueView.fetch()
        }
    }
}


#Preview {
    ContentView()
}
