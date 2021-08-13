# Deer Design System (DDS)

This is a design system of @mtj0928, by @mtj0928, for @mtj0928.

## Color
You can easily access colors defined in DDS.

```swift
// UIColor or NSColor
DDSColor.primaryTextColor.color
    
// SwiftUI.Color
DDSColor.primaryTextColor.swiftUIColor
```

## Text 
You can easily access labels in DDS.
```swift
// UILabel
UILabel.dds
    .create(for: .footnote, weight: .regular)

// Text
Text("text")
    .preferredFont(for: .footnote, weight: .regular)

```
