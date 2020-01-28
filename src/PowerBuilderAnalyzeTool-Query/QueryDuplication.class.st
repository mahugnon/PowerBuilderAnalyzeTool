Class {
	#name : #QueryDuplication,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDuplication >> runOn: aCollection [
	^ (DPDetector
		runOn: aCollection
		parametrizedWith:
		(DPParameters new
		minNumberOfLines: 10;
		frequency: 2;
		minNumberOfCharacters: 55;
		cleaner: DPPWBCleaner new))
		setColors;
		fragments
]
