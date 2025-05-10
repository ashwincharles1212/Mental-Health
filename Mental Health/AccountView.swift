import SwiftUI

struct AccountView: View {
    // Avatar and Personal Info
    @State private var avatar: Image = Image(systemName: "person.circle")
    @State private var name: String = "Akshi r"
    @State private var pronouns: String = "they/sh"
   
    @State private var email: String = "hellomynameis@ucdavis.edu"
    @State private var phone: String = "(310) 259 - 9385"

    @State private var isLightMode: Bool = true
    @State private var notificationsEnabled: Bool = false

    var body: some View {
        VStack(spacing: 20) {
           
            VStack {
                Text("Your Avatar")
                    .font(.headline)
                    .bold()
                
                ZStack {
                    Image("quiz_cow")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(25)
                        .padding(.top, 100)
                    
                    
                    Button(action: {
                        print("Edit Avatar Tapped")
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(lightBlue.opacity(0.7))
                            .background(Color.white)
                            .clipShape(Circle())
                            .frame(width: 25, height: 25)
                            .offset(x: 50, y: 50)
                    }
                }
            }
            
            // Personal Info Section
            InfoSection(title: "Personal Info") {
                VStack(alignment: .leading) {
                    InfoRow(label: "NAME", value: name, action: {
                        print("Edit Name")
                    })
                    InfoRow(label: "PRONOUNS", value: pronouns, action: {
                        print("Edit Pronouns")
                    })
                }
            }
            
            // Contact Info Section
            InfoSection(title: "Contact Info") {
                VStack(alignment: .leading) {
                    InfoRow(label: "EMAIL", value: email, action: {
                        print("Edit Email")
                    })
                    InfoRow(label: "PHONE", value: phone, action: {
                        print("Edit Phone")
                    })
                }
            }
            
            // Preference Info Section
            InfoSection(title: "Preference Info") {
                VStack {
                    HStack {
                        Text("COLOR MODE")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("", isOn: $isLightMode)
                        Text(isLightMode ? "LIGHT" : "DARK")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("NOTIFICATIONS")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("", isOn: $notificationsEnabled)
                        Text(notificationsEnabled ? "ON" : "OFF")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(1))
                    }
                }
            }
            
            // Retake Quiz Section
            VStack(spacing: 10) {
                Text("Want to redo your Moo’d profile?")
                    .font(.subheadline)
                Button(action: {
                    print("Retake Quiz Tapped")
                }) {
                    Text("RETAKE QUIZ")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 228/255, green: 225/255, blue: 243/255))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            Spacer()
            
            // Implement navbar- current one doesnt show up, its just here to prevent an error
            HStack {
                NavigationButton(iconName: "house.fill", label: "Home")
                    .frame(maxWidth: .infinity)
                NavigationButton(iconName: "book.fill", label: "Journal")
                    .frame(maxWidth: .infinity)
                NavigationButton(iconName: "chart.bar.fill", label: "Stats")
                    .frame(maxWidth: .infinity)
                NavigationButton(iconName: "gearshape.fill", label: "Settings")
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .frame(height: 60)
            .background(Color.lightblue.opacity(0.2))
        }
        .padding()
        .padding(.bottom, 50)
    }
}


let lightBlue = Color(red: 0.68, green: 0.85, blue: 0.90) //


struct InfoSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .bold()
            content
                .padding()
                .background(Color.lightblue.opacity(0.2))
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(label)
                    .font(.caption)
                Text(value)
                    .font(.subheadline)
                    .bold()
            }
            Spacer()
            Button(action: action) {
                Image(systemName: "pencil.circle.fill")
                   
            }
        }
    }
}

// Reusable Navigation Button- need to update with new UI
struct NavigationButton: View {
    let iconName: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(lightBlue.opacity(0.7))
            Text(label)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AccountView()
}
