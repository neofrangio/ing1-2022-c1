!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 13:34:26'!
test01emptyPortfolioBalanceIsZero
	
	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:47:13'!
test02portfolioWithOneAccountBalanceEqualsAccountBalance
	
	| portfolio account |
	
	portfolio _ Portfolio new.
	account _ self addNewAccountWithADepositOf: 100 andAWithdrawOf: 50 to: portfolio.
	
	
	self assert: (account balance) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:48:11'!
test03portfolioWithOneAccountAndOnotherPortfolioBalanceEqualsTheSumOfEveryAccountsBalance
	
	| portfolio1 account1  portfolio2 account2|
	
	portfolio1 _ Portfolio new.
	account1 _ self addNewAccountWithADepositOf: 100 andAWithdrawOf: 50 to: portfolio1.
	
	portfolio2 _ Portfolio new.
	account2 _ self addNewAccountWithADepositOf: 75 andAWithdrawOf: 12 to: portfolio2.
	
	portfolio1 add: portfolio2.
	
	
	self assert: ((account1 balance) + (account2 balance)) equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:57:32'!
test04portfolioKnowsRegisteredTransactions
	
	| portfolio1 account1  portfolio2 account2 account3 transaction3 |
	
	portfolio1 _ Portfolio new.
	account1 _ self addNewAccountWithADepositOf: 100 andAWithdrawOf: 50 to: portfolio1.
	
	portfolio2 _ Portfolio new.
	account2 _ self addNewAccountWithADepositOf: 75 andAWithdrawOf: 12 to: portfolio2.
	
	portfolio1 add: portfolio2.
	
	account3 _ ReceptiveAccount new.
	transaction3 _ Deposit register:87 on: account3.
	
	self assertPortfolio: portfolio1 hasRegisteredAllTransactionsOf: account1.
	self assertPortfolio: portfolio1 hasRegisteredAllTransactionsOf: account2.
	self deny: (portfolio1 hasRegistered: transaction3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:26:08'!
test05emptyPortfolioHasNoTransactions
	
	| portfolio |
	
	portfolio _ Portfolio new.

	self assert:	 (portfolio transactions) isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 16:02:47'!
test06portfolioKnowsItsTransactions
	
	| portfolio1 account1  portfolio2 account2 |
	
	portfolio1 _ Portfolio new.
	account1 _ self addNewAccountWithADepositOf: 100 andAWithdrawOf: 50 to: portfolio1.
		
	portfolio2 _ Portfolio new.
	account2 _ self addNewAccountWithADepositOf: 75 andAWithdrawOf: 12 to: portfolio2.
	
	portfolio1 add: portfolio2.

	self assert:	 4 equals: (portfolio1 transactions) size.
	self assertPortfolio: portfolio1 hasAllTransactionsOf: account1.
	self assertPortfolio: portfolio1 hasAllTransactionsOf: account2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:31:49'!
test07newPortfolioHasNoAccounts
	
	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: (portfolio accounts) isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 16:04:46'!
test08portfolioKnowsItsAccounts
	
	| portfolio1 portfolio2 account1 account2 account3 |
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ self addNewAccountWithADepositOf: 100 andAWithdrawOf: 50 to: portfolio2.
	account2 _ self addNewAccountWithADepositOf: 100 andAWithdrawOf: 50 to: portfolio2.
	account3 _ self addNewAccountWithADepositOf: 100 andAWithdrawOf: 50 to: portfolio1.

	portfolio1 add: portfolio2.
	
	self assert: 3 equals: (portfolio1 accounts) size.
	self assert: ((portfolio1 accounts) includes: account1).
	self assert: ((portfolio1 accounts) includes: account2).
	self assert: ((portfolio1 accounts) includes: account3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 16:06:04'!
test09canNotAddPortfolioThatHasTheSameAccount
	
	| portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio2 add: account.
	portfolio3 add: account.
	portfolio1 add: portfolio2.
	
	self 
	should: [portfolio1 add: portfolio3]
	raise: Error
	withExceptionDo: [:anError | anError messageText = Portfolio duplicateInformationErrorDescription]
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:37:45'!
test10portfolioIsChildOfOtherPortfolio
	
	| portfolio1 portfolio2  |
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	
	portfolio1 add: portfolio2.
	
	self assert: (portfolio2 isChildOf: portfolio1).
	self deny: (portfolio1 isChildOf: portfolio2)
	
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:37:26'!
test11portfolioIsChildOfMoreThanOneOtherPortfolio
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	
	portfolio1 add: portfolio3.
	portfolio2 add: portfolio3.
	
	self assert: (portfolio3 isChildOf: portfolio1).
	self assert: (portfolio3 isChildOf: portfolio2).
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:39:00'!
test12addingAnAccountCanNotGenerateDuplicateInformationOnAPortfoliosParent
	
	| portfolio1 portfolio2 account |
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio1 add: account.
	portfolio1 add: portfolio2.
	
	self
	should: [portfolio2 add: account]
	raise: Error
	withExceptionDo: [:anError | anError messageText = Portfolio duplicateInformationErrorDescription]
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/23/2022 15:39:22'!
test13canNotAddObjectOtherThanPortfolioOrReceptiveAccount
	
	| portfolio anObject |
	
	portfolio _ Portfolio new.
	anObject _ OrderedCollection new.
		
	self
	should: [portfolio add: anObject]
	raise: Error
	withExceptionDo: [:anError | anError messageText = Portfolio objectAddedUnknownErrorDescription]
	
	
	! !


!PortfolioTest methodsFor: 'set-up' stamp: 'mf 5/23/2022 15:45:48'!
addNewAccountWithADepositOf: anAmmountBeeingDeposit andAWithdrawOf: anAmmountBeeingWithdraw to: aPortfolio
	
	| account |
	
	account _ ReceptiveAccount new.
	Deposit register: anAmmountBeeingDeposit on: account.
	Withdraw register: anAmmountBeeingWithdraw on: account.
	aPortfolio add: account.
	^account! !


!PortfolioTest methodsFor: 'assertions' stamp: 'mf 5/23/2022 16:00:03'!
assertPortfolio: aPortfolio hasAllTransactionsOf: anAccount

	(anAccount transactions) do: [:aTransaction | (self assert: ((aPortfolio transactions) includes: aTransaction))]! !

!PortfolioTest methodsFor: 'assertions' stamp: 'mf 5/23/2022 15:56:39'!
assertPortfolio: aPortfolio hasRegisteredAllTransactionsOf: anAccount

	(anAccount transactions) do: [:aTransaction | (self assert: (aPortfolio hasRegistered: aTransaction))]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'mf 5/21/2022 12:37:26'!
balanceValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'mf 5/21/2022 12:37:43'!
balanceValue

	^ -1 * value ! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'mf 5/21/2022 15:29:21'!
balance
	
	^accountsAndPortfolios sum: [:anAccountOrPortfolio | anAccountOrPortfolio balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'adding' stamp: 'mf 5/23/2022 13:33:07'!
add: anAccountOrPortfolio 
	
	self assertObjectIsAccountOrPortfolio: anAccountOrPortfolio.  
	
	self assertAddingDoesNotGenerateDuplicateInformation: anAccountOrPortfolio.
	
	anAccountOrPortfolio setFather: self.
	
	accountsAndPortfolios add: anAccountOrPortfolio! !


!Portfolio methodsFor: 'initialization' stamp: 'mf 5/23/2022 13:13:45'!
initialize
	
	accountsAndPortfolios _ OrderedCollection new.
	parents _ OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'mf 5/21/2022 15:06:57'!
hasRegistered: aTransaction 
	
	accountsAndPortfolios detect: [:anAccountOrPortfolio | anAccountOrPortfolio hasRegistered: aTransaction] 
	ifNone: [^false].
	
	^true! !

!Portfolio methodsFor: 'testing' stamp: 'mf 5/23/2022 13:13:15'!
isChildOf: aPortfolio 
	
	^parents includes: aPortfolio.! !


!Portfolio methodsFor: 'transactions' stamp: 'mf 5/21/2022 15:18:16'!
transactions
	
	| transactions |
	transactions _ OrderedCollection new.
	accountsAndPortfolios do: [:anAccountOrPortfolio | transactions addAll: (anAccountOrPortfolio transactions)].
	^transactions! !


!Portfolio methodsFor: 'assertions' stamp: 'mf 5/23/2022 13:31:17'!
assertAddingDoesNotGenerateDuplicateInformation: anAccountOrPortfolio

	
	parents 
	do: [:aPortfolioParent | aPortfolioParent assertAddingDoesNotGenerateDuplicateInformation: anAccountOrPortfolio].
	
	parents ifEmpty: [self assertInformationIsNotSharedWith: anAccountOrPortfolio].
	! !

!Portfolio methodsFor: 'assertions' stamp: 'mf 5/23/2022 13:27:22'!
assertInformationIsNotSharedWith: anAccountOrPortfolio

	((anAccountOrPortfolio accounts) allSatisfy: [:anAccount | (self accounts includes: anAccount) not])
	ifFalse: [self error: Portfolio duplicateInformationErrorDescription ]! !

!Portfolio methodsFor: 'assertions' stamp: 'mf 5/21/2022 17:23:26'!
assertObjectIsAccountOrPortfolio: anAccountOrPortfolio

	((anAccountOrPortfolio class ~= ReceptiveAccount) and: (anAccountOrPortfolio class ~= Portfolio))
	
	ifTrue:[self error: Portfolio objectAddedUnknownErrorDescription]! !


!Portfolio methodsFor: 'private' stamp: 'mf 5/21/2022 17:14:04'!
accounts
	
	| accounts |
	accounts _ OrderedCollection new.
	
	accountsAndPortfolios do:  [:anAccountOrPortfolio | accounts addAll: anAccountOrPortfolio accounts].
	
	^accounts! !

!Portfolio methodsFor: 'private' stamp: 'mf 5/23/2022 13:13:30'!
setFather: aPortfolio 
	
	parents add: aPortfolio! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'mf 5/21/2022 16:19:21'!
duplicateInformationErrorDescription
	
	^ 'Adding this object generates duplication of information'! !

!Portfolio class methodsFor: 'error handling' stamp: 'mf 5/21/2022 15:44:00'!
objectAddedUnknownErrorDescription

	^ ' The object you are trying to add is neither an account or a portfolio'
	
	! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'mf 5/21/2022 12:37:55'!
balance

	^transactions sum: [ :aTransaction | aTransaction balanceValue ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'mf 5/21/2022 17:13:09'!
accounts
	
	^ OrderedCollection with: self! !

!ReceptiveAccount methodsFor: 'private' stamp: 'mf 5/23/2022 13:33:29'!
setFather: aPortfolio
	
	! !
