Class {
	#name : #BaselineOfPowerBuilderAnalyzeTool,
	#superclass : #BaselineOf,
	#category : #BaselineOfPowerBuilderAnalyzeTool
}

{ #category : #baselines }
BaselineOfPowerBuilderAnalyzeTool >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self baselineOfRoassal2Spec2: spec.
			self baselineOfPowerBuilderParser: spec.
			self baselineOfColorsExtensions: spec.
			spec
				package: 'Duplication';
				package: 'Duplication-Detection';
				package: 'Duplication-Entities';
				package: 'PowerBuilderAnalyzeTool-Models';
				package: 'PowerBuilderAnalyzeTool-Query';
				package: 'PowerBuilderAnalyzeTool-DuplicationGUI';
				package: 'PowerBuilderAnalyzeTool-CallTree';
				package: 'PowerBuilderAnalyzeTool'
					with: [ spec
						requires:
							#('PowerBuilderParser' 'Roassal2Spec2' 'PowerBuilderAnalyzeTool-DuplicationGUI' 'PowerBuilderAnalyzeTool-CallTree' 'ColorsExtensions') ] ]
]

{ #category : #baselines }
BaselineOfPowerBuilderAnalyzeTool >> baselineOfColorsExtensions: spec [
	spec
		baseline: 'ColorsExtensions'
		with: [ spec
				repository: 'github://pharo-contributions/ColorsExtensions:v1.x.x/src' ]
]

{ #category : #baselines }
BaselineOfPowerBuilderAnalyzeTool >> baselineOfPowerBuilderParser: spec [
	spec
		baseline: 'PowerBuilderParser'
		with: [ spec
				repository: 'github://moosetechnology/PowerBuilderParser:LastestMoose8/src' ]
]

{ #category : #baselines }
BaselineOfPowerBuilderAnalyzeTool >> baselineOfRoassal2Spec2: spec [
	spec
		baseline: 'Roassal2Spec2'
		with: [ spec repository: 'github://mahugnon/Roassal2Spec2:master/src' ]
]
