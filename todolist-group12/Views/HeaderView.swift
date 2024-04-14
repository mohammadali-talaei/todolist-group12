/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Implemented the HeaderView SwiftUI component
            - Designed the layout and appearance of the header with a title, subtitle, and background color
            - Applied rotation effect to the background shape with a specified angle
*/

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))

            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()

                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
            .padding(.top, 80)
        }
        .frame(width: UIScreen.main.bounds.width * 3,
               height: 350)
        .offset(y: -150)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title",
                   subtitle: "Subtitle",
                   angle: 15,
                   background: .blue)
    }
}
