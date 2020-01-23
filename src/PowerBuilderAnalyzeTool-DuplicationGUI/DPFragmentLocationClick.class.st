Class {
	#name : #DPFragmentLocationClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-core'
}

{ #category : #hooks }
DPFragmentLocationClick >> initializeElement1: element [
  element announcer when: TRMouseClick do: [ model selectedFragmentLocation: element model.
        model addFragment: element model color: Color random ]
]

{ #category : #hooks }
DPFragmentLocationClick >> initializeElement: element [
	element announcer
		when: TRMouseClick
		do: [ model selectedFragmentLocation: element model.
			model refreshRoassal ]
]

{ #category : #accessing }
DPFragmentLocationClick >> model: aDuplicationBrowserModel [ 
	model := aDuplicationBrowserModel
]
