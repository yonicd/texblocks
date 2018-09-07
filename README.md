
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis.metrumrg.com/yoni/texblocks.svg?token=tfrDuc83e84K9CqJKyCs&branch=master)](https://travis.metrumrg.com/yoni/texblocks)

# texblocks

Building blocks for TeX tables

## Idea

Assemble LaTeX tabular environments using simple operations.

This would enable us to create any table layout with a consistent user
API.

Defining a new class of R element `tabular` that is the basic structure
of the language.

For Syntax: see
[pdf](https://ghe.metrumrg.com/yoni/texblocks/blob/master/Syntax.pdf).

  - Joining elements
      - appending columnwise
      - appending rowwise
  - Mutations
      - multirow
      - multicolumn
  - Aesthetics
      - font: colour, size, face
      - background colour
