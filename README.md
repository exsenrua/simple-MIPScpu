# simple-MIPScpu
基于verilog实现简易版mips架构的cpu，单周期无流水线，
目前没有中断响应，虽然有在执行无符号操作时会有溢出信号，但是没有中断，所以目前没什么用
能实现大部分标准指令集

##有关alu的操作
alu的加法器采用32位并行超前进位
减法复用加法器

移位器采用桶型移位器，只支持右移，左移操作通过增加两个位翻转器实现，
单独的右移操作能实现  逻辑右移（mode=00） 算数右移（mode=01）  循环右移（mode=10）
但是封装进alu的移位器不支持 循环右移，

bep，bne指令复用减法操作，依靠zore信号判断转跳
lw，sw 复用加法操作


####能实现的指令集
## MIPS指令编码汇总表
### R型指令（Bit：31..26｜25..21｜20..16｜15..11｜10..6｜5..0）
| 助记符 | 31..26(op) | 25..21(rs) | 20..16(rt) | 15..11(rd) | 10..6(shamt) | 5..0(func) | 使用样例             |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| add | 000000 | rs | rt | rd | 0 | 100000 | `add $t1, $t2, $t3` |
| addu | 000000 | rs | rt | rd | 0 | 100001 | `addu $t1, $t2, $t3` |
| sub | 000000 | rs | rt | rd | 0 | 100010 | `sub $t1, $t2, $t3` |
| subu | 000000 | rs | rt | rd | 0 | 100011 | `subu $t1, $t2, $t3` |
| and | 000000 | rs | rt | rd | 0 | 100100 | `and $t1, $t2, $t3` |
| or | 000000 | rs | rt | rd | 0 | 100101 | `or $t1, $t2, $t3` |
| xor | 000000 | rs | rt | rd | 0 | 100110 | `xor $t1, $t2, $t3` |
| nor | 000000 | rs | rt | rd | 0 | 100111 | `nor $t1, $t2, $t3` |
| slt | 000000 | rs | rt | rd | 0 | 101010 | `slt $t1, $t2, $t3` |
| sltu | 000000 | rs | rt | rd | 0 | 101011 | `sltu $t1, $t2, $t3` |
| sll | 000000 | 00000 | rt | rd | shamt | 000000 | `sll $t1, $t2, 10` |
| srl | 000000 | 00000 | rt | rd | shamt | 000010 | `srl $t1, $t2, 10` |
| sra | 000000 | 00000 | rt | rd | shamt | 000011 | `sra $t1, $t2, 10` |
| sllv | 000000 | rs | rt | rd | 0 | 000100 | `sllv $t1, $t2, $t3` |
| srlv | 000000 | rs | rt | rd | 0 | 000110 | `srlv $t1, $t2, $t3` |
| srav | 000000 | rs | rt | rd | 0 | 000111 | `srav $t1, $t2, $t3` |
| jr | 000000 | rs | 0 | 0 | 0 | 001000 | `jr $t31` |

### I型指令（Bit：31..26｜25..21｜20..16｜15..0）
| 助记符 | 31..26(op) | 25..21(rs) | 20..16(rt) | 15..0(immediate) | 使用样例 |
| ---- | ---- | ---- | ---- | ---- | ---- |
| addi | 001000 | rs | rt | immediate(-~+) | `addi $t1, $t2, 100` |
| addiu | 001001 | rs | rt | immediate(-~+) | `addiu $t1, $t2, 100` |
| andi | 001100 | rs | rt | immediate(0~+) | `andi $t1, $t2, 10` |
| ori | 001101 | rs | rt | immediate(0~+) | `ori $t1, $t2, 10` |
| xori | 001110 | rs | rt | immediate(0~+) | `xori $t1, $t2, 10` |
| lw | 100011 | rs | rt | immediate(-~+) | `lw $t1, 10($t2)` |
| sw | 101011 | rs | rt | immediate(-~+) | `sw $t1, 10($t2)` |
| beq | 000100 | rs | rt | immediate(-~+) | `beq $t1, $t2, 10` |
| bne | 000101 | rs | rt | immediate(-~+) | `bne $t1, $t2, 10` |
| slti | 001010 | rs | rt | immediate(-~+) | `slti $t1, $t2, 10` |
| sltiu | 001011 | rs | rt | immediate(-~+) | `sltiu $t1, $t2, 10` |
| lui | 001111 | 00000 | rt | immediate(-~+) | `lui $t1, 10` |

### J型指令（Bit：31..26｜25..0）
| 助记符 | 31..26(op) | 25..0(index/address) | 使用样例 |
| ---- | ---- | ---- | ---- |
| j | 000010 | address | `j 10000` |



