import Foundation
struct SevenSegmentDisplay {
  var height = 7
  var width = 6
  let dash = "🖱"
  let pipe = "🖱"
  var a = true
    var b = true
    var c = true
    var d = true
    var e = true
    var f = true
    var g = true

    init(number: UInt8){
      switch number {
        case 0:
          (a, b, c, d, e, f, g) = (true, true, true, true, true, true, false)
        case 1:
            (a, b, c, d, e, f, g) = (false, true, true, false, false, false, false)
        case 2:
              (a, b, c, d, e, f, g) = (true, true, false, true, true, false, true)
        case 3:
              (a, b, c, d, e, f, g) = (true, true, true, true, false, false, true)
        case 4:
              (a, b, c, d, e, f, g) = (false, true, true, false, false, true, true)
        case 5:
              (a, b, c, d, e, f, g) = (true, false, true, true, false, true, true)
        case 6:
              (a, b, c, d, e, f, g) = (true, false, true, true, true, true, true)
        case 7:
              (a, b, c, d, e, f, g) = (true, true, true, false, false, false, false)
        case 8:
              (a, b, c, d, e, f, g) = (true, true, true, true, true, true, true)
        case 9:
              (a, b, c, d, e, f, g) = (true, true, true, true, false, true, true)
        default:
              (a, b, c, d, e, f, g) = (false, false, false, false, false, false, false)

      }
  }
 
  init(height: Int, width: Int, number: UInt8) {
      self.init(number: number)
      self.height = height
      self.width = width
  }

  func toString() -> String {
    let maxCol = width - 1
    let maxLine = height - 1
    var result = [[String]](repeating: [String](repeating: " ", count: width), count: height )
      if a {
       for i in 0 ... maxCol{
         result[0][i] = dash
       }
      }
      if b {
       let begin = 0
       let end = begin + (maxLine / 2) 
       for i in begin ... end {
         result[i][maxCol] = pipe
       }
      }
      if c {
       let begin = maxLine / 2
       for i in begin ... maxLine {
         result[i][maxCol] = pipe
       }
      }
      if d {
       for i in 0 ... maxCol{
         result[maxLine][i] = dash
       }
      }
      if e {
       let begin = maxLine / 2
       for i in begin ... maxLine {
         result[i][0] = pipe
       }
      }
      if f {
       let begin = 0
       let end = begin + (maxLine / 2) 
       for i in begin ... end {
         result[i][0] = pipe
       }
      }
      if g {
       let mid = maxLine / 2
       for i in 0 ... maxCol{
         result[mid][i] = dash
       }
      }

      var strResult = ""
        for i in 0 ... maxLine{
            strResult += result[i].joined() + "\n"
        }
     return strResult 
  }
}

