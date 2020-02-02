Class {
	#name : #CIMRoassalPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'diagram',
		'guiModel',
		'view'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #specs }
CIMRoassalPresenter class >> defaultSpec [
	^ SpBoxLayout  newHorizontal
		add: #diagram;
		yourself
]

{ #category : #'as yet unclassified' }
CIMRoassalPresenter >> adapterFrom: aCollection [
  ^self pbModel select: [:each |  aCollection includes: each pbModel ]
]

{ #category : #accessing }
CIMRoassalPresenter >> application [
	^ owner application
]

{ #category : #accessing }
CIMRoassalPresenter >> diagram [
	^ diagram
]

{ #category : #accessing }
CIMRoassalPresenter >> diagram: anObject [
	diagram := anObject
]

{ #category : #initialization }
CIMRoassalPresenter >> drawOn: aView [
	^ self subclassResponsibility
]

{ #category : #accessing }
CIMRoassalPresenter >> guiModel [
	^ guiModel
]

{ #category : #accessing }
CIMRoassalPresenter >> guiModel: anObject [
	guiModel := anObject
]

{ #category : #initialization }
CIMRoassalPresenter >> initializeDiagram [
	diagram := self instantiate: RoassalModel.
	diagram
		script: [ :aView :canvas | 
			self drawOn: aView.
			view := aView.
			aView canvas focusOnCenterScaled ]
]

{ #category : #initialization }
CIMRoassalPresenter >> initializeWidgets [
  self initializeDiagram
]

{ #category : #accessing }
CIMRoassalPresenter >> pbModel [
	^ guiModel selectedContent
]

{ #category : #accessing }
CIMRoassalPresenter >> view [
	^ view
]

{ #category : #initialization }
CIMRoassalPresenter >> zoomIn [
	RTZoomInMove on: view
]

{ #category : #initialization }
CIMRoassalPresenter >> zoomOut [
	RTZoomOutMove on: view
]
