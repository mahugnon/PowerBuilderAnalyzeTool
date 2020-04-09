Extension { #name : #FamixPWBmajorObject }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> incomingInvocationsSenders: anInteger [
	| totalResult levelResult level scan |
	totalResult := self incomingInvocationsSenders.
	levelResult := totalResult.
	level := 1.
	scan := 0.
	[ level < anInteger and: [ scan < totalResult size ] ]
		whileTrue: [ level := level + 1.
			scan := totalResult size.
			levelResult := levelResult flatCollect: #incomingInvocationsSenders.
			totalResult addAll: levelResult ].
	^ totalResult asOrderedCollection
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> incomingInvocationsSenders: anInteger expectFromMethodsOfType: aCollection [
	| totalResult levelResult level scan |
	totalResult := self incomingInvocationsSenders
		reject: [ :each | aCollection includes: each class ].
	levelResult := totalResult.
	level := 1.
	scan := 0.
	[ level < anInteger and: [ scan < totalResult size ] ]
		whileTrue: [ level := level + 1.
			scan := totalResult size.
			levelResult := (levelResult
				flatCollect: #incomingInvocationsSenders)
				reject: [ :each | aCollection includes: each class ].
			totalResult addAll: levelResult ].
	^ totalResult asOrderedCollection
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> methodsInvocationsSendersTypes [
	^ self methodsIncomingInvocationsSenders collectAsSet: #class
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> printString [
	^ self name
]
