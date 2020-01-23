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

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxPWBMethodAdapter >> allOutgoingInvocationCandidates [
	| scan scanTop |
	scan := OrderedCollection
		withAll:
			(self outgoingInvocationsCandidates
				reject: [ :method | self noisyMethods includes: method name asLowercase ])
				asSet.
	scanTop := 1.
	[ scanTop > scan size ]
		whileFalse: [ scan
				addAll:
					(((scan at: scanTop) outgoingInvocations flatCollect: #candidates)
						reject: [ :method | 
							(self noisyMethods includes: method name asLowercase)
								or: [ scan includes: method ] ]).
			scanTop := scanTop + 1 ].
	^ scan
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxPWBMethodAdapter >> incomingInvocations [
  ^self pbModel incomingInvocations collectAsSet: #sender
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxPWBMethodAdapter >> noisyMethods [
	^ #('sort' 'len' 'setnull' 'string' 'long' 'rowcount' 'Find' 'getitemdate' 'retrieve' 'isnull' 'setsort' 'getitemstring' 'isnull' 'left' 'setrow' 'upprt' 'trim' 'right' 'now' 'datetime' 'relativedate' 'today' 'triggerevent' 'replace' 'long' 'isnumber' 'getitemnumber')
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxPWBMethodAdapter >> numberOfIncomingInvocations [
  ^self pbModel incomingInvocations size
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxPWBMethodAdapter >> numberOfInvocationToward: aCIMCodeAnalyserFmxPWBMethodAdapter [
	^ self outgoingInvocationsCandidatesName
		count: [ :each | each = aCIMCodeAnalyserFmxPWBMethodAdapter ]
]

{ #category : #accessing }
CIMCodeAnalyserFmxPWBMethodAdapter >> outgoingInvocationsCandidates [
	^ (pbModel outgoingInvocations flatCollect: #candidates) asSet
]

{ #category : #accessing }
CIMCodeAnalyserFmxPWBMethodAdapter >> outgoingInvocationsCandidatesName [
	^ (pbModel outgoingInvocations flatCollect: #candidates)
		collect: #name
]

{ #category : #accessing }
CIMCodeAnalyserFmxPWBMethodAdapter >> parentType [
	^ pbModel parentType
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxPWBMethodAdapter >> roassalPresenter [
	^ CIMFunctionInvocationsPresenter
]

{ #category : #accessing }
CIMCodeAnalyserFmxPWBMethodAdapter >> setContent [
  content := (self allOutgoingInvocationCandidates asOrderedCollection collect: [:each |  CIMCodeAnalyserBasicAdapter adapt: each ])
     add: self;
     yourself
]

{ #category : #'as yet unclassified' }
CIMCodeAnalyserFmxPWBMethodAdapter >> withAllOutgoingInvocationCandidates [
	^ self allOutgoingInvocationCandidates
		add: self pbModel;
		yourself
]
