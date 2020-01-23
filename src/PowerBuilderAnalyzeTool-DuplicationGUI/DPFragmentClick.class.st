Class {
	#name : #DPFragmentClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-core'
}

{ #category : #hooks }
DPFragmentClick >> initializeElement: element [
	element announcer
		when: TRMouseClick
		do: [ model updateFragmentColorFor: element model ]
]

{ #category : #accessing }
DPFragmentClick >> model: aDuplicationBrowserModel [
  model := aDuplicationBrowserModel
]
