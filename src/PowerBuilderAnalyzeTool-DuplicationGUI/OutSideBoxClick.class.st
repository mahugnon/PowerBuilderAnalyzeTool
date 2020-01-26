Class {
	#name : #OutSideBoxClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model',
		'elements'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-core'
}

{ #category : #accessing }
OutSideBoxClick >> elements: aCollection [
	elements := aCollection
]

{ #category : #hooks }
OutSideBoxClick >> initializeElement: element [
	element announcer
		when: TRMouseClick
		do: [ model updateFragmentColorFor: element model.
			element view nestedElements
				do: [ :nested | nested color: (model colorFor: nested model) ] ]
]

{ #category : #accessing }
OutSideBoxClick >> model: aDuplicationBrowserModel [
  model := aDuplicationBrowserModel
]
