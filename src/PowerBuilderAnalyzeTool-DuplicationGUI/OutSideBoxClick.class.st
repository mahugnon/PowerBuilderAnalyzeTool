Class {
	#name : #OutSideBoxClick,
	#superclass : #RSInteraction,
	#instVars : [
		'model',
		'elements'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-core'
}

{ #category : #hooks }
OutSideBoxClick >> colorBoxsUsing: element [
	model updateFragmentColorFor: element model.
	PWBApplication current globallySelect: element model.
	model selected: element model.
	^ element view nestedElements
		do: [ :nested | nested color: (model colorFor: nested model) ]
]

{ #category : #accessing }
OutSideBoxClick >> elements: aCollection [
	elements := aCollection
]

{ #category : #accessing }
OutSideBoxClick >> model: aDuplicationBrowserModel [
  model := aDuplicationBrowserModel
]

{ #category : #hooks }
OutSideBoxClick >> onShape: element [
	element announcer
		when: TRMouseClick
		do: [ self colorBoxsUsing: element ]
]
