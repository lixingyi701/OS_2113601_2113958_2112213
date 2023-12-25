
obj/__user_exit.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	16c0006f          	j	800190 <sys_open>

0000000000800028 <close>:
  800028:	1740006f          	j	80019c <sys_close>

000000000080002c <dup2>:
  80002c:	17a0006f          	j	8001a6 <sys_dup>

0000000000800030 <_start>:
  800030:	1f0000ef          	jal	ra,800220 <umain>
  800034:	a001                	j	800034 <_start+0x4>

0000000000800036 <__panic>:
  800036:	715d                	addi	sp,sp,-80
  800038:	e822                	sd	s0,16(sp)
  80003a:	fc3e                	sd	a5,56(sp)
  80003c:	8432                	mv	s0,a2
  80003e:	103c                	addi	a5,sp,40
  800040:	862e                	mv	a2,a1
  800042:	85aa                	mv	a1,a0
  800044:	00000517          	auipc	a0,0x0
  800048:	7b450513          	addi	a0,a0,1972 # 8007f8 <main+0x118>
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
  800068:	80c50513          	addi	a0,a0,-2036 # 800870 <main+0x190>
  80006c:	08c000ef          	jal	ra,8000f8 <cprintf>
  800070:	5559                	li	a0,-10
  800072:	140000ef          	jal	ra,8001b2 <exit>

0000000000800076 <__warn>:
  800076:	715d                	addi	sp,sp,-80
  800078:	e822                	sd	s0,16(sp)
  80007a:	fc3e                	sd	a5,56(sp)
  80007c:	8432                	mv	s0,a2
  80007e:	103c                	addi	a5,sp,40
  800080:	862e                	mv	a2,a1
  800082:	85aa                	mv	a1,a0
  800084:	00000517          	auipc	a0,0x0
  800088:	79450513          	addi	a0,a0,1940 # 800818 <main+0x138>
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
  8000a4:	00000517          	auipc	a0,0x0
  8000a8:	7cc50513          	addi	a0,a0,1996 # 800870 <main+0x190>
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
  8000c0:	0c8000ef          	jal	ra,800188 <sys_putc>
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
  8000e4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <magic+0xffffffffff7f5ad9>
  8000e8:	ec06                	sd	ra,24(sp)
  8000ea:	c602                	sw	zero,12(sp)
  8000ec:	222000ef          	jal	ra,80030e <vprintfmt>
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
  800116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <magic+0xffffffffff7f5ad9>
  80011a:	ec06                	sd	ra,24(sp)
  80011c:	e4be                	sd	a5,72(sp)
  80011e:	e8c2                	sd	a6,80(sp)
  800120:	ecc6                	sd	a7,88(sp)
  800122:	e41a                	sd	t1,8(sp)
  800124:	c202                	sw	zero,4(sp)
  800126:	1e8000ef          	jal	ra,80030e <vprintfmt>
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

0000000000800188 <sys_putc>:
  800188:	85aa                	mv	a1,a0
  80018a:	4579                	li	a0,30
  80018c:	fa7ff06f          	j	800132 <syscall>

0000000000800190 <sys_open>:
  800190:	862e                	mv	a2,a1
  800192:	85aa                	mv	a1,a0
  800194:	06400513          	li	a0,100
  800198:	f9bff06f          	j	800132 <syscall>

000000000080019c <sys_close>:
  80019c:	85aa                	mv	a1,a0
  80019e:	06500513          	li	a0,101
  8001a2:	f91ff06f          	j	800132 <syscall>

00000000008001a6 <sys_dup>:
  8001a6:	862e                	mv	a2,a1
  8001a8:	85aa                	mv	a1,a0
  8001aa:	08200513          	li	a0,130
  8001ae:	f85ff06f          	j	800132 <syscall>

00000000008001b2 <exit>:
  8001b2:	1141                	addi	sp,sp,-16
  8001b4:	e406                	sd	ra,8(sp)
  8001b6:	fb5ff0ef          	jal	ra,80016a <sys_exit>
  8001ba:	00000517          	auipc	a0,0x0
  8001be:	67e50513          	addi	a0,a0,1662 # 800838 <main+0x158>
  8001c2:	f37ff0ef          	jal	ra,8000f8 <cprintf>
  8001c6:	a001                	j	8001c6 <exit+0x14>

00000000008001c8 <fork>:
  8001c8:	fabff06f          	j	800172 <sys_fork>

00000000008001cc <wait>:
  8001cc:	4581                	li	a1,0
  8001ce:	4501                	li	a0,0
  8001d0:	fa9ff06f          	j	800178 <sys_wait>

00000000008001d4 <waitpid>:
  8001d4:	fa5ff06f          	j	800178 <sys_wait>

00000000008001d8 <yield>:
  8001d8:	fabff06f          	j	800182 <sys_yield>

