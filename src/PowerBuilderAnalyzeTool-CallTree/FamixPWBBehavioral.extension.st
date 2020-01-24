Extension { #name : #FamixPWBBehavioral }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> allOutgoingInvocationCandidates [
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

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> content [
	content ifNil: [ content := {} ].
	^ content
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> incomingInvocationsSenders [
	^ self incomingInvocations collectAsSet: #sender
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> noisyMethods [
	^ #('sort' 'len' 'setnull' 'string' 'long' 'rowcount' 'Find' 'getitemdate' 'retrieve' 'isnull' 'setsort' 'getitemstring' 'isnull' 'left' 'setrow' 'upprt' 'trim' 'right' 'now' 'datetime' 'relativedate' 'today' 'triggerevent' 'replace' 'long' 'isnumber' 'getitemnumber')
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> numberOfIncomingInvocations [
	^ self incomingInvocationsSenders size
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> outgoingInvocationsCandidates [
	^ (self outgoingInvocations flatCollect: #candidates) asSet
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> roassalPresenter [
	^ CIMFunctionInvocationsPresenter
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> setContent [
	content := self allOutgoingInvocationCandidates
		add: self;
		yourself
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBBehavioral >> withAllOutgoingInvocationCandidates [
	^ self allOutgoingInvocationCandidates
		add: self;
		yourself
]
