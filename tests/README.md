Tests and Coverage
================
06 January, 2019 16:29:36

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                         | Coverage (%) |
| :--------------------------------------------- | :----------: |
| texblocks                                      |    37.88     |
| [R/join.R](../R/join.R)                        |     0.00     |
| [R/operators.R](../R/operators.R)              |     0.00     |
| [R/pad.R](../R/pad.R)                          |     0.00     |
| [R/reduce.R](../R/reduce.R)                    |     0.00     |
| [R/tabular.R](../R/tabular.R)                  |    10.00     |
| [R/cline.R](../R/cline.R)                      |    16.22     |
| [R/methods.R](../R/methods.R)                  |    16.67     |
| [R/multi\_transpose.R](../R/multi_transpose.R) |    22.22     |
| [R/hline.R](../R/hline.R)                      |    25.93     |
| [R/multi\_column.R](../R/multi_column.R)       |    33.87     |
| [R/multi\_row.R](../R/multi_row.R)             |    35.00     |
| [R/casting.R](../R/casting.R)                  |    83.54     |
| [R/attr.R](../R/attr.R)                        |    100.00    |
| [R/parse\_tb.R](../R/parse_tb.R)               |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                          |  n |  time | error | failed | skipped | warning |
| :-------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-basics.R](testthat/test-basics.R)       | 10 | 0.497 |     0 |      0 |       0 |       0 |
| [test-transpose.R](testthat/test-transpose.R) |  1 | 0.080 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                                | context   | test                    | status | n |  time |
| :-------------------------------------------------- | :-------- | :---------------------- | :----- | -: | ----: |
| [test-basics.R](testthat/test-basics.R#L6)          | basics    | as.tb: as.tb            | PASS   | 1 | 0.001 |
| [test-basics.R](testthat/test-basics.R#L10)         | basics    | as.tb: as.tb.tb         | PASS   | 1 | 0.002 |
| [test-basics.R](testthat/test-basics.R#L14)         | basics    | as.tb: as.integer.tb    | PASS   | 1 | 0.022 |
| [test-basics.R](testthat/test-basics.R#L18)         | basics    | as.tb: as.matrix.tb     | PASS   | 1 | 0.022 |
| [test-basics.R](testthat/test-basics.R#L22)         | basics    | as.tb: as.data.frame.tb | PASS   | 1 | 0.027 |
| [test-basics.R](testthat/test-basics.R#L32)         | basics    | as.tb: bdiag            | PASS   | 1 | 0.063 |
| [test-basics.R](testthat/test-basics.R#L37)         | basics    | as.tb: list             | PASS   | 2 | 0.100 |
| [test-basics.R](testthat/test-basics.R#L48)         | basics    | from tb: as.matrix      | PASS   | 1 | 0.195 |
| [test-basics.R](testthat/test-basics.R#L57)         | basics    | from tb: as.data.frame  | PASS   | 1 | 0.065 |
| [test-transpose.R](testthat/test-transpose.R#L6_L9) | transpose | vector: row to col      | PASS   | 1 | 0.080 |

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
