Class {
	#name : #PWBCallTreeBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserTest >> testApplicationLogsIsEmpty [
	PWBApplication reset.
	self deny: PWBApplication current logger logs isNotEmpty
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testBrowserModelIsNotNil [
	self assert: pwbCallTreeBrowser model isNotNil
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testPWBModelIsNotNil [
	self assert: PWBCallTreeBrowserModel new pbModel isNotNil
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testSelectedISNotNilWhenAnItemIsSelectedInTheTree [
	pwbCallTreeBrowser setModelPresenterSelection.
	self assert: pwbCallTreeBrowserModel selected isNotNil
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testSelectedItemIsNotNil [
	pwbCallTreeBrowser setModelPresenterSelection.
	self assert: pwbCallTreeBrowser modelPresenter selectedItem isNotNil
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserTest >> testWhenItemIsGloballySelectedApplicationLogsIsnotEmpty [
	pwbCallTreeBrowser setModelPresenterSelection.
	self assert: PWBApplication current logger logs isNotEmpty
]
