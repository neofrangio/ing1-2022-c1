!classDefinition: #CartTest category: 'TusLibros.com'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:30:11'!
test01cantAddProductThatsNotInCatalogue
	
	| cart |
	cart _ self cartWithEmptyCatalogue.
	
	self should: [cart add: 1]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: Cart productNotInCatalogue.
			self assert: cart isEmpty.
			]
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:31:36'!
test02CartIncludesAddedProduct
	
	| cart |
	cart _ self cartWith1InCatalogue.
	
	cart add: 1.
	
	self assert: (cart includes: 1).! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:31:54'!
test03CartWithProductsIsNotEmpty
	
	| cart |
	cart _ self cartWith1InCatalogue.
	
	cart add: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:30:11'!
test04QuantityOfProductNotInCartIsCero
	
	| cart |
	cart _ self cartWithEmptyCatalogue.
	
	self assert: 0 equals: (cart quantityOf: 1).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:30:58'!
test05QuantityOfProductAddedOnceIsOne
	
	| cart |
	cart _ self cartWith1InCatalogue.
	
	cart add: 1.
	
	self assert: 1 equals: (cart quantityOf: 1).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:30:58'!
test06QuantityOfProductAddedTwiceIsTwo
	
	| cart |
	cart _ self cartWith1InCatalogue.
	
	cart add: 1.
	cart add: 1.
	
	self assert: 2 equals: (cart quantityOf: 1).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:30:58'!
test07AddingMultipleCopiesOfProduct
	
	| cart |
	cart _ self cartWith1InCatalogue.
	
	cart add: 2 ofProduct: 1.
	
	self assert: 2 equals: (cart quantityOf: 1).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:30:58'!
test08CantAddNegativeQuantityOfProduct
	
	| cart |
	cart _ self cartWith1InCatalogue.

	self should: [cart add: -1 ofProduct: 1]
		raise: Error
		withExceptionDo: [:anError |
			self assert: Cart quantityAddedShouldBePostivie equals: anError messageText.
			self assert: cart isEmpty.
			]
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/6/2022 03:30:58'!
test09CantAddNotIntegerQuantityOfProduct
	
	| cart |
	cart _ self cartWith1InCatalogue.

	self should: [cart add: 0.2 ofProduct: 1]
		raise: Error
		withExceptionDo: [:anError |
			self assert: Cart quantityShouldBeAnInteger equals: anError messageText.
			self assert: cart isEmpty.
			]
	! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 19:23:16'!
test10ProductsListHasSameProductsAsCart
	
	| cart products |
	cart _ self cartWith1InCatalogue.

	cart add: 2 ofProduct: 1.
	products _  Bag new.
	products add: 1 withOccurrences: 2. 
	
	self assert: products equals: cart productList.! !


!CartTest methodsFor: 'set up' stamp: 'mf 6/6/2022 03:30:58'!
cartWith1InCatalogue

	^ Cart fromCatalogue: (OrderedCollection  with: 1)! !

!CartTest methodsFor: 'set up' stamp: 'mf 6/6/2022 03:30:11'!
cartWithEmptyCatalogue

	^ Cart fromCatalogue: OrderedCollection new! !


!classDefinition: #CashierTest category: 'TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CashierTest methodsFor: 'tests' stamp: 'DW 6/6/2022 19:36:07'!
test01

	| cart cashier paymentMethod |
	
	cashier _ Cashier new.
	cart _ Cart fromCatalogue: OrderedCollection new.
	
	self should: [ cashier checkout: cart paidWith: paymentMethod.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier cartIsEmpty.
			"Revisar que no se haya registrado la compra? Tal vez en el log de recibos impresos, como para que la AFIP no nos reviente"
			]! !


!classDefinition: #PricesListTest category: 'TusLibros.com'!
TestCase subclass: #PricesListTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!PricesListTest methodsFor: 'tests' stamp: 'DW 6/6/2022 20:36:14'!
test01
	
	
	| eShop |
	eShop _ PricesList new.
	
	self should: [eShop add: 'Harry potter' withPrice: 'asdfj']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 
			[:anError | 
				self assert: anError messageText equals: PricesList productPriceIsNotANumber.
				self assert: eShop doesNotHaveProducts].! !


