Tests and Coverage
================
14 July, 2020 08:53:36

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                         | Coverage (%) |
| :--------------------------------------------- | :----------: |
| texblocks                                      |    97.20     |
| [R/grids.R](../R/grids.R)                      |     0.00     |
| [R/methods.R](../R/methods.R)                  |    80.00     |
| [R/multi\_row.R](../R/multi_row.R)             |    96.72     |
| [R/multi\_column.R](../R/multi_column.R)       |    96.83     |
| [R/attr.R](../R/attr.R)                        |    100.00    |
| [R/casting.R](../R/casting.R)                  |    100.00    |
| [R/cline.R](../R/cline.R)                      |    100.00    |
| [R/hline.R](../R/hline.R)                      |    100.00    |
| [R/join.R](../R/join.R)                        |    100.00    |
| [R/multi\_transpose.R](../R/multi_transpose.R) |    100.00    |
| [R/operators.R](../R/operators.R)              |    100.00    |
| [R/pad.R](../R/pad.R)                          |    100.00    |
| [R/parse\_tb.R](../R/parse_tb.R)               |    100.00    |
| [R/reduce.R](../R/reduce.R)                    |    100.00    |
| [R/tabular.R](../R/tabular.R)                  |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                          |  n |  time | error | failed | skipped | warning | icon |
| :-------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: | :--- |
| [test-basics.R](testthat/test-basics.R)       | 16 | 1.091 |     0 |      0 |       0 |       0 |      |
| [test-lines.R](testthat/test-lines.R)         | 16 | 0.155 |     0 |      0 |       0 |       0 |      |
| [test-multi.R](testthat/test-multi.R)         |  9 | 0.051 |     0 |      0 |       0 |       1 | ⚠️   |
| [test-operators.R](testthat/test-operators.R) |  4 | 0.091 |     0 |      0 |       0 |       0 |      |
| [test-pad.R](testthat/test-pad.R)             | 20 | 0.058 |     0 |      0 |       0 |       0 |      |
| [test-reduce.R](testthat/test-reduce.R)       | 13 | 0.035 |     0 |      0 |       0 |       0 |      |
| [test-transpose.R](testthat/test-transpose.R) |  3 | 0.117 |     0 |      0 |       0 |       0 |      |

<details open>

<summary> Show Detailed Test Results </summary>