00000000008001dc <initfd>:
  8001dc:	1101                	addi	sp,sp,-32
  8001de:	87ae                	mv	a5,a1
  8001e0:	e426                	sd	s1,8(sp)
  8001e2:	85b2                	mv	a1,a2
  8001e4:	84aa                	mv	s1,a0
  8001e6:	853e                	mv	a0,a5
  8001e8:	e822                	sd	s0,16(sp)
  8001ea:	ec06                	sd	ra,24(sp)
  8001ec:	e35ff0ef          	jal	ra,800020 <open>
  8001f0:	842a                	mv	s0,a0
  8001f2:	00054463          	bltz	a0,8001fa <initfd+0x1e>
  8001f6:	00951863          	bne	a0,s1,800206 <initfd+0x2a>
  8001fa:	8522                	mv	a0,s0
  8001fc:	60e2                	ld	ra,24(sp)
  8001fe:	6442                	ld	s0,16(sp)
  800200:	64a2                	ld	s1,8(sp)
  800202:	6105                	addi	sp,sp,32
  800204:	8082                	ret
  800206:	8526                	mv	a0,s1
  800208:	e21ff0ef          	jal	ra,800028 <close>
  80020c:	85a6                	mv	a1,s1
  80020e:	8522                	mv	a0,s0
  800210:	e1dff0ef          	jal	ra,80002c <dup2>
  800214:	84aa                	mv	s1,a0
  800216:	8522                	mv	a0,s0
  800218:	e11ff0ef          	jal	ra,800028 <close>
  80021c:	8426                	mv	s0,s1
  80021e:	bff1                	j	8001fa <initfd+0x1e>

0000000000800220 <umain>:
  800220:	1101                	addi	sp,sp,-32
  800222:	e822                	sd	s0,16(sp)
  800224:	e426                	sd	s1,8(sp)
  800226:	842a                	mv	s0,a0
  800228:	84ae                	mv	s1,a1
  80022a:	4601                	li	a2,0
  80022c:	00000597          	auipc	a1,0x0
  800230:	62458593          	addi	a1,a1,1572 # 800850 <main+0x170>
  800234:	4501                	li	a0,0
  800236:	ec06                	sd	ra,24(sp)
  800238:	fa5ff0ef          	jal	ra,8001dc <initfd>
  80023c:	02054263          	bltz	a0,800260 <umain+0x40>
  800240:	4605                	li	a2,1
  800242:	00000597          	auipc	a1,0x0
  800246:	64e58593          	addi	a1,a1,1614 # 800890 <main+0x1b0>
  80024a:	4505                	li	a0,1
  80024c:	f91ff0ef          	jal	ra,8001dc <initfd>
  800250:	02054663          	bltz	a0,80027c <umain+0x5c>
  800254:	85a6                	mv	a1,s1
  800256:	8522                	mv	a0,s0
  800258:	488000ef          	jal	ra,8006e0 <main>
  80025c:	f57ff0ef          	jal	ra,8001b2 <exit>
  800260:	86aa                	mv	a3,a0
  800262:	00000617          	auipc	a2,0x0
  800266:	5f660613          	addi	a2,a2,1526 # 800858 <main+0x178>
  80026a:	02000593          	li	a1,32
  80026e:	00000517          	auipc	a0,0x0
  800272:	60a50513          	addi	a0,a0,1546 # 800878 <main+0x198>
  800276:	e01ff0ef          	jal	ra,800076 <__warn>
  80027a:	b7d9                	j	800240 <umain+0x20>
  80027c:	86aa                	mv	a3,a0
  80027e:	00000617          	auipc	a2,0x0
  800282:	61a60613          	addi	a2,a2,1562 # 800898 <main+0x1b8>
  800286:	02500593          	li	a1,37
  80028a:	00000517          	auipc	a0,0x0
  80028e:	5ee50513          	addi	a0,a0,1518 # 800878 <main+0x198>
  800292:	de5ff0ef          	jal	ra,800076 <__warn>
  800296:	bf7d                	j	800254 <umain+0x34>

