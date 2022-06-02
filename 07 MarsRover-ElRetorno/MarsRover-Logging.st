!classDefinition: #LoggerTest category: 'MarsRover-Logging'!
TestCase subclass: #LoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!LoggerTest methodsFor: 'tests' stamp: 'FM 6/2/2022 19:00:17'!
test01StillMarsRoverHasEmptyLog

	| marsRover positionLog |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	PositionLogger for: marsRover.
	
	positionLog _ marsRover readLog.
	
	self assert: positionLog atEnd! !

!LoggerTest methodsFor: 'tests' stamp: 'FM 6/2/2022 19:00:44'!
test02PositionLoggerLogsForwardMovement

	| marsRover positionLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	PositionLogger for: marsRover.
	
	marsRover process: 'f'.
	
	positionLog _ marsRover readLog.
	
	self assert: '1@2' equals: positionLog nextLine.
	self assert: positionLog atEnd.! !

!LoggerTest methodsFor: 'tests' stamp: 'FM 6/2/2022 19:00:57'!
test03PositionLoggerLogsBackwardMovement

	| marsRover positionLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	PositionLogger for: marsRover.
	
	marsRover process: 'b'.
	
	positionLog _ marsRover readLog.
	
	self assert: '1@0' equals: positionLog nextLine.
	self assert: positionLog atEnd.! !

!LoggerTest methodsFor: 'tests' stamp: 'FM 6/2/2022 19:01:14'!
test04HeadingLoggerLogsRightRotation

	| marsRover headingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	HeadingLogger for: marsRover.
	
	marsRover process: 'r'.
	
	headingLog _ marsRover readLog.
	
	self assert: 'East' equals: headingLog nextLine.
	self assert: headingLog atEnd.! !

!LoggerTest methodsFor: 'tests' stamp: 'FM 6/2/2022 19:01:27'!
test05HeadingLoggerLogsLeftRotation

	| marsRover headingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	HeadingLogger for: marsRover.
	
	marsRover process: 'rl'.
	
	headingLog _ marsRover readLog.
	
	self assert: 'East' equals: headingLog nextLine.
	self assert: 'North' equals: headingLog nextLine.
	self assert: headingLog atEnd.! !

!LoggerTest methodsFor: 'tests' stamp: 'FM 6/2/2022 19:01:41'!
test06PositionAndHeadingLoggersWorkInTandem

	| marsRover positionAndHeadingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	HeadingLogger for: marsRover.
	PositionLogger for: marsRover.
	
	marsRover process: 'frrf'.
	
	positionAndHeadingLog _ marsRover readLog.
	
	self assert: '1@2' equals: positionAndHeadingLog nextLine.
	self assert: 'East' equals: positionAndHeadingLog nextLine.
	self assert: 'South' equals: positionAndHeadingLog nextLine.
	self assert: '1@1' equals: positionAndHeadingLog nextLine.
	self assert: positionAndHeadingLog atEnd.! !

!LoggerTest methodsFor: 'tests' stamp: 'FM 6/2/2022 19:34:20'!
test07WindowsUpdateCorrectly

	| marsRover positionWindow headingWindow | 
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionWindow _ PositionWindow for: marsRover.
	headingWindow _ HeadingWindow for: marsRover.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: positionWindow showFieldd.
	self assert: nil equals: headingWindow showFieldd.
	
	marsRover process: 'r'.
	
	self assert: 1@2 equals: positionWindow showFieldd.
	self assert: 'Pointing to East' equals: headingWindow showFieldd.
	
	marsRover process: 'f'.
	
	self assert: 2@2 equals: positionWindow showFieldd.
	self assert: 'Pointing to East' equals: headingWindow showFieldd.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-Logging'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #Logger category: 'MarsRover-Logging'!
Object subclass: #Logger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!Logger methodsFor: 'accessing' stamp: 'FM 6/2/2022 00:31:39'!
readStream

	^ReadStream on: log contents.! !


!Logger methodsFor: 'initialization' stamp: 'FM 6/2/2022 00:39:01'!
initializeFor: aMarsRover 	

	log _ WriteStream on: ''.
	aMarsRover addLogger: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Logger class' category: 'MarsRover-Logging'!
