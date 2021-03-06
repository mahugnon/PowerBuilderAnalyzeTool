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
			do: [ self baselineOfPowerBuilderParser: spec.
			self baselineOfRoassal3: spec.
			self baselineOfColorsExtensions: spec.
			spec
				package: 'Duplication';
				package: 'Duplication-Detection';
				package: 'Duplication-Entities';
				package: 'PowerBuilderAnalyzeTool-Models';
				package: 'PowerBuilderAnalyzeTool-Query';
				package: 'PowerBuilderAnalyzeTool-DuplicationGUI';
				package: 'PowerBuilderAnalyzeTool-CallTree';
				package: 'PowerBuilderAnalyzeTool-Utils';
					package: 'PowerBuilderAnalyzeTool-PWBCritics';
				package: 'FamixTags';
				package: 'PowerBuilderAnalyzeTool'
					with: [ spec
						requires:
							#('PowerBuilderParser' 'Roassal3' 'PowerBuilderAnalyzeTool-DuplicationGUI' 'PowerBuilderAnalyzeTool-CallTree' 'ColorsExtensions') ] ].
		"package: 'PowerBuilderAnalyzeTool-Tests'
			with: [ spec requires: #(PowerBuilderAnalyzeTool) ]"
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
				repository: 'github://moosetechnology/PowerBuilderParser:master/src' ]
]

{ #category : #baselines }
BaselineOfPowerBuilderAnalyzeTool >> baselineOfRoassal2Spec2: spec [
	spec
		baseline: 'Roassal2Spec2'
		with: [ spec repository: 'github://mahugnon/Roassal2Spec2:master/src' ]
]

{ #category : #baselines }
BaselineOfPowerBuilderAnalyzeTool >> baselineOfRoassal3: spec [
	spec
		baseline: 'Roassal3'
		with: [ spec repository: 'github://ObjectProfile/Roassal3' ]
]
