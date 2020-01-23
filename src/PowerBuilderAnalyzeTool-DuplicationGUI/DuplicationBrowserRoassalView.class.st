Class {
	#name : #DuplicationBrowserRoassalView,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'duplicationDiagram'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-roassal'
}

{ #category : #specs }
DuplicationBrowserRoassalView class >> defaultSpec [
  ^SpBoxLayout newVertical
     add: #duplicationDiagram;
     yourself
]

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalView class >> viewName [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalView class >> views [
	^ self subclasses
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> drawDuplicationDiagramOn: aView [
	^ self subclassResponsibility
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeDuplicationDiagram [
  duplicationDiagram := self instantiate: RoassalModel.
  duplicationDiagram script: [:aView :canvas |  self drawDuplicationDiagramOn: aView.
        aView canvas focusOnCenterScaled ]
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeWidgets [
  model := DuplicationBrowserModel new.
  self initializeDuplicationDiagram
]

{ #category : #accessing }
DuplicationBrowserRoassalView >> model: anObject [
  model := anObject.
  model duplicationView: self
]

{ #category : #updating }
DuplicationBrowserRoassalView >> updateView [
  self update
]
