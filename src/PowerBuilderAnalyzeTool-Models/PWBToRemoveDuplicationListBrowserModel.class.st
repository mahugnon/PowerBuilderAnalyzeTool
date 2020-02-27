Class {
	#name : #PWBToRemoveDuplicationListBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'default actions' }
PWBToRemoveDuplicationListBrowserModel >> exportToCSV [
	self halt.
	self flag: #Todo
]

{ #category : #'accessing ' }
PWBToRemoveDuplicationListBrowserModel >> pwbMooseModel: aCollection [
	super pwbMooseModel: aCollection.
	pwbBrowser update
]