Logger class
	instanceVariableNames: ''!

!Logger class methodsFor: 'instance creation' stamp: 'FM 6/2/2022 00:39:07'!
for: aMarsRover 

	^self new initializeFor: aMarsRover ! !


!classDefinition: #HeadingLogger category: 'MarsRover-Logging'!
Logger subclass: #HeadingLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!HeadingLogger methodsFor: 'loggin' stamp: 'mf 6/2/2022 02:44:25'!
logChanges: aMarsRoverHeading in: aLoggerProxy 
	
	aLoggerProxy writeStream: (aMarsRoverHeading direction)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeadingLogger class' category: 'MarsRover-Logging'!
HeadingLogger class
	instanceVariableNames: ''!

!HeadingLogger class methodsFor: 'as yet unclassified' stamp: 'mf 6/2/2022 02:45:45'!
canHandle: anObject
	^(anObject class = String) or: [anObject class superclass  = MarsRoverHeading].! !


!classDefinition: #PositionLogger category: 'MarsRover-Logging'!
Logger subclass: #PositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!PositionLogger methodsFor: 'logging' stamp: 'mf 6/2/2022 02:09:26'!
logChanges: aPosition in: aLoggerProxy

	aLoggerProxy writeStream: (aPosition asString).
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionLogger class' category: 'MarsRover-Logging'!
PositionLogger class
	instanceVariableNames: ''!

!PositionLogger class methodsFor: 'as yet unclassified' stamp: 'FM 6/2/2022 00:58:37'!
canHandle: anObject
	^anObject class = Point.! !


!classDefinition: #LoggerProxy category: 'MarsRover-Logging'!
Object subclass: #LoggerProxy
	instanceVariableNames: 'loggers log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!LoggerProxy methodsFor: 'logging' stamp: 'mf 6/2/2022 02:05:30'!
logChanges: anObject
	
	(loggers detect: [:aLogger | aLogger class canHandle: anObject] ifNone: [^self]) logChanges: anObject in: self.
	
	! !


!LoggerProxy methodsFor: 'adding' stamp: 'FM 6/2/2022 00:49:36'!
add: aLogger
	
	loggers add: aLogger.! !


!LoggerProxy methodsFor: 'accessing' stamp: 'mf 6/2/2022 02:18:05'!
readStream
	
	^ReadStream on: log contents! !

!LoggerProxy methodsFor: 'accessing' stamp: 'mf 6/2/2022 02:07:29'!
writeStream: aString
	
	log nextPutAll: aString; newLine! !


!LoggerProxy methodsFor: 'initialization' stamp: 'mf 6/2/2022 01:53:36'!
initialize
	
	loggers  _ OrderedCollection new.
	log _ WriteStream on: ''
	
	! !


!classDefinition: #MarsRover category: 'MarsRover-Logging'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head loggerProxy windowProxy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'FM 6/2/2022 19:13:48'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	loggerProxy _ LoggerProxy new.
	windowProxy _ WindowProxy new.! !


!MarsRover methodsFor: 'heading' stamp: 'FM 6/2/2022 19:21:38'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	loggerProxy logChanges: head.
	windowProxy  logChanges: head.! !

!MarsRover methodsFor: 'heading' stamp: 'FM 6/2/2022 19:21:45'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	loggerProxy logChanges: head.
	windowProxy  logChanges: head.! !

!MarsRover methodsFor: 'heading' stamp: 'FM 6/2/2022 19:21:48'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	loggerProxy logChanges: head.
	windowProxy  logChanges: head.! !

!MarsRover methodsFor: 'heading' stamp: 'FM 6/2/2022 19:21:51'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	loggerProxy logChanges: head.
	windowProxy  logChanges: head. ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'FM 6/1/2022 22:31:12'!
rotateRight
	
	head rotateRight.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'FM 6/2/2022 19:21:07'!
addToPosition: add

	position := position + add.
	loggerProxy logChanges: position.
	windowProxy logChanges: position.! !

