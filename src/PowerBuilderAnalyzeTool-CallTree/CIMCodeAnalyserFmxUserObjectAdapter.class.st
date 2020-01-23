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
CIMCodeAnalyserFmxUserObjectAdapter >> allIncomingReferences [
  | scan scanTop |
  scan := self incomingReferences asOrderedCollection.
  scanTop := 1.
  [ scanTop > scan size ] whileFalse: [ scan addAll: (((scan at: scanTop) incomingReferences collect: #target) reject: [:userObject |  (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
        scanTop := scanTop + 1 ].
  ^scan
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> allOutgoingReferences [
  | scan scanTop |
  scan := self outgoingReferences asOrderedCollection.
  scanTop := 1.
  [ scanTop > scan size ] whileFalse: [ scan addAll: (((scan at: scanTop) outgoingReferences collect: #target) reject: [:userObject |  (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
        scanTop := scanTop + 1 ].
  ^scan
]

{ #category : #api }
CIMCodeAnalyserFmxUserObjectAdapter >> allReferences [
  | result |
  result := Set new.
  result addAll: self allIncomingReferences.
  result addAll: self allOutgoingReferences.
  ^CIMCodeAnalyserBasicAdapter adapt: (FAMIXTypeGroup withAll: (result reject: [:obj |  obj name = 'uo_datawindow' ]))
]

{ #category : #metrics }
CIMCodeAnalyserFmxUserObjectAdapter >> cyclomaticComplexity [
	^ self content 
		inject: 0
		into: [ :sum :each | sum + each cyclomaticComplexity ]
]

{ #category : #api }
CIMCodeAnalyserFmxUserObjectAdapter >> incomingReferences [
  ^((pbModel incomingReferences collectAsSet: #from) reject: [:userObject |  self toSkipForNow: userObject ]) asSet
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> numberOfMethods [
	^ self content size
]

{ #category : #accessing }
CIMCodeAnalyserFmxUserObjectAdapter >> outgoingInvocations [
	^ self content collect: #outgoingInvocations
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxUserObjectAdapter >> outgoingReferences [
  ^((pbModel outgoingReferences collectAsSet: #target) reject: [:userObject |  self toSkipForNow: userObject ]) asSet
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
  ^{FamixPWBWindow . 
  FamixPWBCustomType . 
  FamixPWBDataWindow . 
  FamixPWBFunction} includes: anObject class
]
