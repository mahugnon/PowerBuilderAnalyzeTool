Class {
	#name : #DuplicationBrowserModel,
	#superclass : #Object,
	#instVars : [
		'mooseModel',
		'duplicationFragments',
		'duplicationView',
		'selectedFragmentLocation',
		'duplicationBrowser',
		'colorMap',
		'focusClonedFragment',
		'duplicationEntities',
		'fragmentColors',
		'minNumberOfLines',
		'minNumberOfCharacters',
		'selected'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #api }
DuplicationBrowserModel >> addFragment: anObject color: aColor [
  colorMap at: anObject entity put: aColor.
  duplicationView updateView
]

{ #category : #private }
DuplicationBrowserModel >> colorFor: anObject [
	self initializeColors.
	^ fragmentColors keys
		detect: [ :each | anObject isMemberOf: (fragmentColors at: each) ]
		ifNone: [ Color gray ]
]

{ #category : #accessing }
DuplicationBrowserModel >> computeDuplication [
	self computeDuplicationWith: self mooseModelFunctions
]

{ #category : #initialization }
DuplicationBrowserModel >> computeDuplicationWith: aCollection [
	| param |
	param := DPParameters new
		minNumberOfLines: minNumberOfLines;
		frequency: 2;
		minNumberOfCharacters: minNumberOfCharacters;
		cleaner: DPPWBCleaner new.
	duplicationFragments := QueryDuplication new
		runOn: aCollection
		with: param.
	self refreshRoassal
]

{ #category : #api }
DuplicationBrowserModel >> defaultRoassalView [
	^ DuplicationBrowserRoassalViewByEntity
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationBrowser: anObject [
  duplicationBrowser := anObject
]

{ #category : #initialization }
DuplicationBrowserModel >> duplicationEntities [
	| dpLocations |
	dpLocations := self duplicationLocations.
	duplicationEntities := dpLocations groupedBy: #entity.
	^ duplicationEntities
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments [
	^ duplicationFragments
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments: anObject [
	duplicationFragments := anObject
]

{ #category : #initialization }
DuplicationBrowserModel >> duplicationLocations [
  ^duplicationFragments flatCollectAsSet: #members
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView [
	^ duplicationView
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView: anObject [
	duplicationView := anObject
]

{ #category : #accessing }
DuplicationBrowserModel >> focusClonedFragment [
	^ selectedFragmentLocation clonedFragment
]

{ #category : #initialization }
DuplicationBrowserModel >> initialize [
	super initialize.
	mooseModel := FamixPWBFunction new content: #().
	duplicationFragments := OrderedCollection new.
	colorMap := OrderedDictionary new.
	selectedFragmentLocation := DPFragmentLocation new.
	minNumberOfLines := 50.
	minNumberOfCharacters := 55
]

{ #category : #initialization }
DuplicationBrowserModel >> initializeColors [
	fragmentColors ifNil: [ fragmentColors := Dictionary new ]
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfCharacters [
	^ minNumberOfCharacters
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfCharacters: anInteger [ 
	minNumberOfCharacters := anInteger
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfLines [
	^ minNumberOfLines
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfLines: anInteger [ 
	minNumberOfLines := anInteger
]

{ #category : #accessing }
DuplicationBrowserModel >> mooseModel: aFamixPWBUserObject [
	mooseModel := aFamixPWBUserObject.
	self computeDuplication
]

{ #category : #api }
DuplicationBrowserModel >> mooseModelFunctions [
	^ mooseModel content
]

{ #category : #initialization }
DuplicationBrowserModel >> refreshRoassal [
  duplicationView updateView
]

{ #category : #'accessing ' }
DuplicationBrowserModel >> selected [
	^ selected
]

{ #category : #accessing }
DuplicationBrowserModel >> selected: anObject [
	selected := anObject.
	duplicationBrowser globallySelect: anObject
]

{ #category : #accessing }
DuplicationBrowserModel >> selectedFragmentLocation: anObject [
	selectedFragmentLocation := anObject.
	self selected: anObject
]

{ #category : #api }
DuplicationBrowserModel >> updateFragmentColorFor: aFamixPWBFunction [
	| fragment |
	fragment := ((duplicationEntities at: aFamixPWBFunction)
		collect: #clonedFragment) asOrderedCollection.
	fragmentColors := OrderedDictionary
		newFromKeys: (Color wheel: fragment size)
		andValues: fragment asOrderedCollection.
	^ fragmentColors
]
