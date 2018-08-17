
<!-- README.md is generated from README.Rmd. Please edit that file -->

# texblocks

Building blocks for TeX tables

## Idea

Assemble LaTeX tabular environments using simple operations.

This would enable us to create any table layout with a consistent user
API.

Defining a new class of R element `tabular` that is the basic structure
of the language.

For Syntax: see [pdf](Syntax.pdf).

  - Joining elements
      - appending columnwise
      - appending rowwise
  - Mutations
      - multirow
      - multicolumn
  - Aesthetics
      - font: colour, size, face
      - background colour
