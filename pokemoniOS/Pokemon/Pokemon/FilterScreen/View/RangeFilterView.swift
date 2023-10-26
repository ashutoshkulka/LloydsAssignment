//
//  RangeSliderView.swift
//  Pokemon
//
//

import SwiftUI

struct RangeSliderView: View {
    @Binding var currentValue: ClosedRange<Float>
    var sliderBounds: ClosedRange<Int>

    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.gray.opacity(0.2))
                    .frame(height: 50)
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black, lineWidth: 1)
                    .frame(height: 50)
                GeometryReader { _ in
                    sliderView()
                }
            }
            .padding(.horizontal, 8)
    }

    @ViewBuilder private func sliderView() -> some View {
        HStack {
            Text("\(sliderBounds.lowerBound)")
            GeometryReader { geomentry in
                let sliderSize = geomentry.size
                let sliderViewYCenter = sliderSize.height / 2
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.slider)
                        .frame(height: 8)
                    ZStack {
                        let sliderBoundDifference = sliderBounds.count
                        let stepWidthInPixel = CGFloat(sliderSize.width) / CGFloat(sliderBoundDifference)

                        // Calculate Left Thumb initial position
                        let leftThumbLocation: CGFloat =
                                    $currentValue.wrappedValue.lowerBound ==
                                    Float(sliderBounds.lowerBound) ? 0
                        : CGFloat($currentValue.wrappedValue.lowerBound -
                                  Float(sliderBounds.lowerBound)) * stepWidthInPixel

                        // Calculate right thumb initial position
                        let rightThumbLocation =
                        $currentValue.wrappedValue.upperBound == Float(sliderBounds.upperBound) ?
                                CGFloat($currentValue.wrappedValue.upperBound) * stepWidthInPixel
                                :(CGFloat($currentValue.wrappedValue.upperBound) * stepWidthInPixel)

                        // Path between both handles
                        lineBetweenThumbs(from: .init(x: leftThumbLocation,
                                                      y: sliderViewYCenter),
                                                toPoint: .init(x: rightThumbLocation,
                                                      y: sliderViewYCenter))

                        // Left Thumb Handle
                        let leftThumbPoint = CGPoint(x: leftThumbLocation, y: sliderViewYCenter)
                        thumbView(position: leftThumbPoint, value: Float($currentValue.wrappedValue.lowerBound))
                            .highPriorityGesture(DragGesture().onChanged { dragValue in

                                let dragLocation = dragValue.location
                                let xThumbOffset = min(max(0, dragLocation.x), sliderSize.width)
                                let newValue = Float(sliderBounds.lowerBound) + Float(xThumbOffset / stepWidthInPixel)
                                // Stop the range thumbs from colliding each other
                                if newValue < $currentValue.wrappedValue.upperBound {
                                    $currentValue.wrappedValue = newValue...$currentValue.wrappedValue.upperBound
                                }
                            })
                        // Right Thumb Handle
                        thumbView(position: CGPoint(x: rightThumbLocation,
                                                    y: sliderViewYCenter),
                                                    value: $currentValue.wrappedValue.upperBound)
                            .highPriorityGesture(DragGesture().onChanged { dragValue in
                                let dragLocation = dragValue.location
                                let xThumbOffset = min(max(CGFloat(leftThumbLocation),
                                                    dragLocation.x), sliderSize.width)
                                var newValue = Float(xThumbOffset / stepWidthInPixel) // convert back the value bound
                                newValue = min(newValue, Float(sliderBounds.upperBound))

                                // Stop the range thumbs from colliding each other
                                if newValue > $currentValue.wrappedValue.lowerBound {
                                    $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...newValue
                                }
                            })
                    }
                }
            }
            Text("\(sliderBounds.upperBound)")
        }
        .padding()
    }

    @ViewBuilder func lineBetweenThumbs(from: CGPoint, toPoint: CGPoint) -> some View {
        Path { path in
            path.move(to: from)
            path.addLine(to: toPoint)
        }.stroke(Color.black, lineWidth: 8)
    }

    @ViewBuilder func thumbView(position: CGPoint, value: Float) -> some View {
        ZStack {
            Capsule(style: .circular)
                .frame(width: 50, height: 30)
                .foregroundColor(.black)
                .shadow(color: Color.black.opacity(0.16), radius: 8, x: 0, y: 2)
                .contentShape(Rectangle())
            Text(String(Int(value)))
                .foregroundColor(.white)
        }
        .position(x: position.x, y: position.y)
    }
}

#if DEBUG
struct RangedSliderView_Previews: PreviewProvider {
    @State static var sliderPosition: ClosedRange<Float> = 100...150
    static var previews: some View {
        RangeSliderView(currentValue: $sliderPosition, sliderBounds: 0...210)
    }
}
#endif
