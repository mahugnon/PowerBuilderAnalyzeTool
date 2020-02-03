Class {
	#name : #PWBMooseModelBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'pwbMooseModelBrowser'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #tests }
PWBMooseModelBrowserTest >> testPWBModelIsNotNil [
	self assert: PWBMooseModelBrowser new model pbModel isNotNil
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSelectedISNotNilWhenAnItemIsSelectedInTheTree [
	pwbMooseModelBrowser setModelPresenterSelection.
	self assert: pwbMooseModelBrowser selected isNotNil
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSelectedItemIsNotNil [
	pwbMooseModelBrowser setModelPresenterSelection.
	self assert: pwbMooseModelBrowser modelPresenter selectedItem isNotNil
]

{ #category : #'as yet unclassified' }
PWBMooseModelBrowserTest >> testWhenItemIsGloballySelectedApplicationLogsIsnotEmpty [
	pwbMooseModelBrowser setModelPresenterSelection.
	self assert: PWBApplication current logger logs isNotEmpty
]
