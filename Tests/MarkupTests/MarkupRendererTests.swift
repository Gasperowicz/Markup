import XCTest
@testable import Markup

class MarkupRendererTests: XCTestCase {
    let baseFont = Font.systemFont(ofSize: 16)
	var sut: MarkupRenderer!

    override func setUp() {
        super.setUp()
        sut = MarkupRenderer(baseFont: baseFont)
    }

	func testPlainText_render_rendersPlainText() {
		// given
		let input = "hello there"
		let expected = NSAttributedString(string: "hello there",
		                                  attributes: [NSFontAttributeName: baseFont])

		// when
		let result = sut.render(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testStrongText_render_rendersBoldText() {
		// given
		let input = "hello *there*"
		let boldFont = baseFont.boldFont()!
		let expected = [
			NSAttributedString(string: "hello ",
			                   attributes: [NSFontAttributeName: baseFont]),
			NSAttributedString(string: "there",
			                   attributes: [NSFontAttributeName: boldFont])
		].joined()

		// when
		let result = sut.render(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testEmphasizedText_render_rendersItalicText() {
		// given
		let input = "hello _there_"
		let italicFont = baseFont.italicFont()!
		let expected = [
			NSAttributedString(string: "hello ",
			                   attributes: [NSFontAttributeName: baseFont]),
			NSAttributedString(string: "there",
			                   attributes: [NSFontAttributeName: italicFont])
		].joined()

		// when
		let result = sut.render(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testDeletedText_render_rendersStrikethroughText() {
		// given
		let input = "hello ~there~"
		let strikethroughAttributes: [String: Any] = [
			NSFontAttributeName: baseFont,
			NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
			NSBaselineOffsetAttributeName: 0
		]
		let expected = [
			NSAttributedString(string: "hello ",
			                   attributes: [NSFontAttributeName: baseFont]),
			NSAttributedString(string: "there",
			                   attributes: strikethroughAttributes)
			].joined()

		// when
		let result = sut.render(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testStrongEmphasizedText_render_rendersBoldItalicText() {
		// given
		let input = "hello *_there_* _*there*_"
		let boldItalicFont = baseFont.boldFont()!.italicFont()!
		let expected = [
			NSAttributedString(string: "hello ",
			                   attributes: [NSFontAttributeName: baseFont]),
			NSAttributedString(string: "there",
			                   attributes: [NSFontAttributeName: boldItalicFont]),
			NSAttributedString(string: " ",
			                   attributes: [NSFontAttributeName: baseFont]),
			NSAttributedString(string: "there",
			                   attributes: [NSFontAttributeName: boldItalicFont])
		].joined()

		// when
		let result = sut.render(text: input)

		// then
		XCTAssertEqual(result, expected)
	}
}
