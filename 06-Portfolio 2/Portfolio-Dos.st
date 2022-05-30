!classDefinition: #AccountSummaryTest category: 'Portfolio-Dos'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'FM 5/29/2022 17:02:54'!
test01EmptyAccountHasCleanSummaryText
	
	| account summary summaryReporter |
	
	account _ ReceptiveAccount new.
	summaryReporter _ AccountSummaryReporter report: account.
	
	summary _ summaryReporter readReport.
	
	self assert: 'Balance = 0.' equals: summary nextLine.
	self assert: summary atEnd.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FM 5/29/2022 17:03:28'!
test02DepositsOnAccountAppearOnSummary
	
	| account summary summaryReporter |
	
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	summaryReporter _ AccountSummaryReporter report: account.
	
	summary _ summaryReporter readReport.
	
	self assert: 'Depósito por 100.' equals: summary nextLine.
	self assert: 'Balance = 100.' equals: summary nextLine.
	self assert: summary atEnd.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FM 5/29/2022 17:03:58'!
test03WithdrawalsOnAccountAppearOnSummary
	
	| account summary summaryReporter |
	
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	summaryReporter _ AccountSummaryReporter report: account.
	
	summary _ summaryReporter readReport.
	
	self assert: 'Depósito por 100.' equals: summary nextLine.
	self assert: 'Extracción por 50.' equals: summary nextLine.
	self assert: 'Balance = 50.' equals: summary nextLine.
	self assert: summary atEnd.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FM 5/29/2022 17:04:22'!
test04TransfersFromAccountAppearOnSummary
	
	| accountBeeingReported accountNotBeeingReported summary summaryReporter |
	
	accountBeeingReported _ ReceptiveAccount new.
	accountNotBeeingReported _ ReceptiveAccount new.
	Deposit register: 100 on: accountBeeingReported.
	Withdraw register: 50 on: accountBeeingReported.
	Transfer ammount: 20 from: accountBeeingReported to: accountNotBeeingReported.
	summaryReporter _ AccountSummaryReporter report: accountBeeingReported.
	
	summary _ summaryReporter readReport.
	
	self assert: 'Depósito por 100.' equals: summary nextLine.
	self assert: 'Extracción por 50.' equals: summary nextLine.
	self assert: 'Salida por transferencia de 20.' equals: summary nextLine.
	self assert: 'Balance = 30.' equals: summary nextLine.
	self assert: summary atEnd.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FM 5/29/2022 17:04:35'!
test05TransfersToAccountAppearOnSummary
	
	| accountBeeingReported accountNotBeeingReported summary summaryReporter |
	
	accountBeeingReported _ ReceptiveAccount new.
	accountNotBeeingReported _ ReceptiveAccount new.
	Deposit register: 100 on: accountBeeingReported.
	Withdraw register: 50 on: accountBeeingReported.
	Transfer ammount: 20 from: accountBeeingReported to: accountNotBeeingReported.
	Transfer ammount: 30 from: accountNotBeeingReported to: accountBeeingReported.
	summaryReporter _ AccountSummaryReporter report: accountBeeingReported.
	
	summary _ summaryReporter readReport.
	
	self assert: 'Depósito por 100.' equals: summary nextLine.
	self assert: 'Extracción por 50.' equals: summary nextLine.
	self assert: 'Salida por transferencia de 20.' equals: summary nextLine.
	self assert: 'Entrada por transferencia de 30.' equals: summary nextLine.
	self assert: 'Balance = 60.' equals: summary nextLine.
	self assert: summary atEnd.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'mf 5/30/2022 15:40:44'!
test06PortfolioWithAccountsReportsAccountsSummeryAndBalance
	
	| portfolio summary summaryReporter |
	
	portfolio _ self portfolioWithTwoAccountsAndTransactions.
	summaryReporter _ AccountSummaryReporter report: portfolio.
	
	summary _ summaryReporter readReport.
	
	self assertPortfolioWithTwoAccountsAndTransactionsSummaryEquals: summary.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'mf 5/30/2022 15:42:01'!
test07PortfolioWithAPortfolioReportsCorrectly
	
	| portfolioNotBeeingReported portfolioBeeingReported summary summaryReporter |
	
	portfolioBeeingReported  _ Portfolio new.
	portfolioNotBeeingReported _ self portfolioWithTwoAccountsAndTransactions.
	portfolioBeeingReported add: portfolioNotBeeingReported.
	summaryReporter _ AccountSummaryReporter report: portfolioBeeingReported .
	
	summary _ summaryReporter readReport.
	
	self assertPortfolioWithTwoAccountsAndTransactionsSummaryEquals: summary.
	
	! !