0000000000800298 <printnum>:
  800298:	02071893          	slli	a7,a4,0x20
  80029c:	7139                	addi	sp,sp,-64
  80029e:	0208d893          	srli	a7,a7,0x20
  8002a2:	e456                	sd	s5,8(sp)
  8002a4:	0316fab3          	remu	s5,a3,a7
  8002a8:	f822                	sd	s0,48(sp)
  8002aa:	f426                	sd	s1,40(sp)
  8002ac:	f04a                	sd	s2,32(sp)
  8002ae:	ec4e                	sd	s3,24(sp)
  8002b0:	fc06                	sd	ra,56(sp)
  8002b2:	e852                	sd	s4,16(sp)
  8002b4:	84aa                	mv	s1,a0
  8002b6:	89ae                	mv	s3,a1
  8002b8:	8932                	mv	s2,a2
  8002ba:	fff7841b          	addiw	s0,a5,-1
  8002be:	2a81                	sext.w	s5,s5
  8002c0:	0516f163          	bleu	a7,a3,800302 <printnum+0x6a>
  8002c4:	8a42                	mv	s4,a6
  8002c6:	00805863          	blez	s0,8002d6 <printnum+0x3e>
  8002ca:	347d                	addiw	s0,s0,-1
  8002cc:	864e                	mv	a2,s3
  8002ce:	85ca                	mv	a1,s2
  8002d0:	8552                	mv	a0,s4
  8002d2:	9482                	jalr	s1
  8002d4:	f87d                	bnez	s0,8002ca <printnum+0x32>
  8002d6:	1a82                	slli	s5,s5,0x20
  8002d8:	020ada93          	srli	s5,s5,0x20
  8002dc:	00000797          	auipc	a5,0x0
  8002e0:	7fc78793          	addi	a5,a5,2044 # 800ad8 <error_string+0xc8>
  8002e4:	9abe                	add	s5,s5,a5
  8002e6:	7442                	ld	s0,48(sp)
  8002e8:	000ac503          	lbu	a0,0(s5)
  8002ec:	70e2                	ld	ra,56(sp)
  8002ee:	6a42                	ld	s4,16(sp)
  8002f0:	6aa2                	ld	s5,8(sp)
  8002f2:	864e                	mv	a2,s3
  8002f4:	85ca                	mv	a1,s2
  8002f6:	69e2                	ld	s3,24(sp)
  8002f8:	7902                	ld	s2,32(sp)
  8002fa:	8326                	mv	t1,s1
  8002fc:	74a2                	ld	s1,40(sp)
  8002fe:	6121                	addi	sp,sp,64
  800300:	8302                	jr	t1
  800302:	0316d6b3          	divu	a3,a3,a7
  800306:	87a2                	mv	a5,s0
  800308:	f91ff0ef          	jal	ra,800298 <printnum>
  80030c:	b7e9                	j	8002d6 <printnum+0x3e>