| file                                                | context   | test                          | status  | n |  time | icon |
| :-------------------------------------------------- | :-------- | :---------------------------- | :------ | -: | ----: | :--- |
| [test-basics.R](testthat/test-basics.R#L6)          | basics    | as.tb: as.tb                  | PASS    | 1 | 0.010 |      |
| [test-basics.R](testthat/test-basics.R#L10)         | basics    | as.tb: as.tb.tb               | PASS    | 1 | 0.001 |      |
| [test-basics.R](testthat/test-basics.R#L14)         | basics    | as.tb: as.integer.tb          | PASS    | 1 | 0.027 |      |
| [test-basics.R](testthat/test-basics.R#L18)         | basics    | as.tb: as.matrix.tb           | PASS    | 1 | 0.009 |      |
| [test-basics.R](testthat/test-basics.R#L22)         | basics    | as.tb: as.data.frame.tb       | PASS    | 1 | 0.012 |      |
| [test-basics.R](testthat/test-basics.R#L32)         | basics    | as.tb: bdiag                  | PASS    | 1 | 0.766 |      |
| [test-basics.R](testthat/test-basics.R#L37)         | basics    | as.tb: list                   | PASS    | 2 | 0.036 |      |
| [test-basics.R](testthat/test-basics.R#L48)         | basics    | from tb: as.matrix            | PASS    | 1 | 0.170 |      |
| [test-basics.R](testthat/test-basics.R#L57)         | basics    | from tb: as.data.frame        | PASS    | 1 | 0.017 |      |
| [test-basics.R](testthat/test-basics.R#L68)         | basics    | tabular: basic                | PASS    | 1 | 0.004 |      |
| [test-basics.R](testthat/test-basics.R#L72)         | basics    | tabular: align right          | PASS    | 1 | 0.005 |      |
| [test-basics.R](testthat/test-basics.R#L76)         | basics    | tabular: align center         | PASS    | 1 | 0.004 |      |
| [test-basics.R](testthat/test-basics.R#L80)         | basics    | tabular: align left           | PASS    | 1 | 0.004 |      |
| [test-basics.R](testthat/test-basics.R#L84)         | basics    | tabular: align 2 columns      | PASS    | 1 | 0.015 |      |
| [test-basics.R](testthat/test-basics.R#L88)         | basics    | tabular: wrong align length   | PASS    | 1 | 0.011 |      |
| [test-lines.R](testthat/test-lines.R#L10)           | lines     | hline: default                | PASS    | 1 | 0.012 |      |
| [test-lines.R](testthat/test-lines.R#L15)           | lines     | hline: top row singleton      | PASS    | 1 | 0.017 |      |
| [test-lines.R](testthat/test-lines.R#L20)           | lines     | hline: top row                | PASS    | 2 | 0.017 |      |
| [test-lines.R](testthat/test-lines.R#L26)           | lines     | hline: first row              | PASS    | 1 | 0.015 |      |
| [test-lines.R](testthat/test-lines.R#L31)           | lines     | hline: not 0 not 1            | PASS    | 1 | 0.014 |      |
| [test-lines.R](testthat/test-lines.R#L36)           | lines     | hline: multirow               | PASS    | 1 | 0.015 |      |
| [test-lines.R](testthat/test-lines.R#L42)           | lines     | hline: strip                  | PASS    | 1 | 0.015 |      |
| [test-lines.R](testthat/test-lines.R#L56)           | lines     | cline: top row list           | PASS    | 4 | 0.014 |      |
| [test-lines.R](testthat/test-lines.R#L68)           | lines     | cline: top row data.frame     | PASS    | 1 | 0.012 |      |
| [test-lines.R](testthat/test-lines.R#L73)           | lines     | cline: not top row data.frame | PASS    | 2 | 0.012 |      |
| [test-lines.R](testthat/test-lines.R#L80)           | lines     | cline: strip                  | PASS    | 1 | 0.012 |      |
| [test-multi.R](testthat/test-multi.R#L5)            | multi     | multirow: default             | PASS    | 1 | 0.001 |      |
| [test-multi.R](testthat/test-multi.R#L9)            | multi     | multirow: strip               | PASS    | 1 | 0.001 |      |
| [test-multi.R](testthat/test-multi.R#L13)           | multi     | multirow: find                | WARNING | 2 | 0.012 | ⚠️   |
| [test-multi.R](testthat/test-multi.R#L17)           | multi     | multirow: transpose           | PASS    | 1 | 0.015 |      |
| [test-multi.R](testthat/test-multi.R#L23)           | multi     | multicol: default             | PASS    | 1 | 0.000 |      |
| [test-multi.R](testthat/test-multi.R#L27)           | multi     | multicol: strip               | PASS    | 1 | 0.001 |      |
| [test-multi.R](testthat/test-multi.R#L31)           | multi     | multicol: find                | PASS    | 1 | 0.004 |      |
| [test-multi.R](testthat/test-multi.R#L35)           | multi     | multicol: transpose           | PASS    | 1 | 0.017 |      |
| [test-operators.R](testthat/test-operators.R#L6)    | operators | no pad: +                     | PASS    | 1 | 0.019 |      |
| [test-operators.R](testthat/test-operators.R#L11)   | operators | no pad: /                     | PASS    | 1 | 0.007 |      |
| [test-operators.R](testthat/test-operators.R#L18)   | operators | pad: +                        | PASS    | 1 | 0.031 |      |
| [test-operators.R](testthat/test-operators.R#L23)   | operators | pad: /                        | PASS    | 1 | 0.034 |      |
| [test-pad.R](testthat/test-pad.R#L9)                | pad       | columns: class                | PASS    | 1 | 0.001 |      |
| [test-pad.R](testthat/test-pad.R#L13)               | pad       | columns: bad side             | PASS    | 1 | 0.007 |      |
| [test-pad.R](testthat/test-pad.R#L17)               | pad       | columns: left 0               | PASS    | 1 | 0.001 |      |
| [test-pad.R](testthat/test-pad.R#L21)               | pad       | columns: left 1               | PASS    | 1 | 0.000 |      |
| [test-pad.R](testthat/test-pad.R#L25)               | pad       | columns: left 2               | PASS    | 1 | 0.000 |      |
| [test-pad.R](testthat/test-pad.R#L29)               | pad       | columns: right 0              | PASS    | 1 | 0.001 |      |
| [test-pad.R](testthat/test-pad.R#L33)               | pad       | columns: right 1              | PASS    | 1 | 0.001 |      |
| [test-pad.R](testthat/test-pad.R#L37)               | pad       | columns: right 2              | PASS    | 1 | 0.001 |      |
| [test-pad.R](testthat/test-pad.R#L46)               | pad       | rows: class                   | PASS    | 1 | 0.004 |      |
| [test-pad.R](testthat/test-pad.R#L50)               | pad       | rows: bad side                | PASS    | 1 | 0.006 |      |
| [test-pad.R](testthat/test-pad.R#L54)               | pad       | rows: bottom 0                | PASS    | 1 | 0.004 |      |
| [test-pad.R](testthat/test-pad.R#L58)               | pad       | rows: bottom 1                | PASS    | 1 | 0.003 |      |
| [test-pad.R](testthat/test-pad.R#L62)               | pad       | rows: bottom 2                | PASS    | 1 | 0.003 |      |
| [test-pad.R](testthat/test-pad.R#L66)               | pad       | rows: top 0                   | PASS    | 1 | 0.004 |      |
| [test-pad.R](testthat/test-pad.R#L70)               | pad       | rows: top 1                   | PASS    | 1 | 0.004 |      |
| [test-pad.R](testthat/test-pad.R#L74)               | pad       | rows: top 2                   | PASS    | 1 | 0.003 |      |
| [test-pad.R](testthat/test-pad.R#L83)               | pad       | wrapper: bad side             | PASS    | 1 | 0.007 |      |
| [test-pad.R](testthat/test-pad.R#L87)               | pad       | wrapper: bad length           | PASS    | 1 | 0.006 |      |
| [test-pad.R](testthat/test-pad.R#L91)               | pad       | wrapper: rows                 | PASS    | 1 | 0.001 |      |
| [test-pad.R](testthat/test-pad.R#L95)               | pad       | wrapper: cols                 | PASS    | 1 | 0.001 |      |
| [test-reduce.R](testthat/test-reduce.R#L2)          | reduce    | rowwise: class                | PASS    | 1 | 0.001 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | rowwise: dim                  | PASS    | 1 | 0.003 |      |
| [test-reduce.R](testthat/test-reduce.R#L2)          | reduce    | rowwise merge: class          | PASS    | 1 | 0.000 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | rowwise merge: dim            | PASS    | 1 | 0.005 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | rowwise merge: merged         | PASS    | 1 | 0.004 |      |
| [test-reduce.R](testthat/test-reduce.R#L2)          | reduce    | colwise: class                | PASS    | 1 | 0.000 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | colwise: dim                  | PASS    | 1 | 0.003 |      |
| [test-reduce.R](testthat/test-reduce.R#L2)          | reduce    | colwise merge: class          | PASS    | 1 | 0.000 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | colwise merge: dim            | PASS    | 1 | 0.006 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | colwise merge: merged         | PASS    | 1 | 0.004 |      |
| [test-reduce.R](testthat/test-reduce.R#L2)          | reduce    | mix: class                    | PASS    | 1 | 0.001 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | mix: dim                      | PASS    | 1 | 0.005 |      |
| [test-reduce.R](testthat/test-reduce.R#)            | reduce    | mix: merged                   | PASS    | 1 | 0.003 |      |
| [test-transpose.R](testthat/test-transpose.R#L6_L9) | transpose | vector: row to col            | PASS    | 1 | 0.025 |      |
| [test-transpose.R](testthat/test-transpose.R#L18)   | transpose | vector: multicol to multirow  | PASS    | 1 | 0.043 |      |
| [test-transpose.R](testthat/test-transpose.R#L28)   | transpose | vector: multirow to multicol  | PASS    | 1 | 0.049 |      |

| Failed | Warning | Skipped |
| :----- | :------ | :------ |
| 🛑      | ⚠️      | 🔶       |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                             |
| :------- | :-------------------------------- |
| Version  | R version 4.0.0 (2020-04-24)      |
| Platform | x86\_64-apple-darwin17.0 (64-bit) |
| Running  | macOS Catalina 10.15.5            |
| Language | en\_US                            |
| Timezone | America/New\_York                 |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.2   |
| covr     | 3.5.0   |
| covrpage | 0.0.71  |

</details>

<!--- Final Status : skipped/warning --->
