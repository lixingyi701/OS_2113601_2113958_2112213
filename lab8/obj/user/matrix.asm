
obj/__user_matrix.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	17a0006f          	j	80019e <sys_open>

0000000000800028 <close>:
  800028:	1820006f          	j	8001aa <sys_close>

000000000080002c <dup2>:
  80002c:	1880006f          	j	8001b4 <sys_dup>

0000000000800030 <_start>:
  800030:	202000ef          	jal	ra,800232 <umain>
  800034:	a001                	j	800034 <_start+0x4>

0000000000800036 <__panic>:
  800036:	715d                	addi	sp,sp,-80
  800038:	e822                	sd	s0,16(sp)
  80003a:	fc3e                	sd	a5,56(sp)
  80003c:	8432                	mv	s0,a2
  80003e:	103c                	addi	a5,sp,40
  800040:	862e                	mv	a2,a1
  800042:	85aa                	mv	a1,a0
  800044:	00001517          	auipc	a0,0x1
  800048:	8f450513          	addi	a0,a0,-1804 # 800938 <main+0xca>
  80004c:	ec06                	sd	ra,24(sp)
  80004e:	f436                	sd	a3,40(sp)
  800050:	f83a                	sd	a4,48(sp)
  800052:	e0c2                	sd	a6,64(sp)
  800054:	e4c6                	sd	a7,72(sp)
  800056:	e43e                	sd	a5,8(sp)
  800058:	0a0000ef          	jal	ra,8000f8 <cprintf>
  80005c:	65a2                	ld	a1,8(sp)
  80005e:	8522                	mv	a0,s0
  800060:	072000ef          	jal	ra,8000d2 <vcprintf>
  800064:	00001517          	auipc	a0,0x1
  800068:	94c50513          	addi	a0,a0,-1716 # 8009b0 <main+0x142>
  80006c:	08c000ef          	jal	ra,8000f8 <cprintf>
  800070:	5559                	li	a0,-10
  800072:	14e000ef          	jal	ra,8001c0 <exit>

0000000000800076 <__warn>:
  800076:	715d                	addi	sp,sp,-80
  800078:	e822                	sd	s0,16(sp)
  80007a:	fc3e                	sd	a5,56(sp)
  80007c:	8432                	mv	s0,a2
  80007e:	103c                	addi	a5,sp,40
  800080:	862e                	mv	a2,a1
  800082:	85aa                	mv	a1,a0
  800084:	00001517          	auipc	a0,0x1
  800088:	8d450513          	addi	a0,a0,-1836 # 800958 <main+0xea>
  80008c:	ec06                	sd	ra,24(sp)
  80008e:	f436                	sd	a3,40(sp)
  800090:	f83a                	sd	a4,48(sp)
  800092:	e0c2                	sd	a6,64(sp)
  800094:	e4c6                	sd	a7,72(sp)
  800096:	e43e                	sd	a5,8(sp)
  800098:	060000ef          	jal	ra,8000f8 <cprintf>
  80009c:	65a2                	ld	a1,8(sp)
  80009e:	8522                	mv	a0,s0
  8000a0:	032000ef          	jal	ra,8000d2 <vcprintf>
  8000a4:	00001517          	auipc	a0,0x1
  8000a8:	90c50513          	addi	a0,a0,-1780 # 8009b0 <main+0x142>
  8000ac:	04c000ef          	jal	ra,8000f8 <cprintf>
  8000b0:	60e2                	ld	ra,24(sp)
  8000b2:	6442                	ld	s0,16(sp)
  8000b4:	6161                	addi	sp,sp,80
  8000b6:	8082                	ret

00000000008000b8 <cputch>:
  8000b8:	1141                	addi	sp,sp,-16
  8000ba:	e022                	sd	s0,0(sp)
  8000bc:	e406                	sd	ra,8(sp)
  8000be:	842e                	mv	s0,a1
  8000c0:	0d6000ef          	jal	ra,800196 <sys_putc>
  8000c4:	401c                	lw	a5,0(s0)
  8000c6:	60a2                	ld	ra,8(sp)
  8000c8:	2785                	addiw	a5,a5,1
  8000ca:	c01c                	sw	a5,0(s0)
  8000cc:	6402                	ld	s0,0(sp)
  8000ce:	0141                	addi	sp,sp,16
  8000d0:	8082                	ret

00000000008000d2 <vcprintf>:
  8000d2:	1101                	addi	sp,sp,-32
  8000d4:	872e                	mv	a4,a1
  8000d6:	75dd                	lui	a1,0xffff7
  8000d8:	86aa                	mv	a3,a0
  8000da:	0070                	addi	a2,sp,12
  8000dc:	00000517          	auipc	a0,0x0
  8000e0:	fdc50513          	addi	a0,a0,-36 # 8000b8 <cputch>
  8000e4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <matc+0xffffffffff7f57b1>
  8000e8:	ec06                	sd	ra,24(sp)
  8000ea:	c602                	sw	zero,12(sp)
  8000ec:	234000ef          	jal	ra,800320 <vprintfmt>
  8000f0:	60e2                	ld	ra,24(sp)
  8000f2:	4532                	lw	a0,12(sp)
  8000f4:	6105                	addi	sp,sp,32
  8000f6:	8082                	ret

00000000008000f8 <cprintf>:
  8000f8:	711d                	addi	sp,sp,-96
  8000fa:	02810313          	addi	t1,sp,40
  8000fe:	f42e                	sd	a1,40(sp)
  800100:	75dd                	lui	a1,0xffff7
  800102:	f832                	sd	a2,48(sp)
  800104:	fc36                	sd	a3,56(sp)
  800106:	e0ba                	sd	a4,64(sp)
  800108:	86aa                	mv	a3,a0
  80010a:	0050                	addi	a2,sp,4
  80010c:	00000517          	auipc	a0,0x0
  800110:	fac50513          	addi	a0,a0,-84 # 8000b8 <cputch>
  800114:	871a                	mv	a4,t1
  800116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <matc+0xffffffffff7f57b1>
  80011a:	ec06                	sd	ra,24(sp)
  80011c:	e4be                	sd	a5,72(sp)
  80011e:	e8c2                	sd	a6,80(sp)
  800120:	ecc6                	sd	a7,88(sp)
  800122:	e41a                	sd	t1,8(sp)
  800124:	c202                	sw	zero,4(sp)
  800126:	1fa000ef          	jal	ra,800320 <vprintfmt>
  80012a:	60e2                	ld	ra,24(sp)
  80012c:	4512                	lw	a0,4(sp)
  80012e:	6125                	addi	sp,sp,96
  800130:	8082                	ret

