Class {
	#name : #PWBCallTreeBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'pwbCallTreeBrowserModel',
		'pwbCallTreeBrowser'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBCallTreeBrowserTest >> setUp [
	super setUp.
	pwbCallTreeBrowser := PWBCallTreeBrowser new.
	pwbCallTreeBrowserModel := pwbCallTreeBrowser model
]

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
PWBCallTreeBrowserTest >> testBrowserStatedMustRemainTheSameIffreeze [
	pwbCallTreeBrowser freeze: true.
	pwbCallTreeBrowser selectEntity: testUserObject1.
	self deny: pwbCallTreeBrowser model selected equals: testUserObject1
]
