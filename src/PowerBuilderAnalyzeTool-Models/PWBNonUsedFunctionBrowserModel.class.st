Class {
	#name : #PWBNonUsedFunctionBrowserModel,
	#superclass : #Object,
	#instVars : [
		'pbModel',
		'selected'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBNonUsedFunctionBrowserModel >> pbModel [
	^ pbModel
]

{ #category : #accessing }
PWBNonUsedFunctionBrowserModel >> refreshPbModel [
	pbModel := QueryDeadMethods runOn: selected
]

{ #category : #accessing }
PWBNonUsedFunctionBrowserModel >> selected: anObject [
	selected := anObject.
	self refreshPbModel
]