0000000000800132 <syscall>:
  800132:	7175                	addi	sp,sp,-144
  800134:	f8ba                	sd	a4,112(sp)
  800136:	e0ba                	sd	a4,64(sp)
  800138:	0118                	addi	a4,sp,128
  80013a:	e42a                	sd	a0,8(sp)
  80013c:	ecae                	sd	a1,88(sp)
  80013e:	f0b2                	sd	a2,96(sp)
  800140:	f4b6                	sd	a3,104(sp)
  800142:	fcbe                	sd	a5,120(sp)
  800144:	e142                	sd	a6,128(sp)
  800146:	e546                	sd	a7,136(sp)
  800148:	f42e                	sd	a1,40(sp)
  80014a:	f832                	sd	a2,48(sp)
  80014c:	fc36                	sd	a3,56(sp)
  80014e:	f03a                	sd	a4,32(sp)
  800150:	e4be                	sd	a5,72(sp)
  800152:	4522                	lw	a0,8(sp)
  800154:	55a2                	lw	a1,40(sp)
  800156:	5642                	lw	a2,48(sp)
  800158:	56e2                	lw	a3,56(sp)
  80015a:	4706                	lw	a4,64(sp)
  80015c:	47a6                	lw	a5,72(sp)
  80015e:	00000073          	ecall
  800162:	ce2a                	sw	a0,28(sp)
  800164:	4572                	lw	a0,28(sp)
  800166:	6149                	addi	sp,sp,144
  800168:	8082                	ret

000000000080016a <sys_exit>:
  80016a:	85aa                	mv	a1,a0
  80016c:	4505                	li	a0,1
  80016e:	fc5ff06f          	j	800132 <syscall>

0000000000800172 <sys_fork>:
  800172:	4509                	li	a0,2
  800174:	fbfff06f          	j	800132 <syscall>

0000000000800178 <sys_wait>:
  800178:	862e                	mv	a2,a1
  80017a:	85aa                	mv	a1,a0
  80017c:	450d                	li	a0,3
  80017e:	fb5ff06f          	j	800132 <syscall>

0000000000800182 <sys_yield>:
  800182:	4529                	li	a0,10
  800184:	fafff06f          	j	800132 <syscall>

0000000000800188 <sys_kill>:
  800188:	85aa                	mv	a1,a0
  80018a:	4531                	li	a0,12
  80018c:	fa7ff06f          	j	800132 <syscall>

0000000000800190 <sys_getpid>:
  800190:	4549                	li	a0,18
  800192:	fa1ff06f          	j	800132 <syscall>

0000000000800196 <sys_putc>:
  800196:	85aa                	mv	a1,a0
  800198:	4579                	li	a0,30
  80019a:	f99ff06f          	j	800132 <syscall>

000000000080019e <sys_open>:
  80019e:	862e                	mv	a2,a1
  8001a0:	85aa                	mv	a1,a0
  8001a2:	06400513          	li	a0,100
  8001a6:	f8dff06f          	j	800132 <syscall>

00000000008001aa <sys_close>:
  8001aa:	85aa                	mv	a1,a0
  8001ac:	06500513          	li	a0,101
  8001b0:	f83ff06f          	j	800132 <syscall>

00000000008001b4 <sys_dup>:
  8001b4:	862e                	mv	a2,a1
  8001b6:	85aa                	mv	a1,a0
  8001b8:	08200513          	li	a0,130
  8001bc:	f77ff06f          	j	800132 <syscall>

00000000008001c0 <exit>:
  8001c0:	1141                	addi	sp,sp,-16
  8001c2:	e406                	sd	ra,8(sp)
  8001c4:	fa7ff0ef          	jal	ra,80016a <sys_exit>
  8001c8:	00000517          	auipc	a0,0x0
  8001cc:	7b050513          	addi	a0,a0,1968 # 800978 <main+0x10a>
  8001d0:	f29ff0ef          	jal	ra,8000f8 <cprintf>
  8001d4:	a001                	j	8001d4 <exit+0x14>

00000000008001d6 <fork>:
  8001d6:	f9dff06f          	j	800172 <sys_fork>

00000000008001da <wait>:
  8001da:	4581                	li	a1,0
  8001dc:	4501                	li	a0,0
  8001de:	f9bff06f          	j	800178 <sys_wait>

00000000008001e2 <yield>:
  8001e2:	fa1ff06f          	j	800182 <sys_yield>

00000000008001e6 <kill>:
  8001e6:	fa3ff06f          	j	800188 <sys_kill>

00000000008001ea <getpid>:
  8001ea:	fa7ff06f          	j	800190 <sys_getpid>

00000000008001ee <initfd>:
  8001ee:	1101                	addi	sp,sp,-32
  8001f0:	87ae                	mv	a5,a1
  8001f2:	e426                	sd	s1,8(sp)
  8001f4:	85b2                	mv	a1,a2
  8001f6:	84aa                	mv	s1,a0
  8001f8:	853e                	mv	a0,a5
  8001fa:	e822                	sd	s0,16(sp)
  8001fc:	ec06                	sd	ra,24(sp)
  8001fe:	e23ff0ef          	jal	ra,800020 <open>
  800202:	842a                	mv	s0,a0
  800204:	00054463          	bltz	a0,80020c <initfd+0x1e>
  800208:	00951863          	bne	a0,s1,800218 <initfd+0x2a>
  80020c:	8522                	mv	a0,s0
  80020e:	60e2                	ld	ra,24(sp)
  800210:	6442                	ld	s0,16(sp)
  800212:	64a2                	ld	s1,8(sp)
  800214:	6105                	addi	sp,sp,32
  800216:	8082                	ret
  800218:	8526                	mv	a0,s1
  80021a:	e0fff0ef          	jal	ra,800028 <close>
  80021e:	85a6                	mv	a1,s1
  800220:	8522                	mv	a0,s0
  800222:	e0bff0ef          	jal	ra,80002c <dup2>
  800226:	84aa                	mv	s1,a0
  800228:	8522                	mv	a0,s0
  80022a:	dffff0ef          	jal	ra,800028 <close>
  80022e:	8426                	mv	s0,s1
  800230:	bff1                	j	80020c <initfd+0x1e>

