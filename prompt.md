# Code Sample

For this portion of our interview process, we'd like you to put together some code to solve a problem related to our business.

## Problem

At a high level, what we'd like you to do is accept some borrowers' applications for mortgages and tell us which borrowers are or are not eligible.
When deciding whether we will give someone a mortgage, two factors that we consider are debt-to-income (or DTI) ratio and credit score. 
While this sounds like a fairly straightforward calculation, there are some interesting aspects that we'll dig into.

First, though, let's take a look at what you can expect to receive as input and what we'd like to see as output:

### Input

```
APPLICATION A1
LOAN A1 313000 15 2.5 1420.20
BORROWER A1 John 720
LIABILITY A1 John CreditCard 35.14 1491.24
COBORROWER A1 Jane 750
LIABILITY A1 Jane CreditCard 10.14 20.24
LIABILITY A1 Jane,John Mortgage 1230.41 235194.10
INCOME A1 John Salary 4021.29
INCOME A1 Jane Salary 4523.14
INCOME A1 Jane ChildSupport 203.14

APPLICATION A2
LOAN A2 145000 30 3.1 810.20
BORROWER A2 John 621
LIABILITY A2 John CreditCard 1304.00 20000.10
INCOME A2 John Salary 1900.00
COBORROWER A2 Jane 750
LIABILITY A2 Jane CreditCard 12.10 130.22
INCOME A2 Jane Salary 2000.00
```

#### Schema

`APPLICATION {APPLICATION_ID}`

`LOAN {APPLICATION_ID} {PRINCIPAL_AMOUNT} {YEARS} {RATE} {MONTHLY_PAYMENT}`

`BORROWER {APPLICATION_ID} {NAME} {CREDIT_SCORE}`

`COBORROWER {APPLICATION_ID} {NAME} {CREDIT_SCORE}`

`LIABILITY {APPLICATION_ID} {COMMA_SEPARATED_NAMES} {KIND} {MONTHLY_PAYMENT} {OUTSTANDING_BALANCE}`

`INCOME {APPLICATION_ID} {NAME} {KIND} {MONTHLY_AMOUNT}`

### Output

```
Summary: 1 application approved, 2 applications received, 50.0% approval rate

A1: approved, DTI: 0.307, Credit Score: 720
A2: denied, DTI: 0.545, Credit Score: 621
```

### Requirements and constraints

Below, we'll list out some requirements and constraints.
If you run into any questions or ambiguity in your implementation, go ahead and take ownership of that decision.

#### Requirements

- An application requires a borrower
- An application does not require a coborrower
- An application will not have more than one borrower and one coborrower
- An application requires loan information
- A borrower/coborrower may or may not have liabilities and income
- Anything scoped to an application only affects that application
  - For example, John from application A1 is not the same as John from application A2
- An application is approved if the DTI ratio is less than 50% and the credit score is greater than 620
- An application's credit score is the lower of the borrower and coborrower's credit scores
- An application's DTI ratio is the total monthly liability, including the loan for which they are applying, divided by their monthly income
  - Any liability which will be fully paid off in 10 payments does not contribute to DTI
  - Joint liabilities (tied to both the borrower and coborrower) should only be counted once per application
- The detailed per-application output should be in the order in which applications were started

#### Constraints

- The input can be read from either a file or STDIN (it is not necessary to support both)
- The output should be written to STDOUT
- The input will match the schema and example provided (don't worry about being passed a string instead of a decimal)
- Whitespace is used to separate arguments (and will not appear in a name, identifier, or anywhere else)
- The input will be referentially correct
  - Application A1 will be provided before A2 is referenced later
  - Borrower John will be provided before John's income/liabilities are provided
  - Etc.

## Solution/Expectations

While we don't expect anyone to spend more than a few hours on this,
we'd like this to be a representative example of how you would solve this problem in production.
Feel free to use whichever language you're most comfortable in (we want to see how you work best, not that you can work in our stack).

In addition to the code itself, we'd also like a README outlining:

- Instructions to run your solution
- Instructions to test your solution
- A description of your design and _why_ you landed there
- Any additional assumptions or decisions you made outside of the listed requirements and constraints
