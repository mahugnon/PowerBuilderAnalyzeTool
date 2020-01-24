Class {
	#name : #CIMCodeAnalyserFmxUserObjectAdapter,
	#superclass : #CIMCodeAnalyserBasicAdapter,
	#category : #'PowerBuilderAnalyzeTool-CallTree-Moose-adapters'
}

{ #category : #visiting }
CIMCodeAnalyserFmxUserObjectAdapter class >> accept [
	^ {FamixPWBUserObject. FamixPWBCustomType. FamixPWBWindow}
]

{ #category : #metrics }
CIMCodeAnalyserFmxUserObjectAdapter >> adaptPbModel [
	^ ((((pbModel methods asSet
		reject: [ :method | method name = 'constructor' or: method name = 'destroy' ])
		collect: [ :each | CIMCodeAnalyserBasicAdapter adapt: each ])
		flatCollect: #withAllOutgoingInvocationCandidates)
		collect: [ :each | CIMCodeAnalyserBasicAdapter adapt: each ])
		asOrderedCollection
		sort: [ :a :b | a numberOfLinesOfCode > b numberOfLinesOfCode ]
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> allIncomingReferencesSenders [
  | scan scanTop |
  scan := self incomingReferencesSenders asOrderedCollection.
  scanTop := 1.
  [ scanTop > scan size ] whileFalse: [ scan addAll: (((scan at: scanTop) incomingReferencesSenders collect: #target) reject: [:userObject |  (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
        scanTop := scanTop + 1 ].
  ^scan
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> allOutgoingReferencesTarget [
  | scan scanTop |
  scan := self outgoingReferencesTarget asOrderedCollection.
  scanTop := 1.
  [ scanTop > scan size ] whileFalse: [ scan addAll: (((scan at: scanTop) outgoingReferencesTarget collect: #target) reject: [:userObject |  (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
        scanTop := scanTop + 1 ].
  ^scan
]

{ #category : #api }
CIMCodeAnalyserFmxUserObjectAdapter >> allReferences [
  | result |
  result := Set new.
  result addAll: self allIncomingReferencesSenders.
  result addAll: self allOutgoingReferencesTarget.
  ^CIMCodeAnalyserBasicAdapter adapt: (FAMIXTypeGroup withAll: (result reject: [:obj |  obj name = 'uo_datawindow' ]))
]

{ #category : #metrics }
CIMCodeAnalyserFmxUserObjectAdapter >> cyclomaticComplexity [
	^ self content 
		inject: 0
		into: [ :sum :each | sum + each cyclomaticComplexity ]
]

{ #category : #api }
CIMCodeAnalyserFmxUserObjectAdapter >> incomingReferencesSenders [
  ^((pbModel incomingReferencesSenders collectAsSet: #from) reject: [:userObject |  self toSkipForNow: userObject ]) asSet
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> numberOfMethods [
	^ self content size
]

{ #category : #accessing }
CIMCodeAnalyserFmxUserObjectAdapter >> outgoingInvocationsTargets [
	^ self content collect: #outgoingInvocationsTargets
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> outgoingReferencesTarget [
  ^((pbModel outgoingReferencesTarget collectAsSet: #target) reject: [:userObject |  self toSkipForNow: userObject ]) asSet
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> roassalPresenter [
	^ CIMFunctionInvocationsPresenter
]

{ #category : #accessing }
CIMCodeAnalyserFmxUserObjectAdapter >> setContent [
	content := self adaptPbModel
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> toSkipForNow: anObject [
	self flag: 'To be considered later'.
	^ {FamixPWBWindow.
	FamixPWBCustomType.
	FamixPWBDataWindow.
	FamixPWBFunction.
	FamixPWBEvent} includes: anObject class
]
