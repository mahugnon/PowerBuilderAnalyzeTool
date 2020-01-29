Class {
	#name : #PWBNonUsedVariableBrowserModel,
	#superclass : #Object,
	#instVars : [
		'instAndVars',
		'insVarLocaVarArgs',
		'functions',
		'variables',
		'selected'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> functions [
	^ functions
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserModel >> initialize [
	super initialize.
	variables := OrderedCollection new.
	insVarLocaVarArgs := OrderedCollection new.
	functions := OrderedCollection new.
	instAndVars := OrderedCollection new
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> insVarLocaVarArgs [
	^ insVarLocaVarArgs
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> instAndVars [
	^ instAndVars
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> selected: anObject [
	selected := anObject.
	self updateNonUsedVariable
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> variables [
	^ variables
]
