import SwiftUI

struct SongView: View {
    @State var playlist: Playlist
    @State var number: Int
    @State var song: Song
    @State var numberOfSongs: Int
    
    @State var shuffle: Bool = false
    @State var repetir: Bool = false
    @State var playing: Bool = false
    
    func nextIndex() {
        if repetir { return }
        if shuffle {
            number = Int.random(in: 0..<numberOfSongs)
            return
        }
        number = (number + 1) % numberOfSongs
    }
    
    func prevIndex() {
        if repetir { return }
        if shuffle { return }
        if number == 0 {
            number = numberOfSongs - 1
            return
        }
        number -= 1
    }
    
    init(playlist: Playlist, number: Int) {
        self._playlist = State(initialValue: playlist)
        self._number = State(initialValue: number)
        self._song = State(initialValue: playlist.songs[number])
        self._numberOfSongs = State(initialValue: playlist.songs.count)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                song.showDetails()
                    .padding(150)
                
                HStack {
                    Spacer()
                    
                    Button(action: { shuffle.toggle() }) {
                        Image(systemName: "shuffle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundColor(shuffle ? .green : .white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        prevIndex()
                        song = playlist.songs[number]
                    }) {
                        Image(systemName: "backward.end.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    
                    Spacer(minLength: 30)
                    
                    Button(action: {
                        playing.toggle()
                    }) {
                        Image(systemName: playing ? "play.fill" : "pause.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    
                    Spacer(minLength: 30)
                    
                    Button(action: {
                        nextIndex()
                        song = playlist.songs[number]
                    }) {
                        Image(systemName: "forward.end.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    
                    Spacer()
                    
                    Button(action: { repetir.toggle() }) {
                        Image(systemName: "repeat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundColor(repetir ? .green : .white)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

#Preview {
    SongView(
        playlist: Playlist(
            id: 1,
            title: "HackaFM",
            author: "HackaSong",
            image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlQBojmTIKspyiherUEmNC67y289D2lsUhtA&s",
            songs: [
                Song(id: 1, title: "Dreamscape", artist: "Luna Waves"),
                Song(id: 2, title: "Electric Horizon", artist: "Neon Pulse", cover: "https://placehold.co/200x200"),
                Song(id: 3, title: "Lost in Echoes", artist: "Aurora Sky", cover: "https://placehold.co/200x200"),
                Song(id: 4, title: "Velvet Night", artist: "Crimson Tide", cover: "https://placehold.co/200x200"),
                Song(id: 5, title: "Golden Hour", artist: "The Solars", cover: "https://placehold.co/200x200"),
                Song(id: 6, title: "Midnight Drive", artist: "Echo City", cover: "https://placehold.co/200x200"),
                Song(id: 7, title: "Ocean Eyes", artist: "Blue Mirage", cover: "https://placehold.co/200x200"),
                Song(id: 8, title: "Firelight", artist: "Amber Soul", cover: "https://placehold.co/200x200"),
                Song(id: 9, title: "Gravity", artist: "Nova Sound", cover: "https://placehold.co/200x200"),
                Song(id: 10, title: "Parallel Lines", artist: "Synth Horizon", cover: "https://placehold.co/200x200")
            ]
        ),
        number: 0
    )
}
