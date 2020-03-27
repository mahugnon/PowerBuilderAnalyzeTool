Extension { #name : #FamixPWBmajorObject }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> allIncomingReferencesSenders [
	| scan scanTop |
	scan := FAMIXTypeGroup withAll: self incomingReferencesSenders.
	scanTop := 1.
	[ scanTop > scan size ]
		whileFalse: [ scan
				addAll:
					((scan at: scanTop) incomingReferencesSenders
						reject:
							[ :userObject | (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
			scanTop := scanTop + 1 ].
	^ scan
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> allOutgoingReferencesTarget [
	| scan scanTop |
	scan := self outgoingReferencesTarget asOrderedCollection.
	scanTop := 1.
	[ scanTop > scan size ]
		whileFalse: [ scan
				addAll:
					((scan at: scanTop) outgoingReferencesTarget
						reject:
							[ :userObject | (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
			scanTop := scanTop + 1 ].
	^ scan
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> allReferences [
	| result |
	result := Set new.
	result addAll: self allIncomingReferencesSenders.
	result addAll: self allOutgoingReferencesTarget.
	^ FAMIXTypeGroup
		withAll: (result reject: [ :obj | self isGenerallyUsed: obj ])
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> clean: aCollection [
	^ aCollection reject: [ :each | self toReject includes: each name ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> content [
	content ifNil: [ self setContent ].
	^ content
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> incomingReferencesSenders [
	^ ((self incomingReferences collectAsSet: #from)
		reject: [ :userObject | self toSkipForNow: userObject ]) asSet
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> isGenerallyUsed: obj [
	^ {'uo_datawindow' . 'uo_traitement' . 'uo_parametres' . 'uo_dw_detail'.
	'uo_liste_detail_en_partage'} includes: obj name
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> numberOfIncomingInvocations [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfIncomingInvocations ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> numberOfMethods [
	^ self content size
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> outgoingInvocationsSenders [
	^ self content collect: #outgoingInvocationsSenders
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> outgoingReferencesTarget [
	^ ((self outgoingReferences collectAsSet: #target)
		reject: [ :userObject | self toSkipForNow: userObject ]) asSet
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> roassalPresenter [
	^ CIMUserObjectReferencesPresenter
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> setContent [
	content := ((self methods asSet
		reject: [ :method | method isNoisyMethod ])
		flatCollect: #withAllOutgoingInvocationCandidates)
		asOrderedCollection
		sort: [ :a :b | a numberOfLinesOfCode > b numberOfLinesOfCode ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> toReject [
	^ {'uo_traitement' . 'uo_datawindow'}
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> toSkipForNow: anObject [
	self flag: 'To be considered later'.
	^ {FamixPWBCustomType.
	FamixPWBFunction.
	FamixPWBEvent} includes: anObject class
]