!AccountSummaryTest methodsFor: 'set up' stamp: 'mf 5/30/2022 15:38:17'!
portfolioWithTwoAccountsAndTransactions	
	| portfolio account1 account2 |
	
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio add: account1.
	portfolio add: account2.
	Deposit register: 100 on: account1.
	Transfer ammount: 27 from: account1 to: account2.
	Withdraw register: 12 on: account2.
	
	^portfolio! !


!AccountSummaryTest methodsFor: 'assertions' stamp: 'mf 5/30/2022 15:40:44'!
assertPortfolioWithTwoAccountsAndTransactionsSummaryEquals: summary

	self assert: 'Depósito por 100.' equals: summary nextLine.
	self assert: 'Salida por transferencia de 27.' equals: summary nextLine.
	self assert: 'Entrada por transferencia de 27.' equals: summary nextLine.
	self assert: 'Extracción por 12.' equals: summary nextLine.
	self assert: 'Balance = 88.' equals: summary nextLine.
	self assert: summary atEnd! !


!classDefinition: #PortfolioTest category: 'Portfolio-Dos'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'mf 5/27/2022 00:55:27'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100)).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Dos'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mf 5/30/2022 16:25:07'!
test08TransferAdjustsBalancesOnTransfer
	
	self assert: [:accountSender :accountReciver :transfer | 
		
		self assert: (-100) equals: accountSender balance.
		self assert: 100 equals: accountReciver balance.] 
	
	givenTwoAccountsAndATransferBetweenOf: 100.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mf 5/30/2022 16:25:16'!
test09AccountsHasTransferRegistered

	self assert: [:accountSender :accountReciver :transfer | 
		
		self assert: (accountSender hasRegistered: transfer).
		self assert: (accountReciver hasRegistered: transfer).] 
	
	givenTwoAccountsAndATransferBetweenOf: 100.
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mf 5/30/2022 16:25:22'!
test10TransferValueIsCorrect

	self assert: [:accountSender :accountReciver :transfer | 
		
		self assert: 100 equals: transfer value] 
	
	givenTwoAccountsAndATransferBetweenOf: 100.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mf 5/30/2022 16:24:57'!
test11TransferKnowsItsReciever

	self assert: [:accountSender :accountReciver :transfer | 
		
		self assert: accountReciver equals: (transfer reciver).] 
	
	givenTwoAccountsAndATransferBetweenOf: 100.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mf 5/30/2022 16:25:43'!
test12TransferKnowsItsSender

	self assert: [:accountSender :accountReciver :transfer | 
		
		self assert: accountSender equals: (transfer sender ).] 
	
	givenTwoAccountsAndATransferBetweenOf: 100.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mf 5/30/2022 16:27:36'!
test13SenderKnowsTheReciverOfTransfer

	self assert: [:accountSender :accountReciver :transfer | 
		| transferStoredOnSender | 
		
		transferStoredOnSender _ (accountSender transactions) first.
		self assert: accountReciver equals: transferStoredOnSender reciver.] 
	
	givenTwoAccountsAndATransferBetweenOf: 100.
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mf 5/30/2022 16:28:58'!
test14ReciverKnowsTheSenderOfTransference

	self assert: [:accountSender :accountReciver :transfer | 
		| transferStoredOnReciver | 
		
		transferStoredOnReciver _ (accountReciver transactions) first.
		self assert: accountSender equals: transferStoredOnReciver sender.] 
	
	givenTwoAccountsAndATransferBetweenOf: 100.! !



!ReceptiveAccountTest methodsFor: 'assertions' stamp: 'mf 5/30/2022 16:20:06'!
assert: aBlock givenTwoAccountsAndATransferBetweenOf: aValue 
	
	| reciverAccount senderAccount transfer |
	senderAccount _ ReceptiveAccount new.
	reciverAccount _ ReceptiveAccount new.
	transfer _ Transfer ammount: aValue from: senderAccount to: reciverAccount.
	
	aBlock value: senderAccount value: reciverAccount value: transfer.! !


!classDefinition: #TransferNetTest category: 'Portfolio-Dos'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!TransferNetTest methodsFor: 'tests' stamp: 'FM 5/29/2022 16:59:48'!
test01NewAccountHasCleanReport
	
	| account transferNetReporter |
	
	account _ ReceptiveAccount new.
	transferNetReporter _ AccountTransferNetReporter report: account.
	
	self assert: 0 equals: transferNetReporter readReport.! !

!TransferNetTest methodsFor: 'tests' stamp: 'FM 5/29/2022 17:01:33'!
test02TransfersFromAccountAreReported
	
	| accountBeeingReported accountNotBeeingReported transferNetReporter |
	
	accountBeeingReported _ ReceptiveAccount new.
	accountNotBeeingReported _ ReceptiveAccount new.
	Transfer ammount: 100 from: accountBeeingReported to: accountNotBeeingReported.
	transferNetReporter _ AccountTransferNetReporter report: accountBeeingReported.
	
	self assert: -100 equals: transferNetReporter readReport.! !

