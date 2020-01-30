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

{ #category : #utility }
PWBNonUsedVariableBrowserModel >> instOrVarFor: aString [
	^ instAndVars at: aString
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> selected: anObject [
	selected := anObject.
	self updateNonUsedVariable
]

{ #category : #utility }
PWBNonUsedVariableBrowserModel >> updateNonUsedVariable [
	| query |
	query := QueryDeadVariables runOn: selected.
	instAndVars := Dictionary new.
	instAndVars
		at: 'Attributs' put: query instanceVariables;
		at: 'Variables' put: {'Local Variables' . 'Arguments'}
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> variables [
	^ variables
]