000000000080030e <vprintfmt>:
  80030e:	7119                	addi	sp,sp,-128
  800310:	f4a6                	sd	s1,104(sp)
  800312:	f0ca                	sd	s2,96(sp)
  800314:	ecce                	sd	s3,88(sp)
  800316:	e4d6                	sd	s5,72(sp)
  800318:	e0da                	sd	s6,64(sp)
  80031a:	fc5e                	sd	s7,56(sp)
  80031c:	f862                	sd	s8,48(sp)
  80031e:	ec6e                	sd	s11,24(sp)
  800320:	fc86                	sd	ra,120(sp)
  800322:	f8a2                	sd	s0,112(sp)
  800324:	e8d2                	sd	s4,80(sp)
  800326:	f466                	sd	s9,40(sp)
  800328:	f06a                	sd	s10,32(sp)
  80032a:	89aa                	mv	s3,a0
  80032c:	892e                	mv	s2,a1
  80032e:	84b2                	mv	s1,a2
  800330:	8db6                	mv	s11,a3
  800332:	8b3a                	mv	s6,a4
  800334:	5bfd                	li	s7,-1
  800336:	00000a97          	auipc	s5,0x0
  80033a:	57ea8a93          	addi	s5,s5,1406 # 8008b4 <main+0x1d4>
  80033e:	05e00c13          	li	s8,94
  800342:	000dc503          	lbu	a0,0(s11)
  800346:	02500793          	li	a5,37
  80034a:	001d8413          	addi	s0,s11,1
  80034e:	00f50f63          	beq	a0,a5,80036c <vprintfmt+0x5e>
  800352:	c529                	beqz	a0,80039c <vprintfmt+0x8e>
  800354:	02500a13          	li	s4,37
  800358:	a011                	j	80035c <vprintfmt+0x4e>
  80035a:	c129                	beqz	a0,80039c <vprintfmt+0x8e>
  80035c:	864a                	mv	a2,s2
  80035e:	85a6                	mv	a1,s1
  800360:	0405                	addi	s0,s0,1
  800362:	9982                	jalr	s3
  800364:	fff44503          	lbu	a0,-1(s0)
  800368:	ff4519e3          	bne	a0,s4,80035a <vprintfmt+0x4c>
  80036c:	00044603          	lbu	a2,0(s0)
  800370:	02000813          	li	a6,32
  800374:	4a01                	li	s4,0
  800376:	4881                	li	a7,0
  800378:	5d7d                	li	s10,-1
  80037a:	5cfd                	li	s9,-1
  80037c:	05500593          	li	a1,85
  800380:	4525                	li	a0,9
  800382:	fdd6071b          	addiw	a4,a2,-35
  800386:	0ff77713          	andi	a4,a4,255
  80038a:	00140d93          	addi	s11,s0,1
  80038e:	22e5e363          	bltu	a1,a4,8005b4 <vprintfmt+0x2a6>
  800392:	070a                	slli	a4,a4,0x2
  800394:	9756                	add	a4,a4,s5
  800396:	4318                	lw	a4,0(a4)
  800398:	9756                	add	a4,a4,s5
  80039a:	8702                	jr	a4
  80039c:	70e6                	ld	ra,120(sp)
  80039e:	7446                	ld	s0,112(sp)
  8003a0:	74a6                	ld	s1,104(sp)
  8003a2:	7906                	ld	s2,96(sp)
  8003a4:	69e6                	ld	s3,88(sp)
  8003a6:	6a46                	ld	s4,80(sp)
  8003a8:	6aa6                	ld	s5,72(sp)
  8003aa:	6b06                	ld	s6,64(sp)
  8003ac:	7be2                	ld	s7,56(sp)
  8003ae:	7c42                	ld	s8,48(sp)
  8003b0:	7ca2                	ld	s9,40(sp)
  8003b2:	7d02                	ld	s10,32(sp)
  8003b4:	6de2                	ld	s11,24(sp)
  8003b6:	6109                	addi	sp,sp,128
  8003b8:	8082                	ret
  8003ba:	4705                	li	a4,1
  8003bc:	008b0613          	addi	a2,s6,8
  8003c0:	01174463          	blt	a4,a7,8003c8 <vprintfmt+0xba>
  8003c4:	28088563          	beqz	a7,80064e <vprintfmt+0x340>
  8003c8:	000b3683          	ld	a3,0(s6)
  8003cc:	4741                	li	a4,16
  8003ce:	8b32                	mv	s6,a2
  8003d0:	a86d                	j	80048a <vprintfmt+0x17c>
  8003d2:	00144603          	lbu	a2,1(s0)
  8003d6:	4a05                	li	s4,1
  8003d8:	846e                	mv	s0,s11
  8003da:	b765                	j	800382 <vprintfmt+0x74>
  8003dc:	000b2503          	lw	a0,0(s6)
  8003e0:	864a                	mv	a2,s2
  8003e2:	85a6                	mv	a1,s1
  8003e4:	0b21                	addi	s6,s6,8
  8003e6:	9982                	jalr	s3
  8003e8:	bfa9                	j	800342 <vprintfmt+0x34>
  8003ea:	4705                	li	a4,1
  8003ec:	008b0a13          	addi	s4,s6,8
  8003f0:	01174463          	blt	a4,a7,8003f8 <vprintfmt+0xea>
  8003f4:	24088563          	beqz	a7,80063e <vprintfmt+0x330>
  8003f8:	000b3403          	ld	s0,0(s6)
  8003fc:	26044563          	bltz	s0,800666 <vprintfmt+0x358>
  800400:	86a2                	mv	a3,s0
  800402:	8b52                	mv	s6,s4
  800404:	4729                	li	a4,10
  800406:	a051                	j	80048a <vprintfmt+0x17c>
  800408:	000b2783          	lw	a5,0(s6)
  80040c:	46e1                	li	a3,24
  80040e:	0b21                	addi	s6,s6,8
  800410:	41f7d71b          	sraiw	a4,a5,0x1f
  800414:	8fb9                	xor	a5,a5,a4
  800416:	40e7873b          	subw	a4,a5,a4
  80041a:	1ce6c163          	blt	a3,a4,8005dc <vprintfmt+0x2ce>
  80041e:	00371793          	slli	a5,a4,0x3
  800422:	00000697          	auipc	a3,0x0
  800426:	5ee68693          	addi	a3,a3,1518 # 800a10 <error_string>
  80042a:	97b6                	add	a5,a5,a3
  80042c:	639c                	ld	a5,0(a5)
  80042e:	1a078763          	beqz	a5,8005dc <vprintfmt+0x2ce>
  800432:	873e                	mv	a4,a5
  800434:	00001697          	auipc	a3,0x1
  800438:	8ac68693          	addi	a3,a3,-1876 # 800ce0 <error_string+0x2d0>
  80043c:	8626                	mv	a2,s1
  80043e:	85ca                	mv	a1,s2
  800440:	854e                	mv	a0,s3
  800442:	25a000ef          	jal	ra,80069c <printfmt>
  800446:	bdf5                	j	800342 <vprintfmt+0x34>
  800448:	00144603          	lbu	a2,1(s0)
  80044c:	2885                	addiw	a7,a7,1
  80044e:	846e                	mv	s0,s11
  800450:	bf0d                	j	800382 <vprintfmt+0x74>
  800452:	4705                	li	a4,1
  800454:	008b0613          	addi	a2,s6,8
  800458:	01174463          	blt	a4,a7,800460 <vprintfmt+0x152>
  80045c:	1e088e63          	beqz	a7,800658 <vprintfmt+0x34a>
  800460:	000b3683          	ld	a3,0(s6)
  800464:	4721                	li	a4,8
  800466:	8b32                	mv	s6,a2
  800468:	a00d                	j	80048a <vprintfmt+0x17c>
  80046a:	03000513          	li	a0,48
  80046e:	864a                	mv	a2,s2
  800470:	85a6                	mv	a1,s1
  800472:	e042                	sd	a6,0(sp)
  800474:	9982                	jalr	s3
  800476:	864a                	mv	a2,s2
  800478:	85a6                	mv	a1,s1
  80047a:	07800513          	li	a0,120
  80047e:	9982                	jalr	s3
  800480:	0b21                	addi	s6,s6,8
  800482:	ff8b3683          	ld	a3,-8(s6)
  800486:	6802                	ld	a6,0(sp)
  800488:	4741                	li	a4,16
  80048a:	87e6                	mv	a5,s9
  80048c:	8626                	mv	a2,s1
  80048e:	85ca                	mv	a1,s2
  800490:	854e                	mv	a0,s3
  800492:	e07ff0ef          	jal	ra,800298 <printnum>
  800496:	b575                	j	800342 <vprintfmt+0x34>
  800498:	000b3703          	ld	a4,0(s6)
  80049c:	0b21                	addi	s6,s6,8
  80049e:	1e070063          	beqz	a4,80067e <vprintfmt+0x370>
  8004a2:	00170413          	addi	s0,a4,1
  8004a6:	19905563          	blez	s9,800630 <vprintfmt+0x322>
  8004aa:	02d00613          	li	a2,45
  8004ae:	14c81963          	bne	a6,a2,800600 <vprintfmt+0x2f2>
  8004b2:	00074703          	lbu	a4,0(a4)
  8004b6:	0007051b          	sext.w	a0,a4
  8004ba:	c90d                	beqz	a0,8004ec <vprintfmt+0x1de>
  8004bc:	000d4563          	bltz	s10,8004c6 <vprintfmt+0x1b8>
  8004c0:	3d7d                	addiw	s10,s10,-1
  8004c2:	037d0363          	beq	s10,s7,8004e8 <vprintfmt+0x1da>
  8004c6:	864a                	mv	a2,s2
  8004c8:	85a6                	mv	a1,s1
  8004ca:	180a0c63          	beqz	s4,800662 <vprintfmt+0x354>
  8004ce:	3701                	addiw	a4,a4,-32
  8004d0:	18ec7963          	bleu	a4,s8,800662 <vprintfmt+0x354>
  8004d4:	03f00513          	li	a0,63
  8004d8:	9982                	jalr	s3
  8004da:	0405                	addi	s0,s0,1
  8004dc:	fff44703          	lbu	a4,-1(s0)
  8004e0:	3cfd                	addiw	s9,s9,-1
  8004e2:	0007051b          	sext.w	a0,a4
  8004e6:	f979                	bnez	a0,8004bc <vprintfmt+0x1ae>
  8004e8:	e5905de3          	blez	s9,800342 <vprintfmt+0x34>
  8004ec:	3cfd                	addiw	s9,s9,-1
  8004ee:	864a                	mv	a2,s2
  8004f0:	85a6                	mv	a1,s1
  8004f2:	02000513          	li	a0,32
  8004f6:	9982                	jalr	s3
  8004f8:	e40c85e3          	beqz	s9,800342 <vprintfmt+0x34>
  8004fc:	3cfd                	addiw	s9,s9,-1
  8004fe:	864a                	mv	a2,s2
  800500:	85a6                	mv	a1,s1
  800502:	02000513          	li	a0,32
  800506:	9982                	jalr	s3
  800508:	fe0c92e3          	bnez	s9,8004ec <vprintfmt+0x1de>
  80050c:	bd1d                	j	800342 <vprintfmt+0x34>
  80050e:	4705                	li	a4,1
  800510:	008b0613          	addi	a2,s6,8
  800514:	01174463          	blt	a4,a7,80051c <vprintfmt+0x20e>
  800518:	12088663          	beqz	a7,800644 <vprintfmt+0x336>
  80051c:	000b3683          	ld	a3,0(s6)
  800520:	4729                	li	a4,10
  800522:	8b32                	mv	s6,a2
  800524:	b79d                	j	80048a <vprintfmt+0x17c>
  800526:	00144603          	lbu	a2,1(s0)
  80052a:	02d00813          	li	a6,45
  80052e:	846e                	mv	s0,s11
  800530:	bd89                	j	800382 <vprintfmt+0x74>
  800532:	864a                	mv	a2,s2
  800534:	85a6                	mv	a1,s1
  800536:	02500513          	li	a0,37
  80053a:	9982                	jalr	s3
  80053c:	b519                	j	800342 <vprintfmt+0x34>
  80053e:	000b2d03          	lw	s10,0(s6)
  800542:	00144603          	lbu	a2,1(s0)
  800546:	0b21                	addi	s6,s6,8
  800548:	846e                	mv	s0,s11
  80054a:	e20cdce3          	bgez	s9,800382 <vprintfmt+0x74>
  80054e:	8cea                	mv	s9,s10
  800550:	5d7d                	li	s10,-1
  800552:	bd05                	j	800382 <vprintfmt+0x74>
  800554:	00144603          	lbu	a2,1(s0)
  800558:	03000813          	li	a6,48
  80055c:	846e                	mv	s0,s11
  80055e:	b515                	j	800382 <vprintfmt+0x74>
  800560:	fd060d1b          	addiw	s10,a2,-48
  800564:	00144603          	lbu	a2,1(s0)
  800568:	846e                	mv	s0,s11
  80056a:	fd06071b          	addiw	a4,a2,-48
  80056e:	0006031b          	sext.w	t1,a2
  800572:	fce56ce3          	bltu	a0,a4,80054a <vprintfmt+0x23c>
  800576:	0405                	addi	s0,s0,1
  800578:	002d171b          	slliw	a4,s10,0x2
  80057c:	00044603          	lbu	a2,0(s0)
  800580:	01a706bb          	addw	a3,a4,s10
  800584:	0016969b          	slliw	a3,a3,0x1
  800588:	006686bb          	addw	a3,a3,t1
  80058c:	fd06071b          	addiw	a4,a2,-48
  800590:	fd068d1b          	addiw	s10,a3,-48
  800594:	0006031b          	sext.w	t1,a2
  800598:	fce57fe3          	bleu	a4,a0,800576 <vprintfmt+0x268>
  80059c:	b77d                	j	80054a <vprintfmt+0x23c>
  80059e:	fffcc713          	not	a4,s9
  8005a2:	977d                	srai	a4,a4,0x3f
  8005a4:	00ecf7b3          	and	a5,s9,a4
  8005a8:	00144603          	lbu	a2,1(s0)
  8005ac:	00078c9b          	sext.w	s9,a5
  8005b0:	846e                	mv	s0,s11
  8005b2:	bbc1                	j	800382 <vprintfmt+0x74>
  8005b4:	864a                	mv	a2,s2
  8005b6:	85a6                	mv	a1,s1
  8005b8:	02500513          	li	a0,37
  8005bc:	9982                	jalr	s3
  8005be:	fff44703          	lbu	a4,-1(s0)
  8005c2:	02500793          	li	a5,37
  8005c6:	8da2                	mv	s11,s0
  8005c8:	d6f70de3          	beq	a4,a5,800342 <vprintfmt+0x34>
  8005cc:	02500713          	li	a4,37
  8005d0:	1dfd                	addi	s11,s11,-1
  8005d2:	fffdc783          	lbu	a5,-1(s11)
  8005d6:	fee79de3          	bne	a5,a4,8005d0 <vprintfmt+0x2c2>
  8005da:	b3a5                	j	800342 <vprintfmt+0x34>
  8005dc:	00000697          	auipc	a3,0x0
  8005e0:	6f468693          	addi	a3,a3,1780 # 800cd0 <error_string+0x2c0>
  8005e4:	8626                	mv	a2,s1
  8005e6:	85ca                	mv	a1,s2
  8005e8:	854e                	mv	a0,s3
  8005ea:	0b2000ef          	jal	ra,80069c <printfmt>
  8005ee:	bb91                	j	800342 <vprintfmt+0x34>
  8005f0:	00000717          	auipc	a4,0x0
  8005f4:	6d870713          	addi	a4,a4,1752 # 800cc8 <error_string+0x2b8>
  8005f8:	00000417          	auipc	s0,0x0
  8005fc:	6d140413          	addi	s0,s0,1745 # 800cc9 <error_string+0x2b9>
  800600:	853a                	mv	a0,a4
  800602:	85ea                	mv	a1,s10
  800604:	e03a                	sd	a4,0(sp)
  800606:	e442                	sd	a6,8(sp)
  800608:	0b2000ef          	jal	ra,8006ba <strnlen>
  80060c:	40ac8cbb          	subw	s9,s9,a0
  800610:	6702                	ld	a4,0(sp)
  800612:	01905f63          	blez	s9,800630 <vprintfmt+0x322>
  800616:	6822                	ld	a6,8(sp)
  800618:	0008079b          	sext.w	a5,a6
  80061c:	e43e                	sd	a5,8(sp)
  80061e:	6522                	ld	a0,8(sp)
  800620:	864a                	mv	a2,s2
  800622:	85a6                	mv	a1,s1
  800624:	e03a                	sd	a4,0(sp)
  800626:	3cfd                	addiw	s9,s9,-1
  800628:	9982                	jalr	s3
  80062a:	6702                	ld	a4,0(sp)
  80062c:	fe0c99e3          	bnez	s9,80061e <vprintfmt+0x310>
  800630:	00074703          	lbu	a4,0(a4)
  800634:	0007051b          	sext.w	a0,a4
  800638:	e80512e3          	bnez	a0,8004bc <vprintfmt+0x1ae>
  80063c:	b319                	j	800342 <vprintfmt+0x34>
  80063e:	000b2403          	lw	s0,0(s6)
  800642:	bb6d                	j	8003fc <vprintfmt+0xee>
  800644:	000b6683          	lwu	a3,0(s6)
  800648:	4729                	li	a4,10
  80064a:	8b32                	mv	s6,a2
  80064c:	bd3d                	j	80048a <vprintfmt+0x17c>
  80064e:	000b6683          	lwu	a3,0(s6)
  800652:	4741                	li	a4,16
  800654:	8b32                	mv	s6,a2
  800656:	bd15                	j	80048a <vprintfmt+0x17c>
  800658:	000b6683          	lwu	a3,0(s6)
  80065c:	4721                	li	a4,8
  80065e:	8b32                	mv	s6,a2
  800660:	b52d                	j	80048a <vprintfmt+0x17c>
  800662:	9982                	jalr	s3
  800664:	bd9d                	j	8004da <vprintfmt+0x1cc>
  800666:	864a                	mv	a2,s2
  800668:	85a6                	mv	a1,s1
  80066a:	02d00513          	li	a0,45
  80066e:	e042                	sd	a6,0(sp)
  800670:	9982                	jalr	s3
  800672:	8b52                	mv	s6,s4
  800674:	408006b3          	neg	a3,s0
  800678:	4729                	li	a4,10
  80067a:	6802                	ld	a6,0(sp)
  80067c:	b539                	j	80048a <vprintfmt+0x17c>
  80067e:	01905663          	blez	s9,80068a <vprintfmt+0x37c>
  800682:	02d00713          	li	a4,45
  800686:	f6e815e3          	bne	a6,a4,8005f0 <vprintfmt+0x2e2>
  80068a:	00000417          	auipc	s0,0x0
  80068e:	63f40413          	addi	s0,s0,1599 # 800cc9 <error_string+0x2b9>
  800692:	02800513          	li	a0,40
  800696:	02800713          	li	a4,40
  80069a:	b50d                	j	8004bc <vprintfmt+0x1ae>

