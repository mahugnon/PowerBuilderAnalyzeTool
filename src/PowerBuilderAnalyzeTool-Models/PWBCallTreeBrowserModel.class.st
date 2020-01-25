Class {
	#name : #PWBCallTreeBrowserModel,
	#superclass : #Object,
	#instVars : [
		'pbModel',
		'selected',
		'selectionListeners',
		'pwbBrowser'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserModel >> globallySelect: anEntity [
	pwbBrowser globallySelect: anEntity
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserModel >> globallySelected: anEntity [
	selected := anEntity.
	mooseModelPresenter focusElement: anEntity.
	self setContent.
	self notifySelectionListener
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> initialize [
	| liq_cal |
	super initialize.
	selectionListeners := OrderedCollection new.
	liq_cal := (MooseModel root first allWithType: FamixPWBUserObject)
		detect: [ :each | each name = 'uo_traitement_liq_cal' ].
	pbModel := liq_cal allReferences
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> pbModel [
	^ pbModel
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> pbModel: anObject [
	pbModel := anObject
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> pwbBrowser: aPWBBrowser [
	pwbBrowser := aPWBBrowser
]

{ #category : #api }
PWBCallTreeBrowserModel >> roassal [
	^ selected roassalPresenter
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> selected [
	^ selected
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> selected: anObject [
	selected := anObject.
	self setContent
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> setContent [
	selected ifNotNil: [ selected setContent ] 
]
