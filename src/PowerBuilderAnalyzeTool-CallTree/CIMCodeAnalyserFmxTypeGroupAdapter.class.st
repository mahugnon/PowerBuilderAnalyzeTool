Class {
	#name : #CIMCodeAnalyserFmxTypeGroupAdapter,
	#superclass : #CIMCodeAnalyserBasicAdapter,
	#category : #'PowerBuilderAnalyzeTool-CallTree-Moose-adapters'
}

{ #category : #visiting }
CIMCodeAnalyserFmxTypeGroupAdapter class >> accept [
	^ {FAMIXTypeGroup.
	FAMIXMethodGroup}
]

{ #category : #accessing }
CIMCodeAnalyserFmxTypeGroupAdapter >> adaptPbModel [
	^ (pbModel
		collect: [ :each | CIMCodeAnalyserBasicAdapter adapt: each ])
		asOrderedCollection
		sorted: [ :a :b | a numberOfLinesOfCode > b numberOfLinesOfCode ]
]

{ #category : #metrics }
CIMCodeAnalyserFmxTypeGroupAdapter >> cyclomaticComplexity [
	^ self content 
		inject: 0
		into: [ :sum :each | sum + each cyclomaticComplexity ]
]

{ #category : #metrics }
CIMCodeAnalyserFmxTypeGroupAdapter >> numberOfLinesOfCode [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfLinesOfCode ]
]

{ #category : #accessing }
CIMCodeAnalyserFmxTypeGroupAdapter >> outgoingInvocations [
	^ self content collect: #outgoingInvocations
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxTypeGroupAdapter >> roassalPresenter [
	^ CIMUserObjectReferencesPresenter
]

{ #category : #accessing }
CIMCodeAnalyserFmxTypeGroupAdapter >> setContent [
	content := self adaptPbModel
]
