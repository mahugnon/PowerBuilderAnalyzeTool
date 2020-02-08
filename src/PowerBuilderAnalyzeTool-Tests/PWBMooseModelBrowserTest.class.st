Class {
	#name : #PWBMooseModelBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBMooseModelBrowserTest >> setUp [
	super setUp.
	browser := PWBMooseModelBrowser new
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testPWBModelIsNotNil [
	self assert: PWBMooseModelBrowser new model pwbMooseModel isNotNil
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSearch [
	browser openWithSpec.
	browser searchFor: 'uo_po'.
	browser window close.
	self
		assert: (browser modelPresenter selectedItem name beginsWith: 'uo_po')
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSelectedISNotNilWhenAnItemIsSelectedInTheTree [
	browser setModelPresenterSelection.
	self assert: browser selected isNotNil
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSelectedItemIsNotNil [
	browser setModelPresenterSelection.
	self assert: browser modelPresenter selectedItem isNotNil
]

{ #category : #'as yet unclassified' }
PWBMooseModelBrowserTest >> testWhenItemIsGloballySelectedApplicationLogsIsnotEmpty [
	browser setModelPresenterSelection.
	self assert: PWBApplication current logger logs isNotEmpty
]
