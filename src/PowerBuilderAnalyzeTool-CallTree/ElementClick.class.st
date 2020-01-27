Class {
	#name : #ElementClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model',
		'currentFocus'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-Interaction'
}

{ #category : #hooks }
ElementClick >> colorSelectedElement: element [
	currentFocus
		ifNotNil: [ currentFocus color: (ColorObject colorFor: currentFocus model) ].
	currentFocus := element.
	^ currentFocus color: Color paleGreen
]

{ #category : #hooks }
ElementClick >> initializeElement: element [
	element announcer
		when: TRMouseClick
		do: [ model mooseModelPresenterSelectedItem: element model.
			self colorSelectedElement: element ]
]

{ #category : #accessing }
ElementClick >> model: aCollection [ 
	model := aCollection
]