000000000080069c <printfmt>:
  80069c:	7139                	addi	sp,sp,-64
  80069e:	02010313          	addi	t1,sp,32
  8006a2:	f03a                	sd	a4,32(sp)
  8006a4:	871a                	mv	a4,t1
  8006a6:	ec06                	sd	ra,24(sp)
  8006a8:	f43e                	sd	a5,40(sp)
  8006aa:	f842                	sd	a6,48(sp)
  8006ac:	fc46                	sd	a7,56(sp)
  8006ae:	e41a                	sd	t1,8(sp)
  8006b0:	c5fff0ef          	jal	ra,80030e <vprintfmt>
  8006b4:	60e2                	ld	ra,24(sp)
  8006b6:	6121                	addi	sp,sp,64
  8006b8:	8082                	ret

00000000008006ba <strnlen>:
  8006ba:	c185                	beqz	a1,8006da <strnlen+0x20>
  8006bc:	00054783          	lbu	a5,0(a0)
  8006c0:	cf89                	beqz	a5,8006da <strnlen+0x20>
  8006c2:	4781                	li	a5,0
  8006c4:	a021                	j	8006cc <strnlen+0x12>
  8006c6:	00074703          	lbu	a4,0(a4)
  8006ca:	c711                	beqz	a4,8006d6 <strnlen+0x1c>
  8006cc:	0785                	addi	a5,a5,1
  8006ce:	00f50733          	add	a4,a0,a5
  8006d2:	fef59ae3          	bne	a1,a5,8006c6 <strnlen+0xc>
  8006d6:	853e                	mv	a0,a5
  8006d8:	8082                	ret
  8006da:	4781                	li	a5,0
  8006dc:	853e                	mv	a0,a5
  8006de:	8082                	ret

