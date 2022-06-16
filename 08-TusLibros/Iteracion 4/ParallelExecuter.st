!classDefinition: #ParallelExecuter category: 'ParallelExecuter'!
Object subclass: #ParallelExecuter
	instanceVariableNames: 'blocks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ParallelExecuter'!

!ParallelExecuter methodsFor: 'execuiting' stamp: 'mf 6/16/2022 05:05:05'!
executeAllBlockInParallel

	^ blocks do: [:aBlockAndASemaphore | 
			[self valueBlock: aBlockAndASemaphore. 
			self signalSemaphore: aBlockAndASemaphore]
		 fork]! !

!ParallelExecuter methodsFor: 'execuiting' stamp: 'mf 6/16/2022 05:02:07'!
executeAndWaitForAllBlocks
	
	self executeAllBlockInParallel.
	self waitForAllBlocksToFinish! !

!ParallelExecuter methodsFor: 'execuiting' stamp: 'mf 6/16/2022 05:04:14'!
signalSemaphore: aBlockAndASemaphore

	^ aBlockAndASemaphore value signal! !

!ParallelExecuter methodsFor: 'execuiting' stamp: 'mf 6/16/2022 05:03:42'!
valueBlock: aBlockAndASemaphore

	^ aBlockAndASemaphore key value! !

!ParallelExecuter methodsFor: 'execuiting' stamp: 'mf 6/16/2022 05:05:42'!
waitForAllBlocksToFinish

	^ blocks do: [:aBlockAndASemaphore | self waitForSemaphore: aBlockAndASemaphore]! !

!ParallelExecuter methodsFor: 'execuiting' stamp: 'mf 6/16/2022 05:05:42'!
waitForSemaphore: aBlockAndASemaphore

	^ aBlockAndASemaphore value wait! !


!ParallelExecuter methodsFor: 'initialization' stamp: 'mf 6/16/2022 05:00:30'!
asociateASemaphoreTo: firstBlock

	^ firstBlock -> Semaphore new! !

!ParallelExecuter methodsFor: 'initialization' stamp: 'mf 6/16/2022 04:30:21'!
initialize
	
	blocks _ OrderedCollection new.! !

!ParallelExecuter methodsFor: 'initialization' stamp: 'mf 6/16/2022 05:00:59'!
initializeWith: firstBlock with: secondBlock
	
	blocks _ OrderedCollection 
		with: (self asociateASemaphoreTo: firstBlock) 
		with: (self asociateASemaphoreTo: secondBlock)! !


!ParallelExecuter methodsFor: 'adding' stamp: 'mf 6/16/2022 05:01:15'!
add: aBlock
	
	blocks add: (self asociateASemaphoreTo: aBlock). ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParallelExecuter class' category: 'ParallelExecuter'!
ParallelExecuter class
	instanceVariableNames: ''!

!ParallelExecuter class methodsFor: 'instance creation' stamp: 'mf 6/16/2022 04:55:09'!
with: aFirstBlock with: aSecondBlock
	
	^self new initializeWith: aFirstBlock with: aSecondBlock! !
