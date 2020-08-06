import Foundation
import SwiftCursesTerm

struct ClockController {
    var clockView: ClockView
    var term = SwiftCursesTerm()

    init(segmentHeight: Int, segmentWidth: Int, colonPad: Int) {
        clockView = ClockView(term: term, segmentHeight: segmentHeight, segmentWidth: segmentWidth, colonPad: colonPad)
    }

    func run() {
        defer { term.shutdown() }
        term.noDelay(true)
        while (getch() == ERR) {
            let now = Date()
            let calendar = Calendar.current

            let hours = calendar.component(.hour, from: now)
            let minutes = calendar.component(.minute, from: now)
            let seconds = calendar.component(.second, from: now)
            clockView.display(hours: hours, minutes: minutes, seconds: seconds)
            napms(1000)
        }
    }
}
