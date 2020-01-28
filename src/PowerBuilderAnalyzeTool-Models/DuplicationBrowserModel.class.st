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
		'minNumberOfCharacters'
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

{ #category : #api }
DuplicationBrowserModel >> fragmentText [
  ^self fragmentText: selectedFragmentLocation
]

{ #category : #api }
DuplicationBrowserModel >> fragmentText: aFragmentLocation [
  | source before beforeString after afterString textToRender |
  source := aFragmentLocation entitySourceCode lines.
  before := source select: [:l |  (source indexOf: l) < aFragmentLocation startLine ].
  beforeString := String streamContents: [:stream |  before do: [:line |  stream
                 << line;
                 cr ] ].
  after := source select: [:l |  (source indexOf: l) > aFragmentLocation endLine ].
  afterString := String streamContents: [:stream |  after do: [:line |  stream
                 << line;
                 cr ] ].
  textToRender := Text new.
  textToRender append: beforeString.
  textToRender append: (Text string: aFragmentLocation codeText attributes: {(TextColor new color: Color red)}).
  textToRender append: afterString.
  ^textToRender
]

{ #category : #initialization }
DuplicationBrowserModel >> initialize [
	super initialize.
	mooseModel := FamixPWBFunction new content: #().
	duplicationFragments := OrderedCollection new.
	colorMap := OrderedDictionary new.
	selectedFragmentLocation := DPFragmentLocation new.
	minNumberOfLines := 10.
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
	mooseModel := aFamixPWBUserObject
]

{ #category : #api }
DuplicationBrowserModel >> mooseModelFunctions [
	^ mooseModel content
]

{ #category : #api }
DuplicationBrowserModel >> openTextPresenters [
  focusClonedFragment members do: [:each |  SourceTextPresenter new
           text: (self fragmentText: each);
           location: each entity mooseName;
           openWithSpec ]
]

{ #category : #api }
DuplicationBrowserModel >> openTextPresenters: aFragment [
  aFragment members do: [:each |  SourceTextPresenter new
           text: (self fragmentText: each);
           location: each entity mooseName;
           openWithSpec ]
]

{ #category : #initialization }
DuplicationBrowserModel >> refreshRoassal [
  duplicationView updateView
]

{ #category : #accessing }
DuplicationBrowserModel >> selectedFragmentLocation: anObject [
  selectedFragmentLocation := anObject.
  duplicationBrowser updateCode.

]

{ #category : #api }
DuplicationBrowserModel >> selectedFragmentLocationName [
	^ selectedFragmentLocation name
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
	"	self refreshRoassal"
]
