# Lab 07 — From Requirement to FS

**Module 7 · about 40 minutes**

## Goal

Turn a one-line business request into a functional spec you would be willing
to put your name on.

## The request

> "Customers keep calling to ask where their order is. Give them a way to see
> it themselves, and let support cancel an order before it ships."

That is all a business owner usually gives you.

## Steps

1. Read `.kiro/specs/order-tracking/` first — requirements, design, tasks.
   This is what "FS" means in Kiro terms. Notice every acceptance criterion is
   one sentence: WHEN something, THE SYSTEM SHALL do something.
2. Start a new spec from the request above (+ under Specs, Feature,
   Requirements-First).
3. **Review the requirements before you approve them.** Check for the three
   things Kiro cannot know: the statuses a customer may see, who is allowed to
   cancel, and what happens to a cancelled order that was already packed.
4. Correct them in your own words, then approve. Let it generate the design.
5. Compare its design with the committed `design.md`. Where it differs, decide
   which one is right — it is not automatically yours.
6. Open `tasks.md` and run task 6 (the HTTP layer). Watch `api-conventions.md`
   attach itself as soon as a file appears under `src/api/`.

## Checkpoint

Every acceptance criterion you approved can be read aloud to the business owner
without translation, and turned into a test without rewriting.

## Watch out

If Kiro offers to enter its own spec mode while you are running the AI-DLC
workflow, say no. One workflow owns the flow at a time.