!classDefinition: #Cart category: 'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'catalogue products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'adding' stamp: 'mf 6/5/2022 18:29:50'!
add: aProduct

	self assertAProductIsInCatalogue: aProduct.
	products add: aProduct.
	
	! !

!Cart methodsFor: 'adding' stamp: 'mf 6/6/2022 03:33:17'!
add: aQuantity ofProduct: aProduct 

	self assertAProductIsInCatalogue: aProduct.
	self assertIsAValidQuantity: aQuantity.
	products add: aProduct withOccurrences: aQuantity.! !


!Cart methodsFor: 'initialization' stamp: 'mf 6/5/2022 18:44:40'!
initializeFromCatalogue: aCatalogue 
	
	catalogue _ aCatalogue.
	products _ Bag new! !


!Cart methodsFor: 'assertions' stamp: 'mf 6/5/2022 18:22:03'!
assertAProductIsInCatalogue: aProduct
	
	(catalogue includes: aProduct) ifFalse: [self error: Cart productNotInCatalogue]! !

!Cart methodsFor: 'assertions' stamp: 'FM 6/5/2022 22:52:20'!
assertAQuantityIsAnInteger: aQuantity
	
	(aQuantity isInteger) ifFalse: [self error: Cart quantityShouldBeAnInteger].! !

!Cart methodsFor: 'assertions' stamp: 'FM 6/5/2022 22:52:03'!
assertAQuantityIsPositive: aQuantity
	
	(aQuantity > 0) ifFalse: [self error: Cart quantityAddedShouldBePostivie ].! !

!Cart methodsFor: 'assertions' stamp: 'mf 6/6/2022 03:33:17'!
assertIsAValidQuantity: aQuantity

	self assertAQuantityIsPositive: aQuantity.
	self assertAQuantityIsAnInteger: aQuantity! !


!Cart methodsFor: 'testing' stamp: 'mf 6/5/2022 18:30:59'!
includes: aProduct
	
	^products includes: aProduct! !

!Cart methodsFor: 'testing' stamp: 'mf 6/5/2022 18:33:55'!
isEmpty
	
	^products isEmpty! !

!Cart methodsFor: 'testing' stamp: 'mf 6/5/2022 18:45:39'!
quantityOf: aProduct 
	
	^products occurrencesOf: aProduct! !


!Cart methodsFor: 'accessing' stamp: 'DW 6/6/2022 19:23:49'!
productList
	
	^products copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'mf 6/5/2022 18:17:47'!
fromCatalogue: aCatalogue
	
	^self new initializeFromCatalogue: aCatalogue ! !


!Cart class methodsFor: 'error messages' stamp: 'mf 6/5/2022 18:19:00'!
productNotInCatalogue
	
	^'Product is not in catalogue'! !

!Cart class methodsFor: 'error messages' stamp: 'FM 6/5/2022 22:43:31'!
quantityAddedShouldBePostivie
	
	^'Quantity of added product should be positive'! !

!Cart class methodsFor: 'error messages' stamp: 'FM 6/5/2022 22:47:19'!
quantityShouldBeAnInteger
	
	^'Quantity of added product should be an integer'! !


!classDefinition: #Cashier category: 'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'checkout' stamp: 'DW 6/6/2022 20:39:00'!
checkout: aCart paidWith: aPaymentMethod 
	
	self assertCartIsNotEmpty: aCart.! !


!Cashier methodsFor: 'assertions' stamp: 'DW 6/6/2022 19:34:49'!
assertCartIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: Cashier cartIsEmpty]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'DW 6/6/2022 19:31:07'!
cartIsEmpty
	
	^'Cant checkout empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'DW 6/6/2022 19:42:37'!
productNotInCatalogue
	
	^'A product is not in catalogue'! !


!classDefinition: #PricesList category: 'TusLibros.com'!
Object subclass: #PricesList
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!
