Class {
	#name : #OptionParameters,
	#superclass : #Object,
	#instVars : [
		'action',
		'maxLevel'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
OptionParameters >> action: aString [
	action := aString
]

{ #category : #'accessing ' }
OptionParameters >> maxLevel: anInteger [
	maxLevel := anInteger
]
