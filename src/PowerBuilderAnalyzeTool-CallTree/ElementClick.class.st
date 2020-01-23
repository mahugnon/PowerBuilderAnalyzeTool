Class {
	#name : #ElementClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-Interaction'
}

{ #category : #hooks }
ElementClick >> initializeElement: element [
  element announcer when: TRMouseClick do: [ model mooseModelPresenterSelectedItem: element model ]
]

{ #category : #accessing }
ElementClick >> model: aCollection [ 
	model := aCollection
]