0000000000800232 <umain>:
  800232:	1101                	addi	sp,sp,-32
  800234:	e822                	sd	s0,16(sp)
  800236:	e426                	sd	s1,8(sp)
  800238:	842a                	mv	s0,a0
  80023a:	84ae                	mv	s1,a1
  80023c:	4601                	li	a2,0
  80023e:	00000597          	auipc	a1,0x0
  800242:	75258593          	addi	a1,a1,1874 # 800990 <main+0x122>
  800246:	4501                	li	a0,0
  800248:	ec06                	sd	ra,24(sp)
  80024a:	fa5ff0ef          	jal	ra,8001ee <initfd>
  80024e:	02054263          	bltz	a0,800272 <umain+0x40>
  800252:	4605                	li	a2,1
  800254:	00000597          	auipc	a1,0x0
  800258:	77c58593          	addi	a1,a1,1916 # 8009d0 <main+0x162>
  80025c:	4505                	li	a0,1
  80025e:	f91ff0ef          	jal	ra,8001ee <initfd>
  800262:	02054663          	bltz	a0,80028e <umain+0x5c>
  800266:	85a6                	mv	a1,s1
  800268:	8522                	mv	a0,s0
  80026a:	604000ef          	jal	ra,80086e <main>
  80026e:	f53ff0ef          	jal	ra,8001c0 <exit>
  800272:	86aa                	mv	a3,a0
  800274:	00000617          	auipc	a2,0x0
  800278:	72460613          	addi	a2,a2,1828 # 800998 <main+0x12a>
  80027c:	02000593          	li	a1,32
  800280:	00000517          	auipc	a0,0x0
  800284:	73850513          	addi	a0,a0,1848 # 8009b8 <main+0x14a>
  800288:	defff0ef          	jal	ra,800076 <__warn>
  80028c:	b7d9                	j	800252 <umain+0x20>
  80028e:	86aa                	mv	a3,a0
  800290:	00000617          	auipc	a2,0x0
  800294:	74860613          	addi	a2,a2,1864 # 8009d8 <main+0x16a>
  800298:	02500593          	li	a1,37
  80029c:	00000517          	auipc	a0,0x0
  8002a0:	71c50513          	addi	a0,a0,1820 # 8009b8 <main+0x14a>
  8002a4:	dd3ff0ef          	jal	ra,800076 <__warn>
  8002a8:	bf7d                	j	800266 <umain+0x34>

00000000008002aa <printnum>:
  8002aa:	02071893          	slli	a7,a4,0x20
  8002ae:	7139                	addi	sp,sp,-64
  8002b0:	0208d893          	srli	a7,a7,0x20
  8002b4:	e456                	sd	s5,8(sp)
  8002b6:	0316fab3          	remu	s5,a3,a7
  8002ba:	f822                	sd	s0,48(sp)
  8002bc:	f426                	sd	s1,40(sp)
  8002be:	f04a                	sd	s2,32(sp)
  8002c0:	ec4e                	sd	s3,24(sp)
  8002c2:	fc06                	sd	ra,56(sp)
  8002c4:	e852                	sd	s4,16(sp)
  8002c6:	84aa                	mv	s1,a0
  8002c8:	89ae                	mv	s3,a1
  8002ca:	8932                	mv	s2,a2
  8002cc:	fff7841b          	addiw	s0,a5,-1
  8002d0:	2a81                	sext.w	s5,s5
  8002d2:	0516f163          	bleu	a7,a3,800314 <printnum+0x6a>
  8002d6:	8a42                	mv	s4,a6
  8002d8:	00805863          	blez	s0,8002e8 <printnum+0x3e>
  8002dc:	347d                	addiw	s0,s0,-1
  8002de:	864e                	mv	a2,s3
  8002e0:	85ca                	mv	a1,s2
  8002e2:	8552                	mv	a0,s4
  8002e4:	9482                	jalr	s1
  8002e6:	f87d                	bnez	s0,8002dc <printnum+0x32>
  8002e8:	1a82                	slli	s5,s5,0x20
  8002ea:	020ada93          	srli	s5,s5,0x20
  8002ee:	00001797          	auipc	a5,0x1
  8002f2:	92a78793          	addi	a5,a5,-1750 # 800c18 <error_string+0xc8>
  8002f6:	9abe                	add	s5,s5,a5
  8002f8:	7442                	ld	s0,48(sp)
  8002fa:	000ac503          	lbu	a0,0(s5)
  8002fe:	70e2                	ld	ra,56(sp)
  800300:	6a42                	ld	s4,16(sp)
  800302:	6aa2                	ld	s5,8(sp)
  800304:	864e                	mv	a2,s3
  800306:	85ca                	mv	a1,s2
  800308:	69e2                	ld	s3,24(sp)
  80030a:	7902                	ld	s2,32(sp)
  80030c:	8326                	mv	t1,s1
  80030e:	74a2                	ld	s1,40(sp)
  800310:	6121                	addi	sp,sp,64
  800312:	8302                	jr	t1
  800314:	0316d6b3          	divu	a3,a3,a7
  800318:	87a2                	mv	a5,s0
  80031a:	f91ff0ef          	jal	ra,8002aa <printnum>
  80031e:	b7e9                	j	8002e8 <printnum+0x3e>

