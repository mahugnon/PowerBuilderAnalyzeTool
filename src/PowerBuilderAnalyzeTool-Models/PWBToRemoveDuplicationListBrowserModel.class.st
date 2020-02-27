Class {
	#name : #PWBToRemoveDuplicationListBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'default actions' }
PWBToRemoveDuplicationListBrowserModel >> exportToCSV [
	'DuplicatedFunction.csv' asFileReference
		writeStreamDo: [ :aStream | 
			aStream
				<< 'Object PWB';
				nextPut: $,;
				<< 'Function';
				nextPut: $,;
				<< 'Number of clones';
				cr.
			pwbMooseModel
				keysAndValuesDo: [ :key :value | 
					aStream
						<< key parentType name;
						nextPut: $,;
						<< key name;
						nextPut: $,;
						<< value size asString;
						cr ] ]
]

{ #category : #'accessing ' }
PWBToRemoveDuplicationListBrowserModel >> pwbMooseModel: aDictionnary [
	super pwbMooseModel: aDictionnary.
	pwbBrowser update
]
