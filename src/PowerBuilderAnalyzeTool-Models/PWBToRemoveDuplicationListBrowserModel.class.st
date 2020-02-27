Class {
	#name : #PWBToRemoveDuplicationListBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'default actions' }
PWBToRemoveDuplicationListBrowserModel >> exportToCSV [
self flag: #Todo
]

{ #category : #'accessing ' }
PWBToRemoveDuplicationListBrowserModel >> pwbMooseModel: aCollection [
	self halt.
	super pwbMooseModel: aCollection.
	pwbBrowser update
]
