# LoanApplicationReviewer

This is my solution to a code challenge from an interview, [based off an earlier attempt](https://github.com/dnoc/LoanApplicationReviewer).

I got a little over my head with starting a new Rails project for a small challenge, so I moved my solution out to a cleaner repo.

The prompt can be viewed [here](./prompt.md), but essentially it's a script to review and approve/deny mortgage applications.

## How to run

1. Pull this repo and make sure you have `ruby` installed.

1. Create an input file matching the schema [here](./prompt.md#schema), or use the existing `input.txt`.

1. In a terminal run the ruby script with the input file e.g. ```ruby review_applications.rb input.txt```

## How to test

1. Pull this repo and make sure you have `ruby` installed.

1. Navigate to the base directory.

1. In a terminal run the spec, e.g. ```rspec -f d spec/```

## Initial thoughts (chronological order)

This is the abridged version, [more thoughts in the other repo.](https://github.com/dnoc/LoanApplicationReviewer/blob/main/README.md)

Normally in a prod situation we'd probably have a request in json or similar to a controller that we can check conforms to an object,
but here I guess I need a class or at least private function to create objects from the text file.

This is a great example for a factory pattern since the string input is supposed to be reliable and one object is created from each line.
The models can define the criteria and the `build` method to keep the responisibility in the class.
In a much more complicated situation we could get into polymorphism but that's obviously not necessary here.

The prompt sort of hints at `Borrower` associations with `Liability` and `Income` containing `name` fields,
but it's not actually used for anything in the `Requirements/Constraints` for the solution.
It'd be useful in a real world example or if the criteria gets extended in the interview.

In a prod situation I would store the `A1/A2` id strings as a string so that they could be saved on repeated runs without issue.
A database id is a lot more consistent than any user input e.g. an email, username, application name.

It's not as relevant since I'm not using a database but I chose to use `BigDecimal` instead of integers in cents for money, because I'm guaranteed to be doing division and I might as well save myself the conversion. It goes without saying that float is very inconsistent for this kind of thing.

Decided to create an ApplicationDecision as a historical record with `attr_reader` only,
since a company would want a record of the inputs and outputs of the approval decision.
Even more useful if the Borrower associations existed and the liabilities/incomes ever changed.

## Retrospective

I spent a lot of time setting up my dev environment, as this is my personal Windows machine and I didn't have the required Rails packages.
Turns out it's a major pain! Just installing ruby took some futsing with the Powershell script permissions.

It's a lot easier to do this sort of project as well when you can double-check against coworkers's code for simple formatting stuff like rails migration syntax or using `Dir` to require the correct files. I have google and a copy of the Rails Way but it's definitely slower.

While it's important to show off how much I know about validations, schema, and relations, it's much more important to get this done and running.