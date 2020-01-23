Class {
	#name : #CIMCodeAnalyserBasicAdapter,
	#superclass : #Object,
	#instVars : [
		'pbModel',
		'content',
		'currentParent'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-Moose-adapters'
}

{ #category : #visiting }
CIMCodeAnalyserBasicAdapter class >> accept [
	^ self subclassResponsibility
]

{ #category : #initialization }
CIMCodeAnalyserBasicAdapter class >> adapt: aFamixClass [
	^ self subclasses
		detect: [ :sub | sub accept includes: aFamixClass class ]
		ifFound: [ :founded | founded new: aFamixClass ]
		ifNone: [ self halt ]
]

{ #category : #initialization }
CIMCodeAnalyserBasicAdapter class >> new: aFamixClass [
	^ self new pbModel: aFamixClass
]

{ #category : #accessing }
CIMCodeAnalyserBasicAdapter >> adaptPbModel [
]

{ #category : #accessing }
CIMCodeAnalyserBasicAdapter >> content [
	^ content
]

{ #category : #metrics }
CIMCodeAnalyserBasicAdapter >> cyclomaticComplexity [
	^ pbModel cyclomaticComplexity
]

{ #category : #initialization }
CIMCodeAnalyserBasicAdapter >> initialize [
	super initialize.
	content := {}
]

{ #category : #accessing }
CIMCodeAnalyserBasicAdapter >> name [
	^ pbModel name
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserBasicAdapter >> numberOfIncomingInvocations [
  ^self content inject: 0 into: [:sum :each |  sum + each numberOfIncomingInvocations ]
]

{ #category : #metrics }
CIMCodeAnalyserBasicAdapter >> numberOfLinesOfCode [
	^ pbModel numberOfLinesOfCode
]

{ #category : #accessing }
CIMCodeAnalyserBasicAdapter >> pbModel [
	^ pbModel
]

{ #category : #accessing }
CIMCodeAnalyserBasicAdapter >> pbModel: anObject [
	pbModel := anObject
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserBasicAdapter >> roassalPresenter [
	^ self subclassResponsibility
]
