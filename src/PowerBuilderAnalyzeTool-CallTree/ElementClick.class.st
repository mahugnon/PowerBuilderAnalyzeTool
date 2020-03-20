Class {
	#name : #ElementClick,
	#superclass : #RSInteraction,
	#instVars : [
		'model',
		'currentFocus',
		'application'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-Interaction'
}

{ #category : #accessing }
ElementClick >> application [
	^ application
]

{ #category : #accessing }
ElementClick >> application: aPWBApplication [
	application := aPWBApplication
]

{ #category : #hooks }
ElementClick >> initializeElement: element [
	element announcer
		when: TRMouseClick
		do: [ model selected: element model.
			self colorSelectedElement: element.
			self application globallySelect: element model
			"self halt" ]
]

{ #category : #accessing }
ElementClick >> model: aCollection [ 
	model := aCollection
]

{ #category : #hooks }
ElementClick >> onShape: element [
	element announcer
		when: TRMouseClick
		do: [ model selected: element model.
			self colorSelectedElement: element.
			self application globallySelect: element model
			"self halt" ]
]
