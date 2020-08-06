import curses
import Foundation
import SwiftCursesTerm

struct ClockView {
    let colonPad: Int
    var segmentHeight: Int
    var segmentWidth: Int
    var term: SwiftCursesTerm
    var hourSeg1, hourSeg2, minSeg1, minSeg2, secSeg1, secSeg2: SCTWindowId

    init(term: SwiftCursesTerm, segmentHeight: Int, segmentWidth: Int, colonPad: Int = 1) {
        self.term = term
        self.segmentHeight = segmentHeight
        self.segmentWidth = segmentWidth
        self.colonPad = colonPad

        hourSeg1 = term.newWindow(height: segmentHeight, width:  segmentWidth, line: 0, column: 0)
        hourSeg2 = term.newWindow(height: segmentHeight, width:  segmentWidth, line: 0, column: segmentWidth)

        //Leaving space for colon
        term.addStrTo(content: "🀆", line: segmentHeight / 4, column: (segmentWidth * 2) + (colonPad / 2), refresh: true)
        term.addStrTo(content: "🀆", line: segmentHeight * 3 / 4, column: (segmentWidth * 2) + (colonPad / 2 ))

        minSeg1 = term.newWindow(height: segmentHeight, width:  segmentWidth, line: 0, column: (2 * segmentWidth) + colonPad )
        minSeg2 = term.newWindow(height: segmentHeight, width:  segmentWidth, line: 0, column: (3 * segmentWidth) + colonPad )

        //Leaving space for colon
        term.addStrTo(content: "🀆", line: segmentHeight / 4, column: (segmentWidth * 4) + colonPad + (colonPad / 2))
        term.addStrTo(content: "🀆", line: segmentHeight * 3 / 4, column: (segmentWidth * 4) + colonPad + (colonPad / 2 ))

        secSeg1 = term.newWindow(height: segmentHeight, width:  segmentWidth, line: 0, column: (4 * segmentWidth) + (colonPad * 2))
        secSeg2 = term.newWindow(height: segmentHeight, width:  segmentWidth, line: 0, column: (5 * segmentWidth) + (colonPad * 2))

        let segmentHeightDisplay = segmentHeight - 1
        let segmentWidthDisplay = segmentWidth - 1
        let h1 = SevenSegmentDisplay(height: segmentHeightDisplay , width: segmentWidthDisplay, number: UInt8(8) )
        let h2 = SevenSegmentDisplay(height: segmentHeightDisplay , width: segmentWidthDisplay, number: UInt8(8) )
        let m1 = SevenSegmentDisplay(height: segmentHeightDisplay , width: segmentWidthDisplay, number: UInt8(8) )
        let m2 = SevenSegmentDisplay(height: segmentHeightDisplay , width: segmentWidthDisplay, number: UInt8(8) )
        let s1 = SevenSegmentDisplay(height: segmentHeightDisplay , width: segmentWidthDisplay, number: UInt8(8) )
        let s2 = SevenSegmentDisplay(height: segmentHeightDisplay , width: segmentWidthDisplay, number: UInt8(8) )

        term.addStrTo(window: hourSeg1, content: h1.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: hourSeg2, content: h2.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: minSeg1, content: m1.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: minSeg2, content: m2.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: secSeg1, content: s1.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: secSeg2, content: s2.toString(), line: 0, column: 0, refresh: true)

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        let currDate = formatter.string(from: Date())
        let green = term.defineColorPair(foreground: CursesColor.clear, background: CursesColor.green)
        term.setAttributes([TextAttribute.bold, TextAttribute.underline, TextAttribute.reverse], colorPair: green)
        term.addStrTo(content: currDate, line: segmentHeight + 1, column: ((segmentWidth * 6) + (colonPad * 2)) / 2 - (currDate.count / 2), refresh: true)
    }

    func display(hours: Int, minutes: Int, seconds: Int) {
        let segmentHeightDisplay = segmentHeight - 1
        let segmentWidthDisplay = segmentWidth - 1

        let h1 = SevenSegmentDisplay(height: segmentHeightDisplay, width: segmentWidthDisplay, number: UInt8(hours / 10) )
        let h2 = SevenSegmentDisplay(height: segmentHeightDisplay, width: segmentWidthDisplay, number: UInt8(hours % 10))
        let m1 = SevenSegmentDisplay(height: segmentHeightDisplay, width: segmentWidthDisplay, number: UInt8(minutes / 10) )
        let m2 = SevenSegmentDisplay(height: segmentHeightDisplay, width: segmentWidthDisplay, number: UInt8(minutes % 10) )
        let s1 = SevenSegmentDisplay(height: segmentHeightDisplay, width: segmentWidthDisplay, number: UInt8(seconds / 10) )
        let s2 = SevenSegmentDisplay(height: segmentHeightDisplay, width: segmentWidthDisplay, number: UInt8(seconds % 10) )

        term.addStrTo(window: hourSeg1, content: h1.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: hourSeg2, content: h2.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: minSeg1, content: m1.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: minSeg2, content: m2.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: secSeg1, content: s1.toString(), line: 0, column: 0, refresh: true)
        term.addStrTo(window: secSeg2, content: s2.toString(), line: 0, column: 0, refresh: true)
    }
}