0000000000800320 <vprintfmt>:
  800320:	7119                	addi	sp,sp,-128
  800322:	f4a6                	sd	s1,104(sp)
  800324:	f0ca                	sd	s2,96(sp)
  800326:	ecce                	sd	s3,88(sp)
  800328:	e4d6                	sd	s5,72(sp)
  80032a:	e0da                	sd	s6,64(sp)
  80032c:	fc5e                	sd	s7,56(sp)
  80032e:	f862                	sd	s8,48(sp)
  800330:	ec6e                	sd	s11,24(sp)
  800332:	fc86                	sd	ra,120(sp)
  800334:	f8a2                	sd	s0,112(sp)
  800336:	e8d2                	sd	s4,80(sp)
  800338:	f466                	sd	s9,40(sp)
  80033a:	f06a                	sd	s10,32(sp)
  80033c:	89aa                	mv	s3,a0
  80033e:	892e                	mv	s2,a1
  800340:	84b2                	mv	s1,a2
  800342:	8db6                	mv	s11,a3
  800344:	8b3a                	mv	s6,a4
  800346:	5bfd                	li	s7,-1
  800348:	00000a97          	auipc	s5,0x0
  80034c:	6aca8a93          	addi	s5,s5,1708 # 8009f4 <main+0x186>
  800350:	05e00c13          	li	s8,94
  800354:	000dc503          	lbu	a0,0(s11)
  800358:	02500793          	li	a5,37
  80035c:	001d8413          	addi	s0,s11,1
  800360:	00f50f63          	beq	a0,a5,80037e <vprintfmt+0x5e>
  800364:	c529                	beqz	a0,8003ae <vprintfmt+0x8e>
  800366:	02500a13          	li	s4,37
  80036a:	a011                	j	80036e <vprintfmt+0x4e>
  80036c:	c129                	beqz	a0,8003ae <vprintfmt+0x8e>
  80036e:	864a                	mv	a2,s2
  800370:	85a6                	mv	a1,s1
  800372:	0405                	addi	s0,s0,1
  800374:	9982                	jalr	s3
  800376:	fff44503          	lbu	a0,-1(s0)
  80037a:	ff4519e3          	bne	a0,s4,80036c <vprintfmt+0x4c>
  80037e:	00044603          	lbu	a2,0(s0)
  800382:	02000813          	li	a6,32
  800386:	4a01                	li	s4,0
  800388:	4881                	li	a7,0
  80038a:	5d7d                	li	s10,-1
  80038c:	5cfd                	li	s9,-1
  80038e:	05500593          	li	a1,85
  800392:	4525                	li	a0,9
  800394:	fdd6071b          	addiw	a4,a2,-35
  800398:	0ff77713          	andi	a4,a4,255
  80039c:	00140d93          	addi	s11,s0,1
  8003a0:	22e5e363          	bltu	a1,a4,8005c6 <vprintfmt+0x2a6>
  8003a4:	070a                	slli	a4,a4,0x2
  8003a6:	9756                	add	a4,a4,s5
  8003a8:	4318                	lw	a4,0(a4)
  8003aa:	9756                	add	a4,a4,s5
  8003ac:	8702                	jr	a4
  8003ae:	70e6                	ld	ra,120(sp)
  8003b0:	7446                	ld	s0,112(sp)
  8003b2:	74a6                	ld	s1,104(sp)
  8003b4:	7906                	ld	s2,96(sp)
  8003b6:	69e6                	ld	s3,88(sp)
  8003b8:	6a46                	ld	s4,80(sp)
  8003ba:	6aa6                	ld	s5,72(sp)
  8003bc:	6b06                	ld	s6,64(sp)
  8003be:	7be2                	ld	s7,56(sp)
  8003c0:	7c42                	ld	s8,48(sp)
  8003c2:	7ca2                	ld	s9,40(sp)
  8003c4:	7d02                	ld	s10,32(sp)
  8003c6:	6de2                	ld	s11,24(sp)
  8003c8:	6109                	addi	sp,sp,128
  8003ca:	8082                	ret
  8003cc:	4705                	li	a4,1
  8003ce:	008b0613          	addi	a2,s6,8
  8003d2:	01174463          	blt	a4,a7,8003da <vprintfmt+0xba>
  8003d6:	28088563          	beqz	a7,800660 <vprintfmt+0x340>
  8003da:	000b3683          	ld	a3,0(s6)
  8003de:	4741                	li	a4,16
  8003e0:	8b32                	mv	s6,a2
  8003e2:	a86d                	j	80049c <vprintfmt+0x17c>
  8003e4:	00144603          	lbu	a2,1(s0)
  8003e8:	4a05                	li	s4,1
  8003ea:	846e                	mv	s0,s11
  8003ec:	b765                	j	800394 <vprintfmt+0x74>
  8003ee:	000b2503          	lw	a0,0(s6)
  8003f2:	864a                	mv	a2,s2
  8003f4:	85a6                	mv	a1,s1
  8003f6:	0b21                	addi	s6,s6,8
  8003f8:	9982                	jalr	s3
  8003fa:	bfa9                	j	800354 <vprintfmt+0x34>
  8003fc:	4705                	li	a4,1
  8003fe:	008b0a13          	addi	s4,s6,8
  800402:	01174463          	blt	a4,a7,80040a <vprintfmt+0xea>
  800406:	24088563          	beqz	a7,800650 <vprintfmt+0x330>
  80040a:	000b3403          	ld	s0,0(s6)
  80040e:	26044563          	bltz	s0,800678 <vprintfmt+0x358>
  800412:	86a2                	mv	a3,s0
  800414:	8b52                	mv	s6,s4
  800416:	4729                	li	a4,10
  800418:	a051                	j	80049c <vprintfmt+0x17c>
  80041a:	000b2783          	lw	a5,0(s6)
  80041e:	46e1                	li	a3,24
  800420:	0b21                	addi	s6,s6,8
  800422:	41f7d71b          	sraiw	a4,a5,0x1f
  800426:	8fb9                	xor	a5,a5,a4
  800428:	40e7873b          	subw	a4,a5,a4
  80042c:	1ce6c163          	blt	a3,a4,8005ee <vprintfmt+0x2ce>
  800430:	00371793          	slli	a5,a4,0x3
  800434:	00000697          	auipc	a3,0x0
  800438:	71c68693          	addi	a3,a3,1820 # 800b50 <error_string>
  80043c:	97b6                	add	a5,a5,a3
  80043e:	639c                	ld	a5,0(a5)
  800440:	1a078763          	beqz	a5,8005ee <vprintfmt+0x2ce>
  800444:	873e                	mv	a4,a5
  800446:	00001697          	auipc	a3,0x1
  80044a:	9da68693          	addi	a3,a3,-1574 # 800e20 <error_string+0x2d0>
  80044e:	8626                	mv	a2,s1
  800450:	85ca                	mv	a1,s2
  800452:	854e                	mv	a0,s3
  800454:	25a000ef          	jal	ra,8006ae <printfmt>
  800458:	bdf5                	j	800354 <vprintfmt+0x34>
  80045a:	00144603          	lbu	a2,1(s0)
  80045e:	2885                	addiw	a7,a7,1
  800460:	846e                	mv	s0,s11
  800462:	bf0d                	j	800394 <vprintfmt+0x74>
  800464:	4705                	li	a4,1
  800466:	008b0613          	addi	a2,s6,8
  80046a:	01174463          	blt	a4,a7,800472 <vprintfmt+0x152>
  80046e:	1e088e63          	beqz	a7,80066a <vprintfmt+0x34a>
  800472:	000b3683          	ld	a3,0(s6)
  800476:	4721                	li	a4,8
  800478:	8b32                	mv	s6,a2
  80047a:	a00d                	j	80049c <vprintfmt+0x17c>
  80047c:	03000513          	li	a0,48
  800480:	864a                	mv	a2,s2
  800482:	85a6                	mv	a1,s1
  800484:	e042                	sd	a6,0(sp)
  800486:	9982                	jalr	s3
  800488:	864a                	mv	a2,s2
  80048a:	85a6                	mv	a1,s1
  80048c:	07800513          	li	a0,120
  800490:	9982                	jalr	s3
  800492:	0b21                	addi	s6,s6,8
  800494:	ff8b3683          	ld	a3,-8(s6)
  800498:	6802                	ld	a6,0(sp)
  80049a:	4741                	li	a4,16
  80049c:	87e6                	mv	a5,s9
  80049e:	8626                	mv	a2,s1
  8004a0:	85ca                	mv	a1,s2
  8004a2:	854e                	mv	a0,s3
  8004a4:	e07ff0ef          	jal	ra,8002aa <printnum>
  8004a8:	b575                	j	800354 <vprintfmt+0x34>
  8004aa:	000b3703          	ld	a4,0(s6)
  8004ae:	0b21                	addi	s6,s6,8
  8004b0:	1e070063          	beqz	a4,800690 <vprintfmt+0x370>
  8004b4:	00170413          	addi	s0,a4,1
  8004b8:	19905563          	blez	s9,800642 <vprintfmt+0x322>
  8004bc:	02d00613          	li	a2,45
  8004c0:	14c81963          	bne	a6,a2,800612 <vprintfmt+0x2f2>
  8004c4:	00074703          	lbu	a4,0(a4)
  8004c8:	0007051b          	sext.w	a0,a4
  8004cc:	c90d                	beqz	a0,8004fe <vprintfmt+0x1de>
  8004ce:	000d4563          	bltz	s10,8004d8 <vprintfmt+0x1b8>
  8004d2:	3d7d                	addiw	s10,s10,-1
  8004d4:	037d0363          	beq	s10,s7,8004fa <vprintfmt+0x1da>
  8004d8:	864a                	mv	a2,s2
  8004da:	85a6                	mv	a1,s1
  8004dc:	180a0c63          	beqz	s4,800674 <vprintfmt+0x354>
  8004e0:	3701                	addiw	a4,a4,-32
  8004e2:	18ec7963          	bleu	a4,s8,800674 <vprintfmt+0x354>
  8004e6:	03f00513          	li	a0,63
  8004ea:	9982                	jalr	s3
  8004ec:	0405                	addi	s0,s0,1
  8004ee:	fff44703          	lbu	a4,-1(s0)
  8004f2:	3cfd                	addiw	s9,s9,-1
  8004f4:	0007051b          	sext.w	a0,a4
  8004f8:	f979                	bnez	a0,8004ce <vprintfmt+0x1ae>
  8004fa:	e5905de3          	blez	s9,800354 <vprintfmt+0x34>
  8004fe:	3cfd                	addiw	s9,s9,-1
  800500:	864a                	mv	a2,s2
  800502:	85a6                	mv	a1,s1
  800504:	02000513          	li	a0,32
  800508:	9982                	jalr	s3
  80050a:	e40c85e3          	beqz	s9,800354 <vprintfmt+0x34>
  80050e:	3cfd                	addiw	s9,s9,-1
  800510:	864a                	mv	a2,s2
  800512:	85a6                	mv	a1,s1
  800514:	02000513          	li	a0,32
  800518:	9982                	jalr	s3
  80051a:	fe0c92e3          	bnez	s9,8004fe <vprintfmt+0x1de>
  80051e:	bd1d                	j	800354 <vprintfmt+0x34>
  800520:	4705                	li	a4,1
  800522:	008b0613          	addi	a2,s6,8
  800526:	01174463          	blt	a4,a7,80052e <vprintfmt+0x20e>
  80052a:	12088663          	beqz	a7,800656 <vprintfmt+0x336>
  80052e:	000b3683          	ld	a3,0(s6)
  800532:	4729                	li	a4,10
  800534:	8b32                	mv	s6,a2
  800536:	b79d                	j	80049c <vprintfmt+0x17c>
  800538:	00144603          	lbu	a2,1(s0)
  80053c:	02d00813          	li	a6,45
  800540:	846e                	mv	s0,s11
  800542:	bd89                	j	800394 <vprintfmt+0x74>
  800544:	864a                	mv	a2,s2
  800546:	85a6                	mv	a1,s1
  800548:	02500513          	li	a0,37
  80054c:	9982                	jalr	s3
  80054e:	b519                	j	800354 <vprintfmt+0x34>
  800550:	000b2d03          	lw	s10,0(s6)
  800554:	00144603          	lbu	a2,1(s0)
  800558:	0b21                	addi	s6,s6,8
  80055a:	846e                	mv	s0,s11
  80055c:	e20cdce3          	bgez	s9,800394 <vprintfmt+0x74>
  800560:	8cea                	mv	s9,s10
  800562:	5d7d                	li	s10,-1
  800564:	bd05                	j	800394 <vprintfmt+0x74>
  800566:	00144603          	lbu	a2,1(s0)
  80056a:	03000813          	li	a6,48
  80056e:	846e                	mv	s0,s11
  800570:	b515                	j	800394 <vprintfmt+0x74>
  800572:	fd060d1b          	addiw	s10,a2,-48
  800576:	00144603          	lbu	a2,1(s0)
  80057a:	846e                	mv	s0,s11
  80057c:	fd06071b          	addiw	a4,a2,-48
  800580:	0006031b          	sext.w	t1,a2
  800584:	fce56ce3          	bltu	a0,a4,80055c <vprintfmt+0x23c>
  800588:	0405                	addi	s0,s0,1
  80058a:	002d171b          	slliw	a4,s10,0x2
  80058e:	00044603          	lbu	a2,0(s0)
  800592:	01a706bb          	addw	a3,a4,s10
  800596:	0016969b          	slliw	a3,a3,0x1
  80059a:	006686bb          	addw	a3,a3,t1
  80059e:	fd06071b          	addiw	a4,a2,-48
  8005a2:	fd068d1b          	addiw	s10,a3,-48
  8005a6:	0006031b          	sext.w	t1,a2
  8005aa:	fce57fe3          	bleu	a4,a0,800588 <vprintfmt+0x268>
  8005ae:	b77d                	j	80055c <vprintfmt+0x23c>
  8005b0:	fffcc713          	not	a4,s9
  8005b4:	977d                	srai	a4,a4,0x3f
  8005b6:	00ecf7b3          	and	a5,s9,a4
  8005ba:	00144603          	lbu	a2,1(s0)
  8005be:	00078c9b          	sext.w	s9,a5
  8005c2:	846e                	mv	s0,s11
  8005c4:	bbc1                	j	800394 <vprintfmt+0x74>
  8005c6:	864a                	mv	a2,s2
  8005c8:	85a6                	mv	a1,s1
  8005ca:	02500513          	li	a0,37
  8005ce:	9982                	jalr	s3
  8005d0:	fff44703          	lbu	a4,-1(s0)
  8005d4:	02500793          	li	a5,37
  8005d8:	8da2                	mv	s11,s0
  8005da:	d6f70de3          	beq	a4,a5,800354 <vprintfmt+0x34>
  8005de:	02500713          	li	a4,37
  8005e2:	1dfd                	addi	s11,s11,-1
  8005e4:	fffdc783          	lbu	a5,-1(s11)
  8005e8:	fee79de3          	bne	a5,a4,8005e2 <vprintfmt+0x2c2>
  8005ec:	b3a5                	j	800354 <vprintfmt+0x34>
  8005ee:	00001697          	auipc	a3,0x1
  8005f2:	82268693          	addi	a3,a3,-2014 # 800e10 <error_string+0x2c0>
  8005f6:	8626                	mv	a2,s1
  8005f8:	85ca                	mv	a1,s2
  8005fa:	854e                	mv	a0,s3
  8005fc:	0b2000ef          	jal	ra,8006ae <printfmt>
  800600:	bb91                	j	800354 <vprintfmt+0x34>
  800602:	00001717          	auipc	a4,0x1
  800606:	80670713          	addi	a4,a4,-2042 # 800e08 <error_string+0x2b8>
  80060a:	00000417          	auipc	s0,0x0
  80060e:	7ff40413          	addi	s0,s0,2047 # 800e09 <error_string+0x2b9>
  800612:	853a                	mv	a0,a4
  800614:	85ea                	mv	a1,s10
  800616:	e03a                	sd	a4,0(sp)
  800618:	e442                	sd	a6,8(sp)
  80061a:	0f6000ef          	jal	ra,800710 <strnlen>
  80061e:	40ac8cbb          	subw	s9,s9,a0
  800622:	6702                	ld	a4,0(sp)
  800624:	01905f63          	blez	s9,800642 <vprintfmt+0x322>
  800628:	6822                	ld	a6,8(sp)
  80062a:	0008079b          	sext.w	a5,a6
  80062e:	e43e                	sd	a5,8(sp)
  800630:	6522                	ld	a0,8(sp)
  800632:	864a                	mv	a2,s2
  800634:	85a6                	mv	a1,s1
  800636:	e03a                	sd	a4,0(sp)
  800638:	3cfd                	addiw	s9,s9,-1
  80063a:	9982                	jalr	s3
  80063c:	6702                	ld	a4,0(sp)
  80063e:	fe0c99e3          	bnez	s9,800630 <vprintfmt+0x310>
  800642:	00074703          	lbu	a4,0(a4)
  800646:	0007051b          	sext.w	a0,a4
  80064a:	e80512e3          	bnez	a0,8004ce <vprintfmt+0x1ae>
  80064e:	b319                	j	800354 <vprintfmt+0x34>
  800650:	000b2403          	lw	s0,0(s6)
  800654:	bb6d                	j	80040e <vprintfmt+0xee>
  800656:	000b6683          	lwu	a3,0(s6)
  80065a:	4729                	li	a4,10
  80065c:	8b32                	mv	s6,a2
  80065e:	bd3d                	j	80049c <vprintfmt+0x17c>
  800660:	000b6683          	lwu	a3,0(s6)
  800664:	4741                	li	a4,16
  800666:	8b32                	mv	s6,a2
  800668:	bd15                	j	80049c <vprintfmt+0x17c>
  80066a:	000b6683          	lwu	a3,0(s6)
  80066e:	4721                	li	a4,8
  800670:	8b32                	mv	s6,a2
  800672:	b52d                	j	80049c <vprintfmt+0x17c>
  800674:	9982                	jalr	s3
  800676:	bd9d                	j	8004ec <vprintfmt+0x1cc>
  800678:	864a                	mv	a2,s2
  80067a:	85a6                	mv	a1,s1
  80067c:	02d00513          	li	a0,45
  800680:	e042                	sd	a6,0(sp)
  800682:	9982                	jalr	s3
  800684:	8b52                	mv	s6,s4
  800686:	408006b3          	neg	a3,s0
  80068a:	4729                	li	a4,10
  80068c:	6802                	ld	a6,0(sp)
  80068e:	b539                	j	80049c <vprintfmt+0x17c>
  800690:	01905663          	blez	s9,80069c <vprintfmt+0x37c>
  800694:	02d00713          	li	a4,45
  800698:	f6e815e3          	bne	a6,a4,800602 <vprintfmt+0x2e2>
  80069c:	00000417          	auipc	s0,0x0
  8006a0:	76d40413          	addi	s0,s0,1901 # 800e09 <error_string+0x2b9>
  8006a4:	02800513          	li	a0,40
  8006a8:	02800713          	li	a4,40
  8006ac:	b50d                	j	8004ce <vprintfmt+0x1ae>