!TransferNetTest methodsFor: 'tests' stamp: 'FM 5/29/2022 17:04:46'!
test03TransfersToAccountAreReported
	
	| accountBeeingReported accountNotBeeingReported transferNetReporter |
	
	accountBeeingReported _ ReceptiveAccount new.
	accountNotBeeingReported _ ReceptiveAccount new.
	Transfer ammount: 100 from: accountBeeingReported to: accountNotBeeingReported.
	Transfer ammount: 50 from: accountNotBeeingReported to: accountBeeingReported.
	transferNetReporter _ AccountTransferNetReporter report: accountBeeingReported.
	
	self assert: -50 equals: transferNetReporter readReport.! !


!classDefinition: #Account category: 'Portfolio-Dos'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'mf 5/27/2022 03:05:27'!
reportOn: aReporter

	self subclassResponsibility! !

!Account methodsFor: 'reports' stamp: 'mf 5/30/2022 15:28:15'!
reportTransactions: aReporter

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Dos'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'mf 5/30/2022 15:34:18'!
reportOn: aReporter

	self reportTransactionsOn: aReporter.
	aReporter reportBalance: self balance.! !

!Portfolio methodsFor: 'reports' stamp: 'mf 5/30/2022 15:34:18'!
reportTransactionsOn: aReporter

	^ accounts do: [:account | account reportTransactionsOn: aReporter]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Dos'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Dos'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'mf 5/26/2022 02:31:53'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction |				transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'mf 5/30/2022 15:27:22'!
reportOn: aReporter

	
	self reportTransactionsOn: aReporter.
	aReporter reportBalance: self balance.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'mf 5/30/2022 15:27:22'!
reportTransactionsOn: aReporter

	^ transactions do: [:aTransaction | aTransaction reportTransactionOn: aReporter]! !


!classDefinition: #AccountTransaction category: 'Portfolio-Dos'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'mf 5/27/2022 03:06:31'!
reportTransactionOn: aReporter
	 
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Dos'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Dos'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'mf 5/27/2022 02:39:11'!
reportTransactionOn: aReporter 
	
	aReporter reportDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Dos'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferParts category: 'Portfolio-Dos'!
AccountTransaction subclass: #TransferParts
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!TransferParts methodsFor: 'comparing' stamp: 'mf 5/27/2022 03:00:23'!
= anObject
	
	^transfer = anObject! !


!TransferParts methodsFor: 'balance' stamp: 'mf 5/26/2022 02:24:00'!
affectBalance: aBalance
	
	self subclassResponsibility! !


!TransferParts methodsFor: 'initialization' stamp: 'mf 5/27/2022 03:00:23'!
initializeFrom: aTransference
	 
	transfer _ aTransference! !


!TransferParts methodsFor: 'value' stamp: 'mf 5/27/2022 03:00:23'!
value
	
	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferParts class' category: 'Portfolio-Dos'!
TransferParts class
	instanceVariableNames: ''!

!TransferParts class methodsFor: 'instance creation' stamp: 'mf 5/26/2022 02:02:57'!
from: aTransference
	
	^ self new initializeFrom: aTransference! !


!classDefinition: #TransferInput category: 'Portfolio-Dos'!
TransferParts subclass: #TransferInput
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!TransferInput methodsFor: 'balance' stamp: 'mf 5/27/2022 03:00:23'!
affectBalance: aBalance
	
	^aBalance + (transfer value)! !


!TransferInput methodsFor: 'reports' stamp: 'mf 5/27/2022 03:31:44'!
reportTransactionOn: aReporter 
	
	aReporter reportInputTransfer: self! !


!TransferInput methodsFor: 'parts' stamp: 'mf 5/30/2022 16:04:14'!
sender
	
	^transfer sender! !


!classDefinition: #TransferOutput category: 'Portfolio-Dos'!
TransferParts subclass: #TransferOutput
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!TransferOutput methodsFor: 'balance' stamp: 'mf 5/27/2022 03:00:23'!
affectBalance: aBalance
	
	^aBalance - (transfer value)! !


!TransferOutput methodsFor: 'reports' stamp: 'mf 5/27/2022 02:57:04'!
reportTransactionOn: aReporter 
	
	aReporter reportOutputTransfer: self! !


!TransferOutput methodsFor: 'parts' stamp: 'mf 5/30/2022 16:02:35'!
reciver
	
	^transfer reciver! !


!TransferOutput methodsFor: 'as yet unclassified' stamp: 'mf 5/30/2022 16:03:42'!
sender
	self shouldBeImplemented.! !