00000000008006e0 <main>:
  8006e0:	1101                	addi	sp,sp,-32
  8006e2:	00000517          	auipc	a0,0x0
  8006e6:	60650513          	addi	a0,a0,1542 # 800ce8 <error_string+0x2d8>
  8006ea:	ec06                	sd	ra,24(sp)
  8006ec:	e822                	sd	s0,16(sp)
  8006ee:	a0bff0ef          	jal	ra,8000f8 <cprintf>
  8006f2:	ad7ff0ef          	jal	ra,8001c8 <fork>
  8006f6:	c569                	beqz	a0,8007c0 <main+0xe0>
  8006f8:	842a                	mv	s0,a0
  8006fa:	85aa                	mv	a1,a0
  8006fc:	00000517          	auipc	a0,0x0
  800700:	62c50513          	addi	a0,a0,1580 # 800d28 <error_string+0x318>
  800704:	9f5ff0ef          	jal	ra,8000f8 <cprintf>
  800708:	08805d63          	blez	s0,8007a2 <main+0xc2>
  80070c:	00000517          	auipc	a0,0x0
  800710:	67450513          	addi	a0,a0,1652 # 800d80 <error_string+0x370>
  800714:	9e5ff0ef          	jal	ra,8000f8 <cprintf>
  800718:	006c                	addi	a1,sp,12
  80071a:	8522                	mv	a0,s0
  80071c:	ab9ff0ef          	jal	ra,8001d4 <waitpid>
  800720:	e139                	bnez	a0,800766 <main+0x86>
  800722:	00001797          	auipc	a5,0x1
  800726:	8de78793          	addi	a5,a5,-1826 # 801000 <magic>
  80072a:	4732                	lw	a4,12(sp)
  80072c:	439c                	lw	a5,0(a5)
  80072e:	02f71c63          	bne	a4,a5,800766 <main+0x86>
  800732:	006c                	addi	a1,sp,12
  800734:	8522                	mv	a0,s0
  800736:	a9fff0ef          	jal	ra,8001d4 <waitpid>
  80073a:	c529                	beqz	a0,800784 <main+0xa4>
  80073c:	a91ff0ef          	jal	ra,8001cc <wait>
  800740:	c131                	beqz	a0,800784 <main+0xa4>
  800742:	85a2                	mv	a1,s0
  800744:	00000517          	auipc	a0,0x0
  800748:	6b450513          	addi	a0,a0,1716 # 800df8 <error_string+0x3e8>
  80074c:	9adff0ef          	jal	ra,8000f8 <cprintf>
  800750:	00000517          	auipc	a0,0x0
  800754:	6b850513          	addi	a0,a0,1720 # 800e08 <error_string+0x3f8>
  800758:	9a1ff0ef          	jal	ra,8000f8 <cprintf>
  80075c:	60e2                	ld	ra,24(sp)
  80075e:	6442                	ld	s0,16(sp)
  800760:	4501                	li	a0,0
  800762:	6105                	addi	sp,sp,32
  800764:	8082                	ret
  800766:	00000697          	auipc	a3,0x0
  80076a:	63a68693          	addi	a3,a3,1594 # 800da0 <error_string+0x390>
  80076e:	00000617          	auipc	a2,0x0
  800772:	5ea60613          	addi	a2,a2,1514 # 800d58 <error_string+0x348>
  800776:	45ed                	li	a1,27
  800778:	00000517          	auipc	a0,0x0
  80077c:	5f850513          	addi	a0,a0,1528 # 800d70 <error_string+0x360>
  800780:	8b7ff0ef          	jal	ra,800036 <__panic>
  800784:	00000697          	auipc	a3,0x0
  800788:	64c68693          	addi	a3,a3,1612 # 800dd0 <error_string+0x3c0>
  80078c:	00000617          	auipc	a2,0x0
  800790:	5cc60613          	addi	a2,a2,1484 # 800d58 <error_string+0x348>
  800794:	45f1                	li	a1,28
  800796:	00000517          	auipc	a0,0x0
  80079a:	5da50513          	addi	a0,a0,1498 # 800d70 <error_string+0x360>
  80079e:	899ff0ef          	jal	ra,800036 <__panic>
  8007a2:	00000697          	auipc	a3,0x0
  8007a6:	5ae68693          	addi	a3,a3,1454 # 800d50 <error_string+0x340>
  8007aa:	00000617          	auipc	a2,0x0
  8007ae:	5ae60613          	addi	a2,a2,1454 # 800d58 <error_string+0x348>
  8007b2:	45e1                	li	a1,24
  8007b4:	00000517          	auipc	a0,0x0
  8007b8:	5bc50513          	addi	a0,a0,1468 # 800d70 <error_string+0x360>
  8007bc:	87bff0ef          	jal	ra,800036 <__panic>
  8007c0:	00000517          	auipc	a0,0x0
  8007c4:	55050513          	addi	a0,a0,1360 # 800d10 <error_string+0x300>
  8007c8:	931ff0ef          	jal	ra,8000f8 <cprintf>
  8007cc:	a0dff0ef          	jal	ra,8001d8 <yield>
  8007d0:	a09ff0ef          	jal	ra,8001d8 <yield>
  8007d4:	a05ff0ef          	jal	ra,8001d8 <yield>
  8007d8:	a01ff0ef          	jal	ra,8001d8 <yield>
  8007dc:	9fdff0ef          	jal	ra,8001d8 <yield>
  8007e0:	9f9ff0ef          	jal	ra,8001d8 <yield>
  8007e4:	9f5ff0ef          	jal	ra,8001d8 <yield>
  8007e8:	00001797          	auipc	a5,0x1
  8007ec:	81878793          	addi	a5,a5,-2024 # 801000 <magic>
  8007f0:	4388                	lw	a0,0(a5)
  8007f2:	9c1ff0ef          	jal	ra,8001b2 <exit>
