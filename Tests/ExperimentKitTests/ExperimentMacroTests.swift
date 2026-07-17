import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ExperimentKitMacros)
import ExperimentKitMacros

let testMacros: [String: Macro.Type] = [
    "experiment": ExperimentMacro.self
]
#endif

final class ExperimentMacroTests: XCTestCase
{
    func testCapturesExpressionAndResult() throws
    {
        #if canImport(ExperimentKitMacros)
        assertMacroExpansion(
            """
            #experiment(two == four)
            """,
            expandedSource: """
            {
            	let value = two == four

            	return ExperimentKit.Experiment(
            		source: "two == four",
            		result: String(describing: value),
            		resultType: String(reflecting: Swift.type(of: value))
            	)
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("Macros require a host-platform test run")
        #endif
    }
}
