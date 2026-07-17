import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ExperimentKitPlugin: CompilerPlugin
{
	let providingMacros: [Macro.Type] = [
		ExperimentMacro.self
	]
}
