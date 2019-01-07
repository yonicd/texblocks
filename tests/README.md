Tests and Coverage
================
06 January, 2019 22:44:18

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                         | Coverage (%) |
| :--------------------------------------------- | :----------: |
| texblocks                                      |    79.45     |
| [R/reduce.R](../R/reduce.R)                    |     0.00     |
| [R/tabular.R](../R/tabular.R)                  |    10.00     |
| [R/methods.R](../R/methods.R)                  |    20.00     |
| [R/pad.R](../R/pad.R)                          |    34.21     |
| [R/multi\_row.R](../R/multi_row.R)             |    95.00     |
| [R/multi\_column.R](../R/multi_column.R)       |    95.16     |
| [R/casting.R](../R/casting.R)                  |    98.73     |
| [R/attr.R](../R/attr.R)                        |    100.00    |
| [R/cline.R](../R/cline.R)                      |    100.00    |
| [R/hline.R](../R/hline.R)                      |    100.00    |
| [R/join.R](../R/join.R)                        |    100.00    |
| [R/multi\_transpose.R](../R/multi_transpose.R) |    100.00    |
| [R/operators.R](../R/operators.R)              |    100.00    |
| [R/parse\_tb.R](../R/parse_tb.R)               |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                          |  n |  time | error | failed | skipped | warning |
| :-------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-basics.R](testthat/test-basics.R)       | 10 | 0.357 |     0 |      0 |       0 |       0 |
| [test-lines.R](testthat/test-lines.R)         | 16 | 0.532 |     0 |      0 |       0 |       0 |
| [test-multi.R](testthat/test-multi.R)         |  8 | 0.060 |     0 |      0 |       0 |       0 |
| [test-operators.R](testthat/test-operators.R) |  4 | 0.089 |     0 |      0 |       0 |       0 |
| [test-transpose.R](testthat/test-transpose.R) |  1 | 0.080 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                                | context   | test                          | status | n |  time |
| :-------------------------------------------------- | :-------- | :---------------------------- | :----- | -: | ----: |
| [test-basics.R](testthat/test-basics.R#L6)          | basics    | as.tb: as.tb                  | PASS   | 1 | 0.001 |
| [test-basics.R](testthat/test-basics.R#L10)         | basics    | as.tb: as.tb.tb               | PASS   | 1 | 0.001 |
| [test-basics.R](testthat/test-basics.R#L14)         | basics    | as.tb: as.integer.tb          | PASS   | 1 | 0.022 |
| [test-basics.R](testthat/test-basics.R#L18)         | basics    | as.tb: as.matrix.tb           | PASS   | 1 | 0.018 |
| [test-basics.R](testthat/test-basics.R#L22)         | basics    | as.tb: as.data.frame.tb       | PASS   | 1 | 0.051 |
| [test-basics.R](testthat/test-basics.R#L32)         | basics    | as.tb: bdiag                  | PASS   | 1 | 0.030 |
| [test-basics.R](testthat/test-basics.R#L37)         | basics    | as.tb: list                   | PASS   | 2 | 0.071 |
| [test-basics.R](testthat/test-basics.R#L48)         | basics    | from tb: as.matrix            | PASS   | 1 | 0.091 |
| [test-basics.R](testthat/test-basics.R#L57)         | basics    | from tb: as.data.frame        | PASS   | 1 | 0.072 |
| [test-lines.R](testthat/test-lines.R#L9)            | lines     | hline: default                | PASS   | 1 | 0.054 |
| [test-lines.R](testthat/test-lines.R#L14)           | lines     | hline: top row                | PASS   | 2 | 0.062 |
| [test-lines.R](testthat/test-lines.R#L21)           | lines     | hline: first row              | PASS   | 2 | 0.016 |
| [test-lines.R](testthat/test-lines.R#L27)           | lines     | hline: not 0 not 1            | PASS   | 1 | 0.050 |
| [test-lines.R](testthat/test-lines.R#L32)           | lines     | hline: multirow               | PASS   | 1 | 0.067 |
| [test-lines.R](testthat/test-lines.R#L38)           | lines     | hline: strip                  | PASS   | 1 | 0.023 |
| [test-lines.R](testthat/test-lines.R#L51)           | lines     | cline: top row list           | PASS   | 4 | 0.040 |
| [test-lines.R](testthat/test-lines.R#L63)           | lines     | cline: top row data.frame     | PASS   | 1 | 0.068 |
| [test-lines.R](testthat/test-lines.R#L68)           | lines     | cline: not top row data.frame | PASS   | 2 | 0.070 |
| [test-lines.R](testthat/test-lines.R#L75)           | lines     | cline: strip                  | PASS   | 1 | 0.082 |
| [test-multi.R](testthat/test-multi.R#L5)            | multi     | multirow: default             | PASS   | 1 | 0.002 |
| [test-multi.R](testthat/test-multi.R#L9)            | multi     | multirow: strip               | PASS   | 1 | 0.003 |
| [test-multi.R](testthat/test-multi.R#L13)           | multi     | multirow: find                | PASS   | 1 | 0.003 |
| [test-multi.R](testthat/test-multi.R#L17)           | multi     | multirow: transpose           | PASS   | 1 | 0.025 |
| [test-multi.R](testthat/test-multi.R#L23)           | multi     | multicol: default             | PASS   | 1 | 0.001 |
| [test-multi.R](testthat/test-multi.R#L27)           | multi     | multicol: strip               | PASS   | 1 | 0.003 |
| [test-multi.R](testthat/test-multi.R#L31)           | multi     | multicol: find                | PASS   | 1 | 0.004 |
| [test-multi.R](testthat/test-multi.R#L35)           | multi     | multicol: transpose           | PASS   | 1 | 0.019 |
| [test-operators.R](testthat/test-operators.R#L6)    | operators | no pad: +                     | PASS   | 1 | 0.022 |
| [test-operators.R](testthat/test-operators.R#L11)   | operators | no pad: /                     | PASS   | 1 | 0.008 |
| [test-operators.R](testthat/test-operators.R#L18)   | operators | pad: +                        | PASS   | 1 | 0.029 |
| [test-operators.R](testthat/test-operators.R#L23)   | operators | pad: /                        | PASS   | 1 | 0.030 |
| [test-transpose.R](testthat/test-transpose.R#L6_L9) | transpose | vector: row to col            | PASS   | 1 | 0.080 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.5.1 (2018-07-02)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS 10.14.2                       |
| Language | en\_US                              |
| Timezone | America/New\_York                   |

| Package  | Version    |
| :------- | :--------- |
| testthat | 2.0.0.9000 |
| covr     | 3.2.0      |
| covrpage | 0.0.69     |

</details>

<!--- Final Status : pass --->
