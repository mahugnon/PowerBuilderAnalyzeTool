Class {
	#name : #InsideBoxClick,
	#superclass : #RSInteraction,
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

{ #category : #accessing }
InsideBoxClick >> model: aDuplicationBrowserModel [ 
	model := aDuplicationBrowserModel
]

{ #category : #hooks }
InsideBoxClick >> onShape: element [
	element announcer
		when: TRMouseClick
		do: [ view nestedElements
				do: [ :nested | 
					nested model clonedFragment = element model clonedFragment
						ifTrue: [ nested color: Color lightGreen ]
						ifFalse: [ nested color: Color gray ] ].
			model selectedFragmentLocation: element model.
			PWBApplication current globallySelect: element model ]
]

{ #category : #accessing }
InsideBoxClick >> view: aView [
	view := aView
]
