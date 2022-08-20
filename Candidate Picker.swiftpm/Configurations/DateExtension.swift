import Foundation

// Menambah fungsi baru untuk kelas Date()
extension Date {
    // Menghitung selisih dari kedua tanggal
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    // Mengambil data umur melalui tanggal
    static func getAgeFromBirthdate(birthdate: Date) -> Int {
        return Int((Date() - birthdate) / 31557600)
    }
}
