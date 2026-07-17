@freestanding(expression)
public macro experiment<T>(_ expression: T) -> Experiment = #externalMacro(
	module: "ExperimentKitMacros",
	type: "ExperimentMacro"
)