!MarsRover methodsFor: 'moving' stamp: 'mf 6/2/2022 01:57:20'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'FM 6/2/2022 01:10:22'!
moveEast
	
	self addToPosition: (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'mf 6/2/2022 01:57:03'!
moveForward
	
	head moveForward.
	! !

!MarsRover methodsFor: 'moving' stamp: 'FM 6/2/2022 01:10:32'!
moveNorth
	
	self addToPosition: (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'FM 6/2/2022 01:10:41'!
moveSouth
	
	self addToPosition: (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'FM 6/2/2022 01:10:46'!
moveWest
	
	self addToPosition: (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'loggers' stamp: 'mf 6/2/2022 02:13:05'!
addLogger: aLogger 
	
	loggerProxy add: aLogger! !

!MarsRover methodsFor: 'loggers' stamp: 'FM 6/2/2022 19:18:48'!
addWindow: aWindow 
	
	windowProxy add: aWindow! !

!MarsRover methodsFor: 'loggers' stamp: 'mf 6/2/2022 02:13:26'!
readLog

	^loggerProxy readStream
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Logging'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-Logging'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'mf 6/2/2022 02:30:54'!
direction

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-Logging'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!MarsRoverHeading class methodsFor: 'logging' stamp: 'mf 6/2/2022 02:25:10'!
direction
	
	self subclassResponsibility! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-Logging'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'mf 6/2/2022 02:31:07'!
direction
	
	^'East'! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-Logging'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'mf 6/2/2022 02:31:25'!
direction
	
	^'North'! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-Logging'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'mf 6/2/2022 02:50:11'!
direction
	
	^'South'! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-Logging'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'mf 6/2/2022 02:50:20'!
direction
	
	^'West'! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #Window category: 'MarsRover-Logging'!
Object subclass: #Window
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!Window methodsFor: 'initialization' stamp: 'FM 6/2/2022 19:18:19'!
initializeFor: aMarsRover
	aMarsRover addWindow: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Window class' category: 'MarsRover-Logging'!
Window class
	instanceVariableNames: ''!

!Window class methodsFor: 'instance creation' stamp: 'FM 6/2/2022 01:36:44'!
for: aMarsRover 

	^self new initializeFor: aMarsRover ! !


!classDefinition: #HeadingWindow category: 'MarsRover-Logging'!
Window subclass: #HeadingWindow
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!HeadingWindow methodsFor: 'logging' stamp: 'FM 6/2/2022 19:30:22'!
logChanges: aHeading
	heading _ 'Pointing to ',aHeading direction.! !


!HeadingWindow methodsFor: 'accessing' stamp: 'FM 6/2/2022 19:34:05'!
showFieldd
	^heading! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeadingWindow class' category: 'MarsRover-Logging'!
HeadingWindow class
	instanceVariableNames: ''!

!HeadingWindow class methodsFor: 'as yet unclassified' stamp: 'FM 6/2/2022 19:26:15'!
canHandle: anObject 
	^(anObject class = String) or: [anObject class superclass  = MarsRoverHeading]! !


!classDefinition: #PositionWindow category: 'MarsRover-Logging'!
Window subclass: #PositionWindow
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!PositionWindow methodsFor: 'logging' stamp: 'FM 6/2/2022 19:04:10'!
logChanges: aPosition
	position _ aPosition.! !


!PositionWindow methodsFor: 'accessing' stamp: 'FM 6/2/2022 19:33:57'!
showFieldd
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionWindow class' category: 'MarsRover-Logging'!
PositionWindow class
	instanceVariableNames: ''!


!PositionWindow class methodsFor: 'logging' stamp: 'FM 6/2/2022 01:31:22'!
canHandle: anObject 
	^anObject class = Point! !


!classDefinition: #WindowProxy category: 'MarsRover-Logging'!
Object subclass: #WindowProxy
	instanceVariableNames: 'windows'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logging'!

!WindowProxy methodsFor: 'initialization' stamp: 'FM 6/2/2022 19:14:32'!
initialize
	
	windows  _ OrderedCollection new.! !


!WindowProxy methodsFor: 'logging' stamp: 'FM 6/2/2022 19:20:04'!
logChanges: anObject
	
	(windows detect: [:aWindow | aWindow class canHandle: anObject] ifNone: [^self]) logChanges: anObject.! !


!WindowProxy methodsFor: 'adding' stamp: 'FM 6/2/2022 19:19:25'!
add: aWindow
	windows add: aWindow.! !