!classDefinition: #Withdraw category: 'Portfolio-Dos'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'mf 5/27/2022 02:46:38'!
reportTransactionOn: aReporter 
	
	aReporter reportWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Dos'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reporter category: 'Portfolio-Dos'!
Object subclass: #Reporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!Reporter methodsFor: 'read report' stamp: 'mf 5/27/2022 03:11:26'!
readReport
	
	self subclassResponsibility! !


!Reporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:17:23'!
reportBalance: aBalance
	
! !

!Reporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:21:40'!
reportDeposit: aDeposit! !

!Reporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:31:44'!
reportInputTransfer: aTransferInput! !

!Reporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:21:54'!
reportTransferOutput: aTransferOutput! !

!Reporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:22:02'!
reportWithdraw: aWithdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Reporter class' category: 'Portfolio-Dos'!
Reporter class
	instanceVariableNames: ''!

!Reporter class methodsFor: 'instance creation' stamp: 'mf 5/27/2022 03:08:09'!
report: anAccount 
	
	| reporter |
	reporter _  self new.
	anAccount reportOn: reporter.
	^reporter ! !


!classDefinition: #AccountSummaryReporter category: 'Portfolio-Dos'!
Reporter subclass: #AccountSummaryReporter
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!AccountSummaryReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 02:58:39'!
report: string for: aTransaction

	^ summary nextPutAll: string, aTransaction value asString,'.'; newLine! !

!AccountSummaryReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 02:59:43'!
reportBalance: aBalance 
	
	summary nextPutAll: 'Balance = ', aBalance asString,'.'.! !

!AccountSummaryReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 02:50:52'!
reportDeposit: aDeposit 
	
	self report: 'Depósito por ' for: aDeposit.! !

!AccountSummaryReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:31:44'!
reportInputTransfer: aTransferInput 
	
	self report: 'Entrada por transferencia de ' for: aTransferInput! !

!AccountSummaryReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 02:58:12'!
reportOutputTransfer: aTransferenceSender 
	
	self report: 'Salida por transferencia de ' for: aTransferenceSender! !

!AccountSummaryReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 02:51:41'!
reportWithdraw: aWithdraw 
	
	self report: 'Extracción por ' for: aWithdraw! !


!AccountSummaryReporter methodsFor: 'read report' stamp: 'mf 5/27/2022 02:33:52'!
readReport
	
	^ReadStream on: summary contents! !


!AccountSummaryReporter methodsFor: 'initialization' stamp: 'mf 5/27/2022 02:32:35'!
initialize
	
	summary _ WriteStream on: ''.! !


!classDefinition: #AccountTransferNetReporter category: 'Portfolio-Dos'!
Reporter subclass: #AccountTransferNetReporter
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!AccountTransferNetReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:30:25'!
reportInputTransfer: aTransferOutput 
	
	transferNet _ transferNet + aTransferOutput value! !

!AccountTransferNetReporter methodsFor: 'write report' stamp: 'mf 5/27/2022 03:27:09'!
reportOutputTransfer: aTransferOutput 
	
	transferNet _ transferNet - aTransferOutput value! !


!AccountTransferNetReporter methodsFor: 'read report' stamp: 'mf 5/27/2022 03:16:30'!
readReport
	
	^transferNet! !


!AccountTransferNetReporter methodsFor: 'initialization' stamp: 'mf 5/27/2022 03:15:45'!
initialize
	
	transferNet _ 0! !


!classDefinition: #Transfer category: 'Portfolio-Dos'!
Object subclass: #Transfer
	instanceVariableNames: 'value sender reciver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Dos'!

!Transfer methodsFor: 'initialization' stamp: 'mf 5/25/2022 21:51:56'!
initializeAmmount: aValue from: aSenderAccount to: aReciverAccount 
	
	value _ aValue.
	sender _ aSenderAccount.
	reciver _ aReciverAccount. ! !


!Transfer methodsFor: 'value' stamp: 'mf 5/26/2022 01:48:07'!
value
	
	^value! !


!Transfer methodsFor: 'parts' stamp: 'mf 5/26/2022 01:52:10'!
reciver
	
	^reciver! !

!Transfer methodsFor: 'parts' stamp: 'mf 5/26/2022 01:51:47'!
sender

	^sender! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Dos'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'mf 5/27/2022 03:01:17'!
ammount: anAmmountOfMoney from: aSenderAccount to: aReciverAccount 
	
	| transfer |
	transfer _ self new initializeAmmount: anAmmountOfMoney from: aSenderAccount to: aReciverAccount.
	aSenderAccount register: (TransferOutput from: transfer ).
	aReciverAccount register: (TransferInput from: transfer).
	^transfer! !
