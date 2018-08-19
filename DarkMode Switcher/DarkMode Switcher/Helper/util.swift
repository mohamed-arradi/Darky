import Foundation

@discardableResult
func runAppleScript(_ source: String) -> String? {
	return NSAppleScript(source: source)?.executeAndReturnError(nil).stringValue
}