00000000008006ae <printfmt>:
  8006ae:	7139                	addi	sp,sp,-64
  8006b0:	02010313          	addi	t1,sp,32
  8006b4:	f03a                	sd	a4,32(sp)
  8006b6:	871a                	mv	a4,t1
  8006b8:	ec06                	sd	ra,24(sp)
  8006ba:	f43e                	sd	a5,40(sp)
  8006bc:	f842                	sd	a6,48(sp)
  8006be:	fc46                	sd	a7,56(sp)
  8006c0:	e41a                	sd	t1,8(sp)
  8006c2:	c5fff0ef          	jal	ra,800320 <vprintfmt>
  8006c6:	60e2                	ld	ra,24(sp)
  8006c8:	6121                	addi	sp,sp,64
  8006ca:	8082                	ret

00000000008006cc <rand>:
  8006cc:	00001697          	auipc	a3,0x1
  8006d0:	93468693          	addi	a3,a3,-1740 # 801000 <next>
  8006d4:	00000717          	auipc	a4,0x0
  8006d8:	75470713          	addi	a4,a4,1876 # 800e28 <error_string+0x2d8>
  8006dc:	629c                	ld	a5,0(a3)
  8006de:	6318                	ld	a4,0(a4)
  8006e0:	02e787b3          	mul	a5,a5,a4
  8006e4:	577d                	li	a4,-1
  8006e6:	8341                	srli	a4,a4,0x10
  8006e8:	07ad                	addi	a5,a5,11
  8006ea:	8ff9                	and	a5,a5,a4
  8006ec:	80000737          	lui	a4,0x80000
  8006f0:	00c7d513          	srli	a0,a5,0xc
  8006f4:	fff74713          	not	a4,a4
  8006f8:	02e57533          	remu	a0,a0,a4
  8006fc:	e29c                	sd	a5,0(a3)
  8006fe:	2505                	addiw	a0,a0,1
  800700:	8082                	ret

