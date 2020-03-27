Class {
	#name : #PWBCallTreeBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'selectionListeners',
		'selectedInvocations'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserModel >> globallySelect: anEntity [
	pwbBrowser globallySelect: anEntity
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> pwbBrowser: aPWBBrowser [
	pwbBrowser := aPWBBrowser
]

{ #category : #api }
PWBCallTreeBrowserModel >> refreshWithParameters: anOptionParameters [
	selectedInvocations := (QueryIncomingInvocationSenders
		options: anOptionParameters) runOn: selected.
	pwbBrowser updateRoassal
]

{ #category : #api }
PWBCallTreeBrowserModel >> roassal [
	^ selected roassalPresenter
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> selected: anObject [
	selected := anObject.
	selectedInvocations := selected incomingInvocationsSenders: 1
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> selectedInvocations [
	^ selectedInvocations
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> setContent [
	selected content ifNil: [ selected setContent ]
]
