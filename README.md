
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggtex

grammar of graphics for tex tables

## Idea

Modularize LaTeX tabular environments to grammar of graphics style
operations. This will create an abstract mechanism to manipulate and
combine tables.

This would enable us to create any table layout with a consistent user
API.

## Proposed Syntax

Defining a new class of R element `tabular` that is the basic structure
of the language.

### Joining elements

Let `t1` and `t2` be two objects of class
tabular.

|    syntax    |                                                                                                                                                                                                          output                                                                                                                                                                                                           |
| :----------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|  `t1 + t2`   |     <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg> <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>     |
|  `t1 \| t2`  |  <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg> `\|` <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>   |
| `t1 \|\| t2` | <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg> `\|\|` <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>  |
|  `t1 / t2`   |   <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg><br><svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>    |
|  `t1 - t2`   | <svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg><br>-<br><svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg> |

Using this language creating a table can be broken down to cell level

`t1
=(`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`)
/
(`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`)`

would be translated to

    1 & 2 & 3 \\
    4 & 5 & 6

`t2 =
(`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`)`
`-`
`(`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`+`<svg style="height:0.8em;top:.04em;position:relative;" viewBox="0 0 448 512"><path d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48z"/></svg>`)`

would be translated to

    7 & 8 & 9 \\ \hline
    10 & 11 & 12

making their combination a natural extension

`t1 + t2`

would translate to

    1 & 2 & 3 & 7 & 8 & 9 \\ cline{4-6}
    4 & 5 & 6 & 10 & 11 & 12

### Mutations

A set of mutation verbs can be defined to mainpulate within table
actions, eg

  - multirow
  - multicolumn

### Aesthetics

A set of aesthetic elements can be defined to control the table and cell
level attributes, eg

  - font: colour, size, face
  - background colour
