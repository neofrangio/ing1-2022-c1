!classDefinition: #MarsRoverTest category: 'Mars-Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 13:36:19'!
test01MarsRoverIsWhereItWasDeployedPoitingToTheSameDirection

	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: 7@5 pointing: 'S'.
	self assert: (aMarsRover position) equals: 7@5.
	self assert: (aMarsRover direction) equals: 'S'.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 14:20:24'!
test02MarsRoverExecuteEmptyCommandDoesntModifyItsPositionAndDirection
	
	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: 7@5 pointing: 'S'.
	aMarsRover execute: ''.
	self assert: (aMarsRover position) equals: 7@5.
	self assert: (aMarsRover direction) equals: 'S'.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 14:30:48'!
test03LeftComandRotatesMarsRoverDirection90degreesToTheLeft

	self assertRotatingAMarsRoverLeftChangesItDirectionFrom: 'N' to: 'O'.
	self assertRotatingAMarsRoverLeftChangesItDirectionFrom: 'O' to: 'S'.
	self assertRotatingAMarsRoverLeftChangesItDirectionFrom: 'S' to: 'E'.
	self assertRotatingAMarsRoverLeftChangesItDirectionFrom: 'E' to: 'N'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 14:31:00'!
test04RightComandRotatesMarsRoverDirection90degreesToTheRight

	self assertRotatingAMarsRoverRightChangesItDirectionFrom: 'N' to: 'E'.
	self assertRotatingAMarsRoverRightChangesItDirectionFrom: 'E' to: 'S'.
	self assertRotatingAMarsRoverRightChangesItDirectionFrom: 'S' to: 'O'.
	self assertRotatingAMarsRoverRightChangesItDirectionFrom: 'O' to: 'N'.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 14:31:51'!
test05FowardCommandMovesMarsRoverOnePointFoward

	self assertMovingFowardAMarsRoverPointing: 'N' inPosition1x1yMovesItTo: (1@2).
	self assertMovingFowardAMarsRoverPointing: 'E' inPosition1x1yMovesItTo: (2@1).
	self assertMovingFowardAMarsRoverPointing: 'S' inPosition1x1yMovesItTo: (1@0).
	self assertMovingFowardAMarsRoverPointing: 'O' inPosition1x1yMovesItTo: (0@1).

	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 14:32:04'!
test06BackwardsCommandMovesMarsRoverOnePointBackwards

	self assertMovingBackwardsAMarsRoverPointing: 'N' inPosition1x1yMovesItTo: (1@0).
	self assertMovingBackwardsAMarsRoverPointing: 'E' inPosition1x1yMovesItTo: (0@1).
	self assertMovingBackwardsAMarsRoverPointing: 'S' inPosition1x1yMovesItTo: (1@2).
	self assertMovingBackwardsAMarsRoverPointing: 'O' inPosition1x1yMovesItTo: (2@1).

	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 14:38:04'!
test07ExecutingAChainOfCommandsWorksCorrectly

	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: (0@0) pointing: 'N'.
	aMarsRover execute: 'rfflffrbrbl'.
	self assert: (aMarsRover position) equals: (1@3).
	self assert: (aMarsRover direction) equals: 'E'.
	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'mf 5/16/2022 16:08:47'!
test08MarsRoverExecutesChainOfCommandUntilInvalidCommandArrives

	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: (0@0) pointing: 'N'.
	aMarsRover execute: 'rfflffrbrbljjjjjflb'.
	self assert: (aMarsRover position) equals: (1@3).
	self assert: (aMarsRover direction) equals: 'E'.
	
	
	! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'mf 5/16/2022 14:18:19'!
assertMovingBackwardsAMarsRoverPointing: aDirection inPosition1x1yMovesItTo: newPosition

	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: (1@1) pointing: aDirection.
	aMarsRover execute: 'b'.
	self assert: (aMarsRover position) equals: newPosition.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'mf 5/16/2022 14:18:44'!
assertMovingFowardAMarsRoverPointing: aDirection inPosition1x1yMovesItTo: newPosition

	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: (1@1) pointing: aDirection.
	aMarsRover execute: 'f'.
	self assert: (aMarsRover position) equals: newPosition.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'mf 5/16/2022 14:06:38'!
assertRotatingAMarsRoverLeftChangesItDirectionFrom: originalDirection to: newDirection

	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: (0@0) pointing: originalDirection.
	aMarsRover execute: 'l'.
	self assert: (aMarsRover direction) equals: newDirection.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'mf 5/16/2022 14:07:04'!
assertRotatingAMarsRoverRightChangesItDirectionFrom: originalDirection to: newDirection

	| aMarsRover |
	aMarsRover _ MarsRover deployedAt: (0@0) pointing: originalDirection.
	aMarsRover execute: 'r'.
	self assert: (aMarsRover direction) equals: newDirection.! !


!classDefinition: #MarsRover category: 'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'mf 5/16/2022 15:27:04'!
initializeAt: aPosition pointing: aDirection
	
	position _ aPosition.
	direction _ MarsRoverCardinalDirection pointing: aDirection.! !