0000000000800702 <srand>:
  800702:	1502                	slli	a0,a0,0x20
  800704:	9101                	srli	a0,a0,0x20
  800706:	00001797          	auipc	a5,0x1
  80070a:	8ea7bd23          	sd	a0,-1798(a5) # 801000 <next>
  80070e:	8082                	ret

0000000000800710 <strnlen>:
  800710:	c185                	beqz	a1,800730 <strnlen+0x20>
  800712:	00054783          	lbu	a5,0(a0)
  800716:	cf89                	beqz	a5,800730 <strnlen+0x20>
  800718:	4781                	li	a5,0
  80071a:	a021                	j	800722 <strnlen+0x12>
  80071c:	00074703          	lbu	a4,0(a4) # ffffffff80000000 <matc+0xffffffff7f7fecd8>
  800720:	c711                	beqz	a4,80072c <strnlen+0x1c>
  800722:	0785                	addi	a5,a5,1
  800724:	00f50733          	add	a4,a0,a5
  800728:	fef59ae3          	bne	a1,a5,80071c <strnlen+0xc>
  80072c:	853e                	mv	a0,a5
  80072e:	8082                	ret
  800730:	4781                	li	a5,0
  800732:	853e                	mv	a0,a5
  800734:	8082                	ret

0000000000800736 <memset>:
  800736:	ca01                	beqz	a2,800746 <memset+0x10>
  800738:	962a                	add	a2,a2,a0
  80073a:	87aa                	mv	a5,a0
  80073c:	0785                	addi	a5,a5,1
  80073e:	feb78fa3          	sb	a1,-1(a5)
  800742:	fec79de3          	bne	a5,a2,80073c <memset+0x6>
  800746:	8082                	ret

