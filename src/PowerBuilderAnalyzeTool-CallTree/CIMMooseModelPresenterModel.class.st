Class {
	#name : #CIMMooseModelPresenterModel,
	#superclass : #Object,
	#instVars : [
		'pbModel',
		'selected',
		'selectionListeners',
		'mooseModelPresenter',
		'announcer'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-Models'
}

{ #category : #accessing }
CIMMooseModelPresenterModel >> announcer [
  announcer ifNil: [ announcer := Announcer new ].
  ^announcer
]

{ #category : #'as yet unclassified' }
CIMMooseModelPresenterModel >> globallySelected: anEntity [
	self
		selected: (self pbModel detect: [ :each | each pbModel = anEntity ])
]

{ #category : #initialization }
CIMMooseModelPresenterModel >> initialize [
  | liq_cal |
  super initialize.
  selectionListeners := OrderedCollection new.
  liq_cal := (MooseModel root first allWithType: FamixPWBUserObject) detect: [:each |  each name = 'uo_traitement_liq_cal' ].
  pbModel := (CIMCodeAnalyserFmxUserObjectAdapter new pbModel: liq_cal) allReferences
]

{ #category : #accessing }
CIMMooseModelPresenterModel >> mooseModelPresenter: aCIMMooseModelPresenter [
  mooseModelPresenter := aCIMMooseModelPresenter
]

{ #category : #'as yet unclassified' }
CIMMooseModelPresenterModel >> mooseModelPresenterSelectedItem: anObject [
  mooseModelPresenter focusElement: anObject
]

{ #category : #accessing }
CIMMooseModelPresenterModel >> notifySelectionListener [
	selectionListeners do: #updateWithSelection
]

{ #category : #accessing }
CIMMooseModelPresenterModel >> pbModel [
	^ pbModel
]

{ #category : #accessing }
CIMMooseModelPresenterModel >> pbModel: anObject [
	pbModel := anObject
]

{ #category : #api }
CIMMooseModelPresenterModel >> roassal [
	^ selected roassalPresenter
]

{ #category : #accessing }
CIMMooseModelPresenterModel >> selected [
	^ selected
]

{ #category : #accessing }
CIMMooseModelPresenterModel >> selected: anObject [
  selected := anObject.
  self setContent.
  self notifySelectionListener
]

{ #category : #initialization }
CIMMooseModelPresenterModel >> setContent [
	selected setContent
]

{ #category : #api }
CIMMooseModelPresenterModel >> subscribeToSelectionChannel: aCIMMainPresenter [
	selectionListeners add: aCIMMainPresenter
]
