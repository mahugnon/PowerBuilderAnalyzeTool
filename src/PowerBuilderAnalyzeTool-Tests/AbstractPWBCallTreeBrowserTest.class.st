Class {
	#name : #AbstractPWBCallTreeBrowserTest,
	#superclass : #TestCase,
	#instVars : [
		'pwbCallTreeBrowserModel',
		'pwbCallTreeBrowser'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
AbstractPWBCallTreeBrowserTest >> setUp [
	pwbCallTreeBrowser := PWBCallTreeBrowser new.
	pwbCallTreeBrowserModel := pwbCallTreeBrowser model
]