0000000000800748 <work>:
  800748:	7179                	addi	sp,sp,-48
  80074a:	e84a                	sd	s2,16(sp)
  80074c:	00001597          	auipc	a1,0x1
  800750:	89458593          	addi	a1,a1,-1900 # 800fe0 <error_string+0x490>
  800754:	00001917          	auipc	s2,0x1
  800758:	a4490913          	addi	s2,s2,-1468 # 801198 <matb>
  80075c:	f022                	sd	s0,32(sp)
  80075e:	ec26                	sd	s1,24(sp)
  800760:	e44e                	sd	s3,8(sp)
  800762:	f406                	sd	ra,40(sp)
  800764:	84aa                	mv	s1,a0
  800766:	00001617          	auipc	a2,0x1
  80076a:	a5a60613          	addi	a2,a2,-1446 # 8011c0 <matb+0x28>
  80076e:	00001417          	auipc	s0,0x1
  800772:	be240413          	addi	s0,s0,-1054 # 801350 <matc+0x28>
  800776:	00001997          	auipc	s3,0x1
  80077a:	89298993          	addi	s3,s3,-1902 # 801008 <mata>
  80077e:	412585b3          	sub	a1,a1,s2
  800782:	4685                	li	a3,1
  800784:	fd860793          	addi	a5,a2,-40
  800788:	00c58733          	add	a4,a1,a2
  80078c:	c394                	sw	a3,0(a5)
  80078e:	c314                	sw	a3,0(a4)
  800790:	0791                	addi	a5,a5,4
  800792:	0711                	addi	a4,a4,4
  800794:	fec79ce3          	bne	a5,a2,80078c <work+0x44>
  800798:	02878613          	addi	a2,a5,40
  80079c:	fe8614e3          	bne	a2,s0,800784 <work+0x3c>
  8007a0:	a43ff0ef          	jal	ra,8001e2 <yield>
  8007a4:	a47ff0ef          	jal	ra,8001ea <getpid>
  8007a8:	8626                	mv	a2,s1
  8007aa:	85aa                	mv	a1,a0
  8007ac:	00000517          	auipc	a0,0x0
  8007b0:	6d450513          	addi	a0,a0,1748 # 800e80 <error_string+0x330>
  8007b4:	945ff0ef          	jal	ra,8000f8 <cprintf>
  8007b8:	53fd                	li	t2,-1
  8007ba:	34fd                	addiw	s1,s1,-1
  8007bc:	00001297          	auipc	t0,0x1
  8007c0:	9dc28293          	addi	t0,t0,-1572 # 801198 <matb>
  8007c4:	00001f97          	auipc	t6,0x1
  8007c8:	b64f8f93          	addi	t6,t6,-1180 # 801328 <matc>
  8007cc:	00001f17          	auipc	t5,0x1
  8007d0:	cecf0f13          	addi	t5,t5,-788 # 8014b8 <matc+0x190>
  8007d4:	02800e13          	li	t3,40
  8007d8:	06748f63          	beq	s1,t2,800856 <work+0x10e>
  8007dc:	00001897          	auipc	a7,0x1
  8007e0:	b4c88893          	addi	a7,a7,-1204 # 801328 <matc>
  8007e4:	8ec6                	mv	t4,a7
  8007e6:	834e                	mv	t1,s3
  8007e8:	857e                	mv	a0,t6
  8007ea:	8876                	mv	a6,t4
  8007ec:	e7050793          	addi	a5,a0,-400
  8007f0:	869a                	mv	a3,t1
  8007f2:	4601                	li	a2,0
  8007f4:	4298                	lw	a4,0(a3)
  8007f6:	438c                	lw	a1,0(a5)
  8007f8:	02878793          	addi	a5,a5,40
  8007fc:	0691                	addi	a3,a3,4
  8007fe:	02b7073b          	mulw	a4,a4,a1
  800802:	9e39                	addw	a2,a2,a4
  800804:	fea798e3          	bne	a5,a0,8007f4 <work+0xac>
  800808:	00c82023          	sw	a2,0(a6)
  80080c:	00478513          	addi	a0,a5,4
  800810:	0811                	addi	a6,a6,4
  800812:	fc851de3          	bne	a0,s0,8007ec <work+0xa4>
  800816:	02830313          	addi	t1,t1,40
  80081a:	028e8e93          	addi	t4,t4,40
  80081e:	fc5315e3          	bne	t1,t0,8007e8 <work+0xa0>
  800822:	854e                	mv	a0,s3
  800824:	85ca                	mv	a1,s2
  800826:	4781                	li	a5,0
  800828:	00f88733          	add	a4,a7,a5
  80082c:	4318                	lw	a4,0(a4)
  80082e:	00f58633          	add	a2,a1,a5
  800832:	00f506b3          	add	a3,a0,a5
  800836:	c218                	sw	a4,0(a2)
  800838:	c298                	sw	a4,0(a3)
  80083a:	0791                	addi	a5,a5,4
  80083c:	ffc796e3          	bne	a5,t3,800828 <work+0xe0>
  800840:	02888893          	addi	a7,a7,40
  800844:	02858593          	addi	a1,a1,40
  800848:	02850513          	addi	a0,a0,40
  80084c:	fde89de3          	bne	a7,t5,800826 <work+0xde>
  800850:	34fd                	addiw	s1,s1,-1
  800852:	f87495e3          	bne	s1,t2,8007dc <work+0x94>
  800856:	995ff0ef          	jal	ra,8001ea <getpid>
  80085a:	85aa                	mv	a1,a0
  80085c:	00000517          	auipc	a0,0x0
  800860:	64450513          	addi	a0,a0,1604 # 800ea0 <error_string+0x350>
  800864:	895ff0ef          	jal	ra,8000f8 <cprintf>
  800868:	4501                	li	a0,0
  80086a:	957ff0ef          	jal	ra,8001c0 <exit>

