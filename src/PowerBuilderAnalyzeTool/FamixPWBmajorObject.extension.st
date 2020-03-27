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
			levelResult := (levelResult
				flatCollect: #incomingInvocationsSenders)
				"reject: [ :sender | totalResult includes: sender ]".
			totalResult addAll: levelResult ].
	"totalResult add: self."
	^ totalResult asOrderedCollection
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> incomingInvocationsSendersWith: aCollection [
	| result |
	result := self incomingInvocationsSenders.
	result addAll: (aCollection flatCollect: #incomingInvocationsSenders).
	"reject: [ :sender | result includes: sender ]"
	"result add: self."
	^ result asOrderedCollection
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> printString [
	^ self name
]
