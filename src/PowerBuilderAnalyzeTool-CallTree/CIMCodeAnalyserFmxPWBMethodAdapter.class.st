Class {
	#name : #CIMCodeAnalyserFmxPWBMethodAdapter,
	#superclass : #CIMCodeAnalyserBasicAdapter,
	#category : #'PowerBuilderAnalyzeTool-CallTree-Moose-adapters'
}

{ #category : #visiting }
CIMCodeAnalyserFmxPWBMethodAdapter class >> accept [
	^ {FamixPWBTrigger.
	FamixPWBFunction.
	FamixPWBEvent.
	FamixPWBSubRoutine}
]
