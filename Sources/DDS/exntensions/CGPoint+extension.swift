import SwiftUI

extension CGPoint {

    public func distance(with point: CGPoint) -> CGFloat {
        sqrt(pow(point.x - x, 2) + pow(point.y - y, 2))
    }
}
