Class {
	#name : #CIMToolBar,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'markButton',
		'unMarkButton',
		'browseButton',
		'zoomInButton',
		'zoomOutButton',
		'uselessFunctionButton',
		'obsoletteVarButton'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #'as yet unclassified' }
CIMToolBar class >> createBrowse [
  ThemeIcons compile: 'callTreeContents
	^ ''' , (Base64MimeConverter mimeEncode: '/Users/honore/Downloads/function.png' asFileReference binaryReadStream) contents , '''' classified: '*PWBCodeAnalyser'.
  ThemeIcons compile: 'callGraphIcon
	^ icons
			at: #''callGraphIcon''
			ifAbsentPut:[ Form fromBinaryStream: self callTreeContents base64Decoded asByteArray readStream ]' classified: '*PWBCodeAnalyser'.
  Smalltalk ui icons callGraphIcon
]

{ #category : #specs }
CIMToolBar class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #browseButton;
		add: #uselessFunctionButton;
		add: #markButton;
		add: #unMarkButton;
		add: #zoomInButton;
		add: #zoomOutButton;
		yourself
]

{ #category : #examples }
CIMToolBar class >> run [
  < example>
  self new openWithSpec
]

{ #category : #initialization }
CIMToolBar >> initializePresenters [
	markButton action: [  ].
	unMarkButton action: [  ]
]

{ #category : #initialization }
CIMToolBar >> initializeWidgets [
	obsoletteVarButton := self newButton
		label: 'Browse obsoletteVar';
		help: 'Browse non referenced varables';
		icon: (Smalltalk ui icons iconNamed: #scriptManager).
	uselessFunctionButton := self newButton
		label: 'Browse obsoletteFunction';
		help: 'Browser non used function.';
		action: [ self inform: 'Browser non used function' ];
		yourself.
	unMarkButton := self newButton.
	unMarkButton
		label: 'Browse duplication';
		help: 'Browse duplication between functions.';
		icon: (Smalltalk ui icons iconNamed: #smallCancel).
	browseButton := self newButton.
	browseButton
		label: 'Browse selection';
		icon: (Smalltalk ui icons iconNamed: #glamorousSearch).
	zoomInButton := self newButton
		label: 'Zoom In';
		icon: (self iconNamed: #glamorousZoomIn).
	zoomOutButton := self newButton
		label: 'Zoom Out';
		icon: (self iconNamed: #glamorousZoomOut)
]

{ #category : #accessing }
CIMToolBar >> model: aPWBCallTreeBrowserModel [ 
	model := aPWBCallTreeBrowserModel
]
