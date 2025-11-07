//
//  ContentView.swift
//  Desafio13
//

import SwiftUI
import Charts


enum LineChartType: String, CaseIterable, Plottable, Decodable {
    case read = "Read"
    case warning = "Warning"
    
    var color: Color {
        switch self {
        case .read: return .blue
        case .warning: return .red
        }
    }
}


protocol Metric {
    var value: Double { get }
    var timestamp: Double { get }
    
    func timeSince() -> Double
}


struct Umidade: Metric, Decodable, Identifiable {
    var id = UUID()
    var value: Double
    var timestamp: Double
    var type: LineChartType = .read
    
    func timeSince() -> Double {
        return (timestamp / 1000) - Date().timeIntervalSince1970
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "umidade"
        case timestamp
        case type 
    }
    
    init(value: Double, timestamp: Double, type: LineChartType = .read) {
        self.value = value
        self.timestamp = timestamp
        self.type = type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Double.self, forKey: .value)
        self.timestamp = try container.decode(Double.self, forKey: .timestamp)
        self.type = try container.decodeIfPresent(LineChartType.self, forKey: .type) ?? .read
        self.id = UUID()
    }
}


struct ContentView: View {
    
    @StateObject var umidadeRepo = UmidadeRepository()
    
    @State private var maxNumber: Int = 10
    @State private var warningValue: Float = 50
    var lastRead: Umidade? {
        umidadeRepo.umidades.last
    }

    
    let circleSize = 200
     
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.clear)
                    .frame(width: CGFloat(circleSize), height: CGFloat(circleSize))
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                
                Circle()
                    .fill(Color.blue)
                    .frame(
                        width: CGFloat(((lastRead?.value ?? 0) / 100) * Double(circleSize)),
                        height: CGFloat(((lastRead?.value ?? 0) / 100) * Double(circleSize))
                    )
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                
                Circle()
                    .fill(Color.clear)
                    .frame(
                        width: CGFloat((Double(warningValue) / 100) * Double(circleSize)),
                        height: CGFloat((Double(warningValue) / 100) * Double(circleSize))
                    )
                    .overlay(Circle().stroke(Color.red, lineWidth: 2))
                
                Text(String(format: "%.2f%%", lastRead?.value ?? 0))
                    .font(.system(size: 22, weight: .medium))
            }
            
            Spacer()
            
            Text("Humidity")
                .font(.system(size: 16, weight: .medium))
            
            Chart {
                RuleMark(y: .value("Limite", Double(warningValue)))
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundStyle(Color.red)
                
                ForEach(umidadeRepo.umidades, id: \.id) { item in
                    LineMark(
                        x: .value("Time", item.timeSince()),
                        y: .value("Humidity", item.value)
                    )
                    .foregroundStyle(item.type.color)
                    .foregroundStyle(by: .value("Plot", item.type))
                    .interpolationMethod(.catmullRom)
                    .lineStyle(.init(lineWidth: 2))
                    .symbol {
                        Circle()
                            .fill(item.type.color)
                            .frame(width: 12, height: 12)
                            .overlay {
                                Text("\(Int(item.value))")
                                    .frame(width: 20)
                                    .font(.system(size: 8, weight: .medium))
                                    .offset(y: -15)
                            }
                    }
                }
            }
            .chartLegend(position: .top, alignment: .leading, spacing: 24) {
                HStack(spacing: 6) {
                    ForEach(LineChartType.allCases, id: \.self) { type in
                        Circle()
                            .fill(type.color)
                            .frame(width: 8, height: 8)
                        Text(type.rawValue)
                            .foregroundStyle(type.color)
                            .font(.system(size: 11, weight: .medium))
                    }
                }
            }
            .chartYAxis {
                AxisMarks(preset: .extended, position: .leading, values: .stride(by: 5))
            }
            .preferredColorScheme(.dark)
            .frame(height: 300)
            
            Spacer()
        }
        .padding()
        .onAppear {
            umidadeRepo.fetch(maxNumber)
        }
    }
}


#Preview {
    ContentView()
}