000000000080086e <main>:
  80086e:	7175                	addi	sp,sp,-144
  800870:	f4ce                	sd	s3,104(sp)
  800872:	05400613          	li	a2,84
  800876:	4581                	li	a1,0
  800878:	0028                	addi	a0,sp,8
  80087a:	00810993          	addi	s3,sp,8
  80087e:	e122                	sd	s0,128(sp)
  800880:	fca6                	sd	s1,120(sp)
  800882:	f8ca                	sd	s2,112(sp)
  800884:	e506                	sd	ra,136(sp)
  800886:	84ce                	mv	s1,s3
  800888:	eafff0ef          	jal	ra,800736 <memset>
  80088c:	4401                	li	s0,0
  80088e:	4955                	li	s2,21
  800890:	947ff0ef          	jal	ra,8001d6 <fork>
  800894:	c088                	sw	a0,0(s1)
  800896:	cd2d                	beqz	a0,800910 <main+0xa2>
  800898:	04054663          	bltz	a0,8008e4 <main+0x76>
  80089c:	2405                	addiw	s0,s0,1
  80089e:	0491                	addi	s1,s1,4
  8008a0:	ff2418e3          	bne	s0,s2,800890 <main+0x22>
  8008a4:	00000517          	auipc	a0,0x0
  8008a8:	58c50513          	addi	a0,a0,1420 # 800e30 <error_string+0x2e0>
  8008ac:	84dff0ef          	jal	ra,8000f8 <cprintf>
  8008b0:	4455                	li	s0,21
  8008b2:	929ff0ef          	jal	ra,8001da <wait>
  8008b6:	e10d                	bnez	a0,8008d8 <main+0x6a>
  8008b8:	347d                	addiw	s0,s0,-1
  8008ba:	fc65                	bnez	s0,8008b2 <main+0x44>
  8008bc:	00000517          	auipc	a0,0x0
  8008c0:	59450513          	addi	a0,a0,1428 # 800e50 <error_string+0x300>
  8008c4:	835ff0ef          	jal	ra,8000f8 <cprintf>
  8008c8:	60aa                	ld	ra,136(sp)
  8008ca:	640a                	ld	s0,128(sp)
  8008cc:	74e6                	ld	s1,120(sp)
  8008ce:	7946                	ld	s2,112(sp)
  8008d0:	79a6                	ld	s3,104(sp)
  8008d2:	4501                	li	a0,0
  8008d4:	6149                	addi	sp,sp,144
  8008d6:	8082                	ret
  8008d8:	00000517          	auipc	a0,0x0
  8008dc:	56850513          	addi	a0,a0,1384 # 800e40 <error_string+0x2f0>
  8008e0:	819ff0ef          	jal	ra,8000f8 <cprintf>
  8008e4:	08e0                	addi	s0,sp,92
  8008e6:	0009a503          	lw	a0,0(s3)
  8008ea:	00a05463          	blez	a0,8008f2 <main+0x84>
  8008ee:	8f9ff0ef          	jal	ra,8001e6 <kill>
  8008f2:	0991                	addi	s3,s3,4
  8008f4:	ff3419e3          	bne	s0,s3,8008e6 <main+0x78>
  8008f8:	00000617          	auipc	a2,0x0
  8008fc:	56860613          	addi	a2,a2,1384 # 800e60 <error_string+0x310>
  800900:	05200593          	li	a1,82
  800904:	00000517          	auipc	a0,0x0
  800908:	56c50513          	addi	a0,a0,1388 # 800e70 <error_string+0x320>
  80090c:	f2aff0ef          	jal	ra,800036 <__panic>
  800910:	0284053b          	mulw	a0,s0,s0
  800914:	defff0ef          	jal	ra,800702 <srand>
  800918:	db5ff0ef          	jal	ra,8006cc <rand>
  80091c:	47d5                	li	a5,21
  80091e:	02f5753b          	remuw	a0,a0,a5
  800922:	02a5053b          	mulw	a0,a0,a0
  800926:	00a5079b          	addiw	a5,a0,10
  80092a:	06400513          	li	a0,100
  80092e:	02f50533          	mul	a0,a0,a5
  800932:	e17ff0ef          	jal	ra,800748 <work>