!MarsRover methodsFor: 'accesing' stamp: 'mf 5/16/2022 15:27:10'!
direction
	
	^direction asString.! !

!MarsRover methodsFor: 'accesing' stamp: 'mf 5/16/2022 14:46:57'!
position
	
	^position! !


!MarsRover methodsFor: 'execution' stamp: 'mf 5/16/2022 16:18:47'!
execute: aChainOfCommands
	
	|currentCommand nextCommands|
	
	aChainOfCommands ifEmpty: [^self].
	
	currentCommand _ aChainOfCommands first.
	nextCommands _ aChainOfCommands copyFrom: 2 to: (aChainOfCommands size).
	
	(currentCommand = $l) ifTrue:[self rotateLeft. self execute: nextCommands].
	(currentCommand = $r) ifTrue:[self rotateRight. self execute: nextCommands].
	(currentCommand = $f) ifTrue:[self moveFoward. self execute: nextCommands].
	(currentCommand = $b) ifTrue:[self moveBackwards. self execute: nextCommands].
	! !


!MarsRover methodsFor: 'execution-private' stamp: 'mf 5/16/2022 15:54:45'!
moveBackwards
	
	position _ position + (direction backwardsPoint).! !

!MarsRover methodsFor: 'execution-private' stamp: 'mf 5/16/2022 15:49:48'!
moveFoward
	
	position _ position + (direction fowardPoint).! !

!MarsRover methodsFor: 'execution-private' stamp: 'mf 5/16/2022 15:32:39'!
rotateLeft
	
	direction _ direction left.! !

!MarsRover methodsFor: 'execution-private' stamp: 'mf 5/16/2022 15:45:31'!
rotateRight
	
	direction _ direction right.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 14:41:20'!
deployedAt: aPosition pointing: aDirection

	^self new initializeAt: aPosition pointing: aDirection.! !


!classDefinition: #MarsRoverCardinalDirection category: 'Mars-Rover'!
Object subclass: #MarsRoverCardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverCardinalDirection methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:24:47'!
asString
	
	self subclassResponsibility! !

!MarsRoverCardinalDirection methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:55:17'!
backwardsPoint
	
	self subclassResponsibility! !

!MarsRoverCardinalDirection methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:50:41'!
fowardPoint
	
	self subclassResponsibility! !

!MarsRoverCardinalDirection methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:33:14'!
left
	
	self subclassResponsibility.! !

!MarsRoverCardinalDirection methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:44:03'!
right
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCardinalDirection class' category: 'Mars-Rover'!
MarsRoverCardinalDirection class
	instanceVariableNames: ''!

!MarsRoverCardinalDirection class methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:17:34'!
canHandle: aDirection
	self subclassResponsibility! !

!MarsRoverCardinalDirection class methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:24:10'!
pointing: aDirection

	^(self subclasses detect:[:subclass| subclass canHandle: aDirection]) new.

! !


!classDefinition: #East category: 'Mars-Rover'!
MarsRoverCardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!East methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:30:58'!
asString
	
	^'E'! !

!East methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:55:31'!
backwardsPoint
	
	^(-1@0)! !

!East methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:51:54'!
fowardPoint
	
	^(1@0)! !

!East methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:34:00'!
left
	
	^North new! !

!East methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:44:15'!
right
	
	^South new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'Mars-Rover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:30:20'!
canHandle: aDirection
	
	^(aDirection = 'E')! !


!classDefinition: #North category: 'Mars-Rover'!
MarsRoverCardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!North methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:31:04'!
asString
	
	^'N'! !

!North methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:55:41'!
backwardsPoint
	
	^(0@-1)! !

!North methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:51:46'!
fowardPoint
	
	^(0@1)! !

!North methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:33:56'!
left
	
	^West new! !

!North methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:44:30'!
right
	
	^East new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'Mars-Rover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:30:12'!
canHandle: aDirection
	
	^(aDirection = 'N')! !


!classDefinition: #South category: 'Mars-Rover'!
MarsRoverCardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!South methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:31:12'!
asString
	
	^'S'! !

!South methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:55:49'!
backwardsPoint
	
	^(0@1)! !

!South methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:52:24'!
fowardPoint
	
	^(0@-1)! !

!South methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:34:18'!
left
	
	^East new.! !

!South methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:44:48'!
right
	
	^West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'Mars-Rover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:29:02'!
canHandle: aDirection
	
	^(aDirection = 'S')! !


!classDefinition: #West category: 'Mars-Rover'!
MarsRoverCardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!West methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:31:19'!
asString
	
	^'O'! !

!West methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:55:58'!
backwardsPoint
	
	^(1@0)! !

!West methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:52:40'!
fowardPoint
	
	^(-1@0)! !

!West methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:42:16'!
left
	
	^South new.! !

!West methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:45:01'!
right
	
	^North new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'Mars-Rover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'mf 5/16/2022 15:30:31'!
canHandle: aDirection
	
	^(aDirection = 'O')! !
