Class {
	#name : #CIMMainMenu,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'markButton',
		'unMarkButton',
		'browseButton',
		'zoomInButton',
		'zoomOutButton'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #'as yet unclassified' }
CIMMainMenu class >> createBrowse [
  ThemeIcons compile: 'callTreeContents
	^ ''' , (Base64MimeConverter mimeEncode: '/Users/honore/Downloads/function.png' asFileReference binaryReadStream) contents , '''' classified: '*PWBCodeAnalyser'.
  ThemeIcons compile: 'callGraphIcon
	^ icons
			at: #''callGraphIcon''
			ifAbsentPut:[ Form fromBinaryStream: self callTreeContents base64Decoded asByteArray readStream ]' classified: '*PWBCodeAnalyser'.
  Smalltalk ui icons callGraphIcon
]

{ #category : #specs }
CIMMainMenu class >> defaultSpec [
  ^SpBoxLayout newHorizontal
     add: #browseButton;
     add: #markButton;
     add: #unMarkButton;
     add: #zoomInButton;
     add: #zoomOutButton;
     yourself
]

{ #category : #examples }
CIMMainMenu class >> run [
  < example>
  self new openWithSpec
]

{ #category : #accessing }
CIMMainMenu >> announcer [
  ^model announcer
]

{ #category : #initialization }
CIMMainMenu >> initializePresenters [
  markButton action: [ model announcer announce: (CIMInterrestingKeepEntityAnnoucement new interrestingEntity: model selected) ].
  unMarkButton action: [ model announcer announce: (CIMInterrestingRemoveEntityAnnoucement new interrestingEntity: model selected) ]
]

{ #category : #initialization }
CIMMainMenu >> initializeWidgets [
  markButton := self newButton.
  SpButtonPresenter.
  markButton
     label: 'Mark';
     icon: (Smalltalk ui icons iconNamed: #scriptManager).
  unMarkButton := self newButton.
  unMarkButton
     label: 'Unmark';
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
