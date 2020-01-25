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
	pwbCallTreeBrowserModel := PWBCallTreeBrowserModel new.
	pwbCallTreeBrowser := PWBCallTreeBrowser new
]
