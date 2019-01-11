
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/metrumresearchgroup/texblocks.svg?branch=master)](https://travis-ci.org/metrumresearchgroup/texblocks)
[![stability-experimental](https://img.shields.io/badge/stability-experimental-orange.svg)]()
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2019_01_10-brightgreen.svg)](http://tinyurl.com/yd46jbnl)

# texblocks

Lets be frank, it is not fun to create TeX tables from scratch.

![](tools/README/readme.gif)

In `R` there are a few ways to get around this task by converting a
data.frame into latex tables via
[huxtable](https://github.com/hughjonesd/huxtable),
[pixiedust](https://github.com/nutterb/pixiedust) and
[knitr](https://github.com/yihui/knitr).

But many times you either don’t have or don’t want to go through a
data.frame to get to your table. `{texblocks}` is an attempt to create a
natural language with simple operators to quickly create reproducible
TeX tables.

## Idea

Assemble LaTeX tabular environments using simple operations.

This would enable us to create any table layout with a consistent user
API.

## Proposed Syntax

For a rendered vingette see
[basics](https://metrumresearchgroup.github.io/texblocks/articles/basics.html)

Defining a new class of R element `tb` that is the basic structure of
the language.

### Joining elements

Let `t1` and `t2` be two objects of class tb.

|           |     |
| :-------: | :-: |
| `t1 + t2` | ⬛ ⬛ |

|           |   |
| :-------: | :-: |
|           | ⬛ |
| `t1 / t2` |   |
|           | ⬛ |

Using this language creating a table can be broken down to cell level

`t1 =(`⬛`+`⬛`+`⬛`) / (`⬛`+`⬛`+`⬛`)`

would be translated to

    1 & 2 & 3 \\
    4 & 5 & 6

making their combination a natural extension

`t1 + t1`

would translate to

    1 & 2 & 3 & 1 & 2 & 3 \\
    4 & 5 & 6 & 1 & 2 & 3

### Recasting

Converting to `tb`
    class

  - [numeric](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#single-blocks)
  - [character](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#single-blocks)
  - [matrix](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#matrix)
  - [sparse
    matrix](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#sparse-matrix)
  - [data.frame/tibble](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#data-frame)

texblocks can also be converted back into
[`tibbles`](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#as-data-frame)
and matrices for further data manipulation.

### Vectorizing

texblocks can also be
[replicated](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#replicate)
and used as a list with `purrr` verbs and base R
[`*apply`](https://metrumresearchgroup.github.io/texblocks/articles/basics.html#list)
functions.

### Mutations & Aesthetics

For a rendered vingette see
[aesthetics](https://metrumresearchgroup.github.io/texblocks/articles/aesthetics.html)

  - [multirow/multicolumn](https://metrumresearchgroup.github.io/texblocks/articles/aesthetics.html#multicolmultirow)
  - [hline](https://metrumresearchgroup.github.io/texblocks/articles/aesthetics.html#hline)
  - [cline](https://metrumresearchgroup.github.io/texblocks/articles/aesthetics.html#cline)

### TODO

A set of elements can be defined to control the table and cell level
attributes, eg

  - font: colour, size, face
  - background colour
