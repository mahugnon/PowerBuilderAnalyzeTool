Class {
	#name : #InsideBoxClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model',
		'view'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-core'
}

{ #category : #accessing }
InsideBoxClick >> elements [
	self shouldBeImplemented.
]

{ #category : #hooks }
InsideBoxClick >> initializeElement1: element [
  element announcer when: TRMouseClick do: [ model selectedFragmentLocation: element model.
        model addFragment: element model color: Color random ]
]

{ #category : #hooks }
InsideBoxClick >> initializeElement: element [
	element announcer
		when: TRMouseClick
		do: [ view nestedElements
				do: [ :nested | 
					nested model clonedFragment = element model clonedFragment
						ifTrue: [ nested color: Color black ]
						ifFalse: [ nested color: Color gray ] ].
			model selectedFragmentLocation: element model
			"model refreshRoassal" ]
]

{ #category : #accessing }
InsideBoxClick >> model: aDuplicationBrowserModel [ 
	model := aDuplicationBrowserModel
]

{ #category : #accessing }
InsideBoxClick >> view: aView [
	view := aView
]
