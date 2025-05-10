import SwiftUI

struct ContentView: View {
    
    @State private var currency = 26
    private var name = "Ashwin"
    @State private var quote = "'Tap 'New Quote' to get inspired!'"

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.pink), Color.lightpeach]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    ZStack {
                        Text(quote)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .font(.system(size: 15, weight: .medium))
                            .padding(.top, 20)
                    }
                    
                    Image(.cow)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4)) 
                        .shadow(radius: 10)
                        .padding(25)
                }
                Text("Welcome " + name + "!" )
                    .font(.system(size: 25, weight: .medium))
                
                progressbar(currency: $currency)
                
                Button(action: {
                    fetchNewQuote { fetchedQuote in
                        self.quote = fetchedQuote
                    }
                }) {
                    Text("New Quote")
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(Color(.darkblue))
                        .cornerRadius(10)
                        .padding(50)
                }
                
                Spacer()
                
                HStack(spacing: 25) {
                    icon(icon_pic: "house.fill", icon_name: "Home")
                    icon(icon_pic: "chart.bar", icon_name: "Statistics")
                    icon(icon_pic: "pawprint.circle.fill", icon_name: "Pet")
                    icon(icon_pic: "person.crop.circle", icon_name: "Profile")
                }
            }
        }
    }

    // Function to fetch the quote
    func fetchNewQuote(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion("Invalid URL.")
            return
        }

        let apiKey = "yuh" // I replace this with my OpenAI API Key
        //(cant paste the key on github bc openAI will think its a privacy leak & inactivate my key)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo", 
            "messages": [
                ["role": "user", "content": "Generate an inspiring quote in under 10 words."]
            ],
            "max_tokens": 30 // Limits the length of the response
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion("Failed to fetch quote.")
                return
            }
            
            guard let data = data else {
                print("Error: No data received.")
                completion("Failed to fetch quote.")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Full JSON Response: \(json)") 
                    
                    if let choices = json["choices"] as? [[String: Any]],
                       let firstChoice = choices.first,
                       let message = firstChoice["message"] as? [String: Any],
                       let content = message["content"] as? String {
                        DispatchQueue.main.async {
                            completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
                        }
                    } else {
                        print("Error: Unexpected JSON structure. \(json)")
                        completion("Failed to parse quote.")
                    }
                } else {
                    print("Error: Failed to decode JSON into dictionary.")
                    completion("Failed to parse quote.")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion("Failed to parse quote.")
            }
        }.resume()
    }

}

#Preview {
    ContentView()
}

struct icon: View {
    var icon_pic: String
    var icon_name: String
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    print("Icon button tapped!")
                }) {
                    Image(systemName: icon_pic)
                        .font(.system(size: 40))
                        .foregroundColor(.black)
                }
                Text(icon_name)
            }
        }
    }
}

struct progressbar: View
{
    @Binding var currency: Int
    var body: some View {
        VStack {
            ProgressView(value: Double(currency)/Double(100))
                .frame(width: 270)
                .padding(20)
            HStack {
                Text("CURRENCY: \(currency) / 100")
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(Color("peach"))
            }
          
            .padding(.horizontal)
            .frame(height: 60)
            .background(Color.lightblue.opacity(0.2))
            
            .padding()
        }
    }
}
    
    
        



    

