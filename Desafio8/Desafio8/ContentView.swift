import SwiftUI
import MapKit

struct Location: Hashable {
    let nome: String
    let foto: String
    let descricao: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct ContentView: View {
    let maravilhasDoMundo: [Location] = [
        Location( nome: "Grande Muralha da China", foto: "grande_muralha", descricao: "A Grande Muralha da China é uma impressionante fortificação construída ao longo de séculos para proteger o território chinês de invasões. Com mais de 21.000 km de extensão, ela serpenteia por montanhas, vales e desertos, combinando engenharia militar com uma estética monumental. Além de sua função defensiva, a muralha simboliza a força, a perseverança e a rica história da civilização chinesa, sendo uma das construções humanas mais emblemáticas do mundo.", latitude: 40.431908, longitude: 116.570374 ),
        Location( nome: "Petra", foto: "petra", descricao: "Petra, conhecida como a “Cidade Rosa”, é uma antiga cidade esculpida em rochas de arenito vermelho pelos nabateus há mais de 2.000 anos. Com seu intricado sistema de templos, túmulos e anfiteatros, Petra impressiona tanto pela habilidade arquitetônica quanto pela integração harmoniosa com o ambiente natural. É considerada um testemunho vivo da engenhosidade humana e da troca cultural entre civilizações antigas.", latitude: 30.328611, longitude: 35.444167 ),
        Location( nome: "Cristo Redentor", foto: "cristo_redentor", descricao: "O Cristo Redentor é uma colossal estátua de Jesus localizada no topo do Morro do Corcovado, no Rio de Janeiro. Com 38 metros de altura e braços abertos, simboliza a paz, a fé e a hospitalidade do povo brasileiro. Além de seu significado religioso, a estátua oferece uma vista panorâmica deslumbrante da cidade e se tornou um ícone cultural reconhecido mundialmente.", latitude: -22.951944, longitude: -43.210556 ),
        Location( nome: "Machu Picchu", foto: "machu_picchu", descricao: "Machu Picchu é uma antiga cidade inca localizada entre as montanhas dos Andes, conhecida como a “Cidade Perdida dos Incas”. Construída no século XV, combina arquitetura avançada e planejamento urbano adaptado ao terreno montanhoso. O sítio arqueológico revela o alto nível de conhecimento dos incas em engenharia, agricultura e astronomia, sendo um dos destinos mais fascinantes da história e da arqueologia mundial.", latitude: -13.163056, longitude: -72.545556 ),
        Location( nome: "Chichén Itzá", foto: "chichen_itza", descricao: "Chichén Itzá foi um centro urbano e religioso da civilização maia, famoso por sua pirâmide de Kukulcán. O complexo demonstra um profundo conhecimento de astronomia e engenharia, refletido na precisão com que a luz solar cria efeitos durante os solstícios. Chichén Itzá é um símbolo da riqueza cultural e intelectual dos povos maias, atraindo estudiosos e turistas do mundo todo.", latitude: 20.684285, longitude: -88.567783 ),
        Location( nome: "Coliseu de Roma", foto: "coliseu", descricao: "O Coliseu, localizado em Roma, é um anfiteatro monumental construído no século I d.C. e considerado um dos maiores símbolos da engenharia e da cultura do Império Romano. Com capacidade para mais de 50.000 espectadores, era palco de batalhas de gladiadores, espetáculos e eventos públicos. Sua estrutura elíptica, com arcadas imponentes e sistemas complexos de circulação e elevadores, reflete a genialidade arquitetônica romana, tornando-o um dos monumentos mais visitados e admirados do mundo.", latitude: 41.890251, longitude: 12.492373 ),
        Location( nome: "Taj Mahal", foto: "taj_mahal", descricao: "O Taj Mahal, situado em Agra, é um mausoléu de mármore branco construído no século XVII pelo imperador Shah Jahan em memória de sua esposa Mumtaz Mahal. Considerado uma obra-prima da arquitetura mogol, combina elementos islâmicos, persas e indianos, com jardins simétricos, minaretes elegantes e detalhes esculpidos com precisão. Além de seu valor artístico, o Taj Mahal é um símbolo eterno do amor e da devoção, sendo reconhecido mundialmente como um dos monumentos mais belos da humanidade.", latitude: 27.175015, longitude: 78.042155 ) ]
  
    @State private var selected: Location
    @State private var position: MapCameraPosition
    @State private var showSheet: Bool = false
    @State private var sheetLocation: Location
    
    init() {
        let inicial = maravilhasDoMundo[0]
        _selected = State(initialValue: inicial)
        _sheetLocation = State(initialValue: inicial)
        _position = State(initialValue: .region(
            MKCoordinateRegion(
                center: inicial.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
            )
        ))
    }
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(maravilhasDoMundo, id: \.self) { location in
                    Annotation(location.nome, coordinate: location.coordinate) {
                        Button {
                            sheetLocation = location
                            showSheet = true
                        } label: {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    
                            }
                            .foregroundColor(.black)

                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack {
                Picker("Escolha uma maravilha", selection: $selected) {
                    ForEach(maravilhasDoMundo, id: \.self) { location in
                        Text(location.nome)
                            .bold()
                            .tag(location)
                    }
                }
                .tint(.texto)
                .frame(width: 300, height: 60)
                .background(.fundo)
                .cornerRadius(12)
                .padding()
                
                Spacer()
                Text("Maravilhas do Mundo Moderno") 
                    .foregroundStyle(.texto)
                    .bold()
                    .padding()
                    .background(.fundo)
                    .cornerRadius(12)
            }
        }
        .onChange(of: selected) { novaLocalizacao in
            withAnimation {
                position = .region(
                    MKCoordinateRegion(
                        center: novaLocalizacao.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                    )
                )
            }
        }
        .sheet(isPresented: $showSheet) {
            LocationSheet(location: sheetLocation)
        }
    }
}


#Preview {
    ContentView()
}
