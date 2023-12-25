
obj/__user_forktree.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1280006f          	j	80014c <sys_open>

0000000000800028 <close>:
  800028:	1300006f          	j	800158 <sys_close>

000000000080002c <dup2>:
  80002c:	1360006f          	j	800162 <sys_dup>

0000000000800030 <_start>:
  800030:	1a4000ef          	jal	ra,8001d4 <umain>
  800034:	a001                	j	800034 <_start+0x4>

0000000000800036 <__warn>:
  800036:	715d                	addi	sp,sp,-80
  800038:	e822                	sd	s0,16(sp)
  80003a:	fc3e                	sd	a5,56(sp)
  80003c:	8432                	mv	s0,a2
  80003e:	103c                	addi	a5,sp,40
  800040:	862e                	mv	a2,a1
  800042:	85aa                	mv	a1,a0
  800044:	00000517          	auipc	a0,0x0
  800048:	7a450513          	addi	a0,a0,1956 # 8007e8 <main+0x3e>
  80004c:	ec06                	sd	ra,24(sp)
  80004e:	f436                	sd	a3,40(sp)
  800050:	f83a                	sd	a4,48(sp)
  800052:	e0c2                	sd	a6,64(sp)
  800054:	e4c6                	sd	a7,72(sp)
  800056:	e43e                	sd	a5,8(sp)
  800058:	060000ef          	jal	ra,8000b8 <cprintf>
  80005c:	65a2                	ld	a1,8(sp)
  80005e:	8522                	mv	a0,s0
  800060:	032000ef          	jal	ra,800092 <vcprintf>
  800064:	00000517          	auipc	a0,0x0
  800068:	7dc50513          	addi	a0,a0,2012 # 800840 <main+0x96>
  80006c:	04c000ef          	jal	ra,8000b8 <cprintf>
  800070:	60e2                	ld	ra,24(sp)
  800072:	6442                	ld	s0,16(sp)
  800074:	6161                	addi	sp,sp,80
  800076:	8082                	ret

0000000000800078 <cputch>:
  800078:	1141                	addi	sp,sp,-16
  80007a:	e022                	sd	s0,0(sp)
  80007c:	e406                	sd	ra,8(sp)
  80007e:	842e                	mv	s0,a1
  800080:	0c4000ef          	jal	ra,800144 <sys_putc>
  800084:	401c                	lw	a5,0(s0)
  800086:	60a2                	ld	ra,8(sp)
  800088:	2785                	addiw	a5,a5,1
  80008a:	c01c                	sw	a5,0(s0)
  80008c:	6402                	ld	s0,0(sp)
  80008e:	0141                	addi	sp,sp,16
  800090:	8082                	ret

0000000000800092 <vcprintf>:
  800092:	1101                	addi	sp,sp,-32
  800094:	872e                	mv	a4,a1
  800096:	75dd                	lui	a1,0xffff7
  800098:	86aa                	mv	a3,a0
  80009a:	0070                	addi	a2,sp,12
  80009c:	00000517          	auipc	a0,0x0
  8000a0:	fdc50513          	addi	a0,a0,-36 # 800078 <cputch>
  8000a4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f60f9>
  8000a8:	ec06                	sd	ra,24(sp)
  8000aa:	c602                	sw	zero,12(sp)
  8000ac:	230000ef          	jal	ra,8002dc <vprintfmt>
  8000b0:	60e2                	ld	ra,24(sp)
  8000b2:	4532                	lw	a0,12(sp)
  8000b4:	6105                	addi	sp,sp,32
  8000b6:	8082                	ret

00000000008000b8 <cprintf>:
  8000b8:	711d                	addi	sp,sp,-96
  8000ba:	02810313          	addi	t1,sp,40
  8000be:	f42e                	sd	a1,40(sp)
  8000c0:	75dd                	lui	a1,0xffff7
  8000c2:	f832                	sd	a2,48(sp)
  8000c4:	fc36                	sd	a3,56(sp)
  8000c6:	e0ba                	sd	a4,64(sp)
  8000c8:	86aa                	mv	a3,a0
  8000ca:	0050                	addi	a2,sp,4
  8000cc:	00000517          	auipc	a0,0x0
  8000d0:	fac50513          	addi	a0,a0,-84 # 800078 <cputch>
  8000d4:	871a                	mv	a4,t1
  8000d6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f60f9>
  8000da:	ec06                	sd	ra,24(sp)
  8000dc:	e4be                	sd	a5,72(sp)
  8000de:	e8c2                	sd	a6,80(sp)
  8000e0:	ecc6                	sd	a7,88(sp)
  8000e2:	e41a                	sd	t1,8(sp)
  8000e4:	c202                	sw	zero,4(sp)
  8000e6:	1f6000ef          	jal	ra,8002dc <vprintfmt>
  8000ea:	60e2                	ld	ra,24(sp)
  8000ec:	4512                	lw	a0,4(sp)
  8000ee:	6125                	addi	sp,sp,96
  8000f0:	8082                	ret

00000000008000f2 <syscall>:
  8000f2:	7175                	addi	sp,sp,-144
  8000f4:	f8ba                	sd	a4,112(sp)
  8000f6:	e0ba                	sd	a4,64(sp)
  8000f8:	0118                	addi	a4,sp,128
  8000fa:	e42a                	sd	a0,8(sp)
  8000fc:	ecae                	sd	a1,88(sp)
  8000fe:	f0b2                	sd	a2,96(sp)
  800100:	f4b6                	sd	a3,104(sp)
  800102:	fcbe                	sd	a5,120(sp)
  800104:	e142                	sd	a6,128(sp)
  800106:	e546                	sd	a7,136(sp)
  800108:	f42e                	sd	a1,40(sp)
  80010a:	f832                	sd	a2,48(sp)
  80010c:	fc36                	sd	a3,56(sp)
  80010e:	f03a                	sd	a4,32(sp)
  800110:	e4be                	sd	a5,72(sp)
  800112:	4522                	lw	a0,8(sp)
  800114:	55a2                	lw	a1,40(sp)
  800116:	5642                	lw	a2,48(sp)
  800118:	56e2                	lw	a3,56(sp)
  80011a:	4706                	lw	a4,64(sp)
  80011c:	47a6                	lw	a5,72(sp)
  80011e:	00000073          	ecall
  800122:	ce2a                	sw	a0,28(sp)
  800124:	4572                	lw	a0,28(sp)
  800126:	6149                	addi	sp,sp,144
  800128:	8082                	ret

000000000080012a <sys_exit>:
  80012a:	85aa                	mv	a1,a0
  80012c:	4505                	li	a0,1
  80012e:	fc5ff06f          	j	8000f2 <syscall>

0000000000800132 <sys_fork>:
  800132:	4509                	li	a0,2
  800134:	fbfff06f          	j	8000f2 <syscall>

0000000000800138 <sys_yield>:
  800138:	4529                	li	a0,10
  80013a:	fb9ff06f          	j	8000f2 <syscall>

000000000080013e <sys_getpid>:
  80013e:	4549                	li	a0,18
  800140:	fb3ff06f          	j	8000f2 <syscall>

0000000000800144 <sys_putc>:
  800144:	85aa                	mv	a1,a0
  800146:	4579                	li	a0,30
  800148:	fabff06f          	j	8000f2 <syscall>

000000000080014c <sys_open>:
  80014c:	862e                	mv	a2,a1
  80014e:	85aa                	mv	a1,a0
  800150:	06400513          	li	a0,100
  800154:	f9fff06f          	j	8000f2 <syscall>

0000000000800158 <sys_close>:
  800158:	85aa                	mv	a1,a0
  80015a:	06500513          	li	a0,101
  80015e:	f95ff06f          	j	8000f2 <syscall>

0000000000800162 <sys_dup>:
  800162:	862e                	mv	a2,a1
  800164:	85aa                	mv	a1,a0
  800166:	08200513          	li	a0,130
  80016a:	f89ff06f          	j	8000f2 <syscall>

000000000080016e <exit>:
  80016e:	1141                	addi	sp,sp,-16
  800170:	e406                	sd	ra,8(sp)
  800172:	fb9ff0ef          	jal	ra,80012a <sys_exit>
  800176:	00000517          	auipc	a0,0x0
  80017a:	69250513          	addi	a0,a0,1682 # 800808 <main+0x5e>
  80017e:	f3bff0ef          	jal	ra,8000b8 <cprintf>
  800182:	a001                	j	800182 <exit+0x14>

0000000000800184 <fork>:
  800184:	fafff06f          	j	800132 <sys_fork>

0000000000800188 <yield>:
  800188:	fb1ff06f          	j	800138 <sys_yield>

000000000080018c <getpid>:
  80018c:	fb3ff06f          	j	80013e <sys_getpid>

0000000000800190 <initfd>:
  800190:	1101                	addi	sp,sp,-32
  800192:	87ae                	mv	a5,a1
  800194:	e426                	sd	s1,8(sp)
  800196:	85b2                	mv	a1,a2
  800198:	84aa                	mv	s1,a0
  80019a:	853e                	mv	a0,a5
  80019c:	e822                	sd	s0,16(sp)
  80019e:	ec06                	sd	ra,24(sp)
  8001a0:	e81ff0ef          	jal	ra,800020 <open>
  8001a4:	842a                	mv	s0,a0
  8001a6:	00054463          	bltz	a0,8001ae <initfd+0x1e>
  8001aa:	00951863          	bne	a0,s1,8001ba <initfd+0x2a>
  8001ae:	8522                	mv	a0,s0
  8001b0:	60e2                	ld	ra,24(sp)
  8001b2:	6442                	ld	s0,16(sp)
  8001b4:	64a2                	ld	s1,8(sp)
  8001b6:	6105                	addi	sp,sp,32
  8001b8:	8082                	ret
  8001ba:	8526                	mv	a0,s1
  8001bc:	e6dff0ef          	jal	ra,800028 <close>
  8001c0:	85a6                	mv	a1,s1
  8001c2:	8522                	mv	a0,s0
  8001c4:	e69ff0ef          	jal	ra,80002c <dup2>
  8001c8:	84aa                	mv	s1,a0
  8001ca:	8522                	mv	a0,s0
  8001cc:	e5dff0ef          	jal	ra,800028 <close>
  8001d0:	8426                	mv	s0,s1
  8001d2:	bff1                	j	8001ae <initfd+0x1e>

00000000008001d4 <umain>:
  8001d4:	1101                	addi	sp,sp,-32
  8001d6:	e822                	sd	s0,16(sp)
  8001d8:	e426                	sd	s1,8(sp)
  8001da:	842a                	mv	s0,a0
  8001dc:	84ae                	mv	s1,a1
  8001de:	4601                	li	a2,0
  8001e0:	00000597          	auipc	a1,0x0
  8001e4:	64058593          	addi	a1,a1,1600 # 800820 <main+0x76>
  8001e8:	4501                	li	a0,0
  8001ea:	ec06                	sd	ra,24(sp)
  8001ec:	fa5ff0ef          	jal	ra,800190 <initfd>
  8001f0:	02054263          	bltz	a0,800214 <umain+0x40>
  8001f4:	4605                	li	a2,1
  8001f6:	00000597          	auipc	a1,0x0
  8001fa:	66a58593          	addi	a1,a1,1642 # 800860 <main+0xb6>
  8001fe:	4505                	li	a0,1
  800200:	f91ff0ef          	jal	ra,800190 <initfd>
  800204:	02054663          	bltz	a0,800230 <umain+0x5c>
  800208:	85a6                	mv	a1,s1
  80020a:	8522                	mv	a0,s0
  80020c:	59e000ef          	jal	ra,8007aa <main>
  800210:	f5fff0ef          	jal	ra,80016e <exit>
  800214:	86aa                	mv	a3,a0
  800216:	00000617          	auipc	a2,0x0
  80021a:	61260613          	addi	a2,a2,1554 # 800828 <main+0x7e>
  80021e:	02000593          	li	a1,32
  800222:	00000517          	auipc	a0,0x0
  800226:	62650513          	addi	a0,a0,1574 # 800848 <main+0x9e>
  80022a:	e0dff0ef          	jal	ra,800036 <__warn>
  80022e:	b7d9                	j	8001f4 <umain+0x20>
  800230:	86aa                	mv	a3,a0
  800232:	00000617          	auipc	a2,0x0
  800236:	63660613          	addi	a2,a2,1590 # 800868 <main+0xbe>
  80023a:	02500593          	li	a1,37
  80023e:	00000517          	auipc	a0,0x0
  800242:	60a50513          	addi	a0,a0,1546 # 800848 <main+0x9e>
  800246:	df1ff0ef          	jal	ra,800036 <__warn>
  80024a:	bf7d                	j	800208 <umain+0x34>

000000000080024c <printnum>:
  80024c:	02071893          	slli	a7,a4,0x20
  800250:	7139                	addi	sp,sp,-64
  800252:	0208d893          	srli	a7,a7,0x20
  800256:	e456                	sd	s5,8(sp)
  800258:	0316fab3          	remu	s5,a3,a7
  80025c:	f822                	sd	s0,48(sp)
  80025e:	f426                	sd	s1,40(sp)
  800260:	f04a                	sd	s2,32(sp)
  800262:	ec4e                	sd	s3,24(sp)
  800264:	fc06                	sd	ra,56(sp)
  800266:	e852                	sd	s4,16(sp)
  800268:	84aa                	mv	s1,a0
  80026a:	89ae                	mv	s3,a1
  80026c:	8932                	mv	s2,a2
  80026e:	fff7841b          	addiw	s0,a5,-1
  800272:	2a81                	sext.w	s5,s5
  800274:	0516f163          	bleu	a7,a3,8002b6 <printnum+0x6a>
  800278:	8a42                	mv	s4,a6
  80027a:	00805863          	blez	s0,80028a <printnum+0x3e>
  80027e:	347d                	addiw	s0,s0,-1
  800280:	864e                	mv	a2,s3
  800282:	85ca                	mv	a1,s2
  800284:	8552                	mv	a0,s4
  800286:	9482                	jalr	s1
  800288:	f87d                	bnez	s0,80027e <printnum+0x32>
  80028a:	1a82                	slli	s5,s5,0x20
  80028c:	020ada93          	srli	s5,s5,0x20
  800290:	00001797          	auipc	a5,0x1
  800294:	81878793          	addi	a5,a5,-2024 # 800aa8 <error_string+0xc8>
  800298:	9abe                	add	s5,s5,a5
  80029a:	7442                	ld	s0,48(sp)
  80029c:	000ac503          	lbu	a0,0(s5)
  8002a0:	70e2                	ld	ra,56(sp)
  8002a2:	6a42                	ld	s4,16(sp)
  8002a4:	6aa2                	ld	s5,8(sp)
  8002a6:	864e                	mv	a2,s3
  8002a8:	85ca                	mv	a1,s2
  8002aa:	69e2                	ld	s3,24(sp)
  8002ac:	7902                	ld	s2,32(sp)
  8002ae:	8326                	mv	t1,s1
  8002b0:	74a2                	ld	s1,40(sp)
  8002b2:	6121                	addi	sp,sp,64
  8002b4:	8302                	jr	t1
  8002b6:	0316d6b3          	divu	a3,a3,a7
  8002ba:	87a2                	mv	a5,s0
  8002bc:	f91ff0ef          	jal	ra,80024c <printnum>
  8002c0:	b7e9                	j	80028a <printnum+0x3e>

00000000008002c2 <sprintputch>:
  8002c2:	499c                	lw	a5,16(a1)
  8002c4:	6198                	ld	a4,0(a1)
  8002c6:	6594                	ld	a3,8(a1)
  8002c8:	2785                	addiw	a5,a5,1
  8002ca:	c99c                	sw	a5,16(a1)
  8002cc:	00d77763          	bleu	a3,a4,8002da <sprintputch+0x18>
  8002d0:	00170793          	addi	a5,a4,1
  8002d4:	e19c                	sd	a5,0(a1)
  8002d6:	00a70023          	sb	a0,0(a4)
  8002da:	8082                	ret

00000000008002dc <vprintfmt>:
  8002dc:	7119                	addi	sp,sp,-128
  8002de:	f4a6                	sd	s1,104(sp)
  8002e0:	f0ca                	sd	s2,96(sp)
  8002e2:	ecce                	sd	s3,88(sp)
  8002e4:	e4d6                	sd	s5,72(sp)
  8002e6:	e0da                	sd	s6,64(sp)
  8002e8:	fc5e                	sd	s7,56(sp)
  8002ea:	f862                	sd	s8,48(sp)
  8002ec:	ec6e                	sd	s11,24(sp)
  8002ee:	fc86                	sd	ra,120(sp)
  8002f0:	f8a2                	sd	s0,112(sp)
  8002f2:	e8d2                	sd	s4,80(sp)
  8002f4:	f466                	sd	s9,40(sp)
  8002f6:	f06a                	sd	s10,32(sp)
  8002f8:	89aa                	mv	s3,a0
  8002fa:	892e                	mv	s2,a1
  8002fc:	84b2                	mv	s1,a2
  8002fe:	8db6                	mv	s11,a3
  800300:	8b3a                	mv	s6,a4
  800302:	5bfd                	li	s7,-1
  800304:	00000a97          	auipc	s5,0x0
  800308:	580a8a93          	addi	s5,s5,1408 # 800884 <main+0xda>
  80030c:	05e00c13          	li	s8,94
  800310:	000dc503          	lbu	a0,0(s11)
  800314:	02500793          	li	a5,37
  800318:	001d8413          	addi	s0,s11,1
  80031c:	00f50f63          	beq	a0,a5,80033a <vprintfmt+0x5e>
  800320:	c529                	beqz	a0,80036a <vprintfmt+0x8e>
  800322:	02500a13          	li	s4,37
  800326:	a011                	j	80032a <vprintfmt+0x4e>
  800328:	c129                	beqz	a0,80036a <vprintfmt+0x8e>
  80032a:	864a                	mv	a2,s2
  80032c:	85a6                	mv	a1,s1
  80032e:	0405                	addi	s0,s0,1
  800330:	9982                	jalr	s3
  800332:	fff44503          	lbu	a0,-1(s0)
  800336:	ff4519e3          	bne	a0,s4,800328 <vprintfmt+0x4c>
  80033a:	00044603          	lbu	a2,0(s0)
  80033e:	02000813          	li	a6,32
  800342:	4a01                	li	s4,0
  800344:	4881                	li	a7,0
  800346:	5d7d                	li	s10,-1
  800348:	5cfd                	li	s9,-1
  80034a:	05500593          	li	a1,85
  80034e:	4525                	li	a0,9
  800350:	fdd6071b          	addiw	a4,a2,-35
  800354:	0ff77713          	andi	a4,a4,255
  800358:	00140d93          	addi	s11,s0,1
  80035c:	22e5e363          	bltu	a1,a4,800582 <vprintfmt+0x2a6>
  800360:	070a                	slli	a4,a4,0x2
  800362:	9756                	add	a4,a4,s5
  800364:	4318                	lw	a4,0(a4)
  800366:	9756                	add	a4,a4,s5
  800368:	8702                	jr	a4
  80036a:	70e6                	ld	ra,120(sp)
  80036c:	7446                	ld	s0,112(sp)
  80036e:	74a6                	ld	s1,104(sp)
  800370:	7906                	ld	s2,96(sp)
  800372:	69e6                	ld	s3,88(sp)
  800374:	6a46                	ld	s4,80(sp)
  800376:	6aa6                	ld	s5,72(sp)
  800378:	6b06                	ld	s6,64(sp)
  80037a:	7be2                	ld	s7,56(sp)
  80037c:	7c42                	ld	s8,48(sp)
  80037e:	7ca2                	ld	s9,40(sp)
  800380:	7d02                	ld	s10,32(sp)
  800382:	6de2                	ld	s11,24(sp)
  800384:	6109                	addi	sp,sp,128
  800386:	8082                	ret
  800388:	4705                	li	a4,1
  80038a:	008b0613          	addi	a2,s6,8
  80038e:	01174463          	blt	a4,a7,800396 <vprintfmt+0xba>
  800392:	28088563          	beqz	a7,80061c <vprintfmt+0x340>
  800396:	000b3683          	ld	a3,0(s6)
  80039a:	4741                	li	a4,16
  80039c:	8b32                	mv	s6,a2
  80039e:	a86d                	j	800458 <vprintfmt+0x17c>
  8003a0:	00144603          	lbu	a2,1(s0)
  8003a4:	4a05                	li	s4,1
  8003a6:	846e                	mv	s0,s11
  8003a8:	b765                	j	800350 <vprintfmt+0x74>
  8003aa:	000b2503          	lw	a0,0(s6)
  8003ae:	864a                	mv	a2,s2
  8003b0:	85a6                	mv	a1,s1
  8003b2:	0b21                	addi	s6,s6,8
  8003b4:	9982                	jalr	s3
  8003b6:	bfa9                	j	800310 <vprintfmt+0x34>
  8003b8:	4705                	li	a4,1
  8003ba:	008b0a13          	addi	s4,s6,8
  8003be:	01174463          	blt	a4,a7,8003c6 <vprintfmt+0xea>
  8003c2:	24088563          	beqz	a7,80060c <vprintfmt+0x330>
  8003c6:	000b3403          	ld	s0,0(s6)
  8003ca:	26044563          	bltz	s0,800634 <vprintfmt+0x358>
  8003ce:	86a2                	mv	a3,s0
  8003d0:	8b52                	mv	s6,s4
  8003d2:	4729                	li	a4,10
  8003d4:	a051                	j	800458 <vprintfmt+0x17c>
  8003d6:	000b2783          	lw	a5,0(s6)
  8003da:	46e1                	li	a3,24
  8003dc:	0b21                	addi	s6,s6,8
  8003de:	41f7d71b          	sraiw	a4,a5,0x1f
  8003e2:	8fb9                	xor	a5,a5,a4
  8003e4:	40e7873b          	subw	a4,a5,a4
  8003e8:	1ce6c163          	blt	a3,a4,8005aa <vprintfmt+0x2ce>
  8003ec:	00371793          	slli	a5,a4,0x3
  8003f0:	00000697          	auipc	a3,0x0
  8003f4:	5f068693          	addi	a3,a3,1520 # 8009e0 <error_string>
  8003f8:	97b6                	add	a5,a5,a3
  8003fa:	639c                	ld	a5,0(a5)
  8003fc:	1a078763          	beqz	a5,8005aa <vprintfmt+0x2ce>
  800400:	873e                	mv	a4,a5
  800402:	00001697          	auipc	a3,0x1
  800406:	8ae68693          	addi	a3,a3,-1874 # 800cb0 <error_string+0x2d0>
  80040a:	8626                	mv	a2,s1
  80040c:	85ca                	mv	a1,s2
  80040e:	854e                	mv	a0,s3
  800410:	25a000ef          	jal	ra,80066a <printfmt>
  800414:	bdf5                	j	800310 <vprintfmt+0x34>
  800416:	00144603          	lbu	a2,1(s0)
  80041a:	2885                	addiw	a7,a7,1
  80041c:	846e                	mv	s0,s11
  80041e:	bf0d                	j	800350 <vprintfmt+0x74>
  800420:	4705                	li	a4,1
  800422:	008b0613          	addi	a2,s6,8
  800426:	01174463          	blt	a4,a7,80042e <vprintfmt+0x152>
  80042a:	1e088e63          	beqz	a7,800626 <vprintfmt+0x34a>
  80042e:	000b3683          	ld	a3,0(s6)
  800432:	4721                	li	a4,8
  800434:	8b32                	mv	s6,a2
  800436:	a00d                	j	800458 <vprintfmt+0x17c>
  800438:	03000513          	li	a0,48
  80043c:	864a                	mv	a2,s2
  80043e:	85a6                	mv	a1,s1
  800440:	e042                	sd	a6,0(sp)
  800442:	9982                	jalr	s3
  800444:	864a                	mv	a2,s2
  800446:	85a6                	mv	a1,s1
  800448:	07800513          	li	a0,120
  80044c:	9982                	jalr	s3
  80044e:	0b21                	addi	s6,s6,8
  800450:	ff8b3683          	ld	a3,-8(s6)
  800454:	6802                	ld	a6,0(sp)
  800456:	4741                	li	a4,16
  800458:	87e6                	mv	a5,s9
  80045a:	8626                	mv	a2,s1
  80045c:	85ca                	mv	a1,s2
  80045e:	854e                	mv	a0,s3
  800460:	dedff0ef          	jal	ra,80024c <printnum>
  800464:	b575                	j	800310 <vprintfmt+0x34>
  800466:	000b3703          	ld	a4,0(s6)
  80046a:	0b21                	addi	s6,s6,8
  80046c:	1e070063          	beqz	a4,80064c <vprintfmt+0x370>
  800470:	00170413          	addi	s0,a4,1
  800474:	19905563          	blez	s9,8005fe <vprintfmt+0x322>
  800478:	02d00613          	li	a2,45
  80047c:	14c81963          	bne	a6,a2,8005ce <vprintfmt+0x2f2>
  800480:	00074703          	lbu	a4,0(a4)
  800484:	0007051b          	sext.w	a0,a4
  800488:	c90d                	beqz	a0,8004ba <vprintfmt+0x1de>
  80048a:	000d4563          	bltz	s10,800494 <vprintfmt+0x1b8>
  80048e:	3d7d                	addiw	s10,s10,-1
  800490:	037d0363          	beq	s10,s7,8004b6 <vprintfmt+0x1da>
  800494:	864a                	mv	a2,s2
  800496:	85a6                	mv	a1,s1
  800498:	180a0c63          	beqz	s4,800630 <vprintfmt+0x354>
  80049c:	3701                	addiw	a4,a4,-32
  80049e:	18ec7963          	bleu	a4,s8,800630 <vprintfmt+0x354>
  8004a2:	03f00513          	li	a0,63
  8004a6:	9982                	jalr	s3
  8004a8:	0405                	addi	s0,s0,1
  8004aa:	fff44703          	lbu	a4,-1(s0)
  8004ae:	3cfd                	addiw	s9,s9,-1
  8004b0:	0007051b          	sext.w	a0,a4
  8004b4:	f979                	bnez	a0,80048a <vprintfmt+0x1ae>
  8004b6:	e5905de3          	blez	s9,800310 <vprintfmt+0x34>
  8004ba:	3cfd                	addiw	s9,s9,-1
  8004bc:	864a                	mv	a2,s2
  8004be:	85a6                	mv	a1,s1
  8004c0:	02000513          	li	a0,32
  8004c4:	9982                	jalr	s3
  8004c6:	e40c85e3          	beqz	s9,800310 <vprintfmt+0x34>
  8004ca:	3cfd                	addiw	s9,s9,-1
  8004cc:	864a                	mv	a2,s2
  8004ce:	85a6                	mv	a1,s1
  8004d0:	02000513          	li	a0,32
  8004d4:	9982                	jalr	s3
  8004d6:	fe0c92e3          	bnez	s9,8004ba <vprintfmt+0x1de>
  8004da:	bd1d                	j	800310 <vprintfmt+0x34>
  8004dc:	4705                	li	a4,1
  8004de:	008b0613          	addi	a2,s6,8
  8004e2:	01174463          	blt	a4,a7,8004ea <vprintfmt+0x20e>
  8004e6:	12088663          	beqz	a7,800612 <vprintfmt+0x336>
  8004ea:	000b3683          	ld	a3,0(s6)
  8004ee:	4729                	li	a4,10
  8004f0:	8b32                	mv	s6,a2
  8004f2:	b79d                	j	800458 <vprintfmt+0x17c>
  8004f4:	00144603          	lbu	a2,1(s0)
  8004f8:	02d00813          	li	a6,45
  8004fc:	846e                	mv	s0,s11
  8004fe:	bd89                	j	800350 <vprintfmt+0x74>
  800500:	864a                	mv	a2,s2
  800502:	85a6                	mv	a1,s1
  800504:	02500513          	li	a0,37
  800508:	9982                	jalr	s3
  80050a:	b519                	j	800310 <vprintfmt+0x34>
  80050c:	000b2d03          	lw	s10,0(s6)
  800510:	00144603          	lbu	a2,1(s0)
  800514:	0b21                	addi	s6,s6,8
  800516:	846e                	mv	s0,s11
  800518:	e20cdce3          	bgez	s9,800350 <vprintfmt+0x74>
  80051c:	8cea                	mv	s9,s10
  80051e:	5d7d                	li	s10,-1
  800520:	bd05                	j	800350 <vprintfmt+0x74>
  800522:	00144603          	lbu	a2,1(s0)
  800526:	03000813          	li	a6,48
  80052a:	846e                	mv	s0,s11
  80052c:	b515                	j	800350 <vprintfmt+0x74>
  80052e:	fd060d1b          	addiw	s10,a2,-48
  800532:	00144603          	lbu	a2,1(s0)
  800536:	846e                	mv	s0,s11
  800538:	fd06071b          	addiw	a4,a2,-48
  80053c:	0006031b          	sext.w	t1,a2
  800540:	fce56ce3          	bltu	a0,a4,800518 <vprintfmt+0x23c>
  800544:	0405                	addi	s0,s0,1
  800546:	002d171b          	slliw	a4,s10,0x2
  80054a:	00044603          	lbu	a2,0(s0)
  80054e:	01a706bb          	addw	a3,a4,s10
  800552:	0016969b          	slliw	a3,a3,0x1
  800556:	006686bb          	addw	a3,a3,t1
  80055a:	fd06071b          	addiw	a4,a2,-48
  80055e:	fd068d1b          	addiw	s10,a3,-48
  800562:	0006031b          	sext.w	t1,a2
  800566:	fce57fe3          	bleu	a4,a0,800544 <vprintfmt+0x268>
  80056a:	b77d                	j	800518 <vprintfmt+0x23c>
  80056c:	fffcc713          	not	a4,s9
  800570:	977d                	srai	a4,a4,0x3f
  800572:	00ecf7b3          	and	a5,s9,a4
  800576:	00144603          	lbu	a2,1(s0)
  80057a:	00078c9b          	sext.w	s9,a5
  80057e:	846e                	mv	s0,s11
  800580:	bbc1                	j	800350 <vprintfmt+0x74>
  800582:	864a                	mv	a2,s2
  800584:	85a6                	mv	a1,s1
  800586:	02500513          	li	a0,37
  80058a:	9982                	jalr	s3
  80058c:	fff44703          	lbu	a4,-1(s0)
  800590:	02500793          	li	a5,37
  800594:	8da2                	mv	s11,s0
  800596:	d6f70de3          	beq	a4,a5,800310 <vprintfmt+0x34>
  80059a:	02500713          	li	a4,37
  80059e:	1dfd                	addi	s11,s11,-1
  8005a0:	fffdc783          	lbu	a5,-1(s11)
  8005a4:	fee79de3          	bne	a5,a4,80059e <vprintfmt+0x2c2>
  8005a8:	b3a5                	j	800310 <vprintfmt+0x34>
  8005aa:	00000697          	auipc	a3,0x0
  8005ae:	6f668693          	addi	a3,a3,1782 # 800ca0 <error_string+0x2c0>
  8005b2:	8626                	mv	a2,s1
  8005b4:	85ca                	mv	a1,s2
  8005b6:	854e                	mv	a0,s3
  8005b8:	0b2000ef          	jal	ra,80066a <printfmt>
  8005bc:	bb91                	j	800310 <vprintfmt+0x34>
  8005be:	00000717          	auipc	a4,0x0
  8005c2:	6da70713          	addi	a4,a4,1754 # 800c98 <error_string+0x2b8>
  8005c6:	00000417          	auipc	s0,0x0
  8005ca:	6d340413          	addi	s0,s0,1747 # 800c99 <error_string+0x2b9>
  8005ce:	853a                	mv	a0,a4
  8005d0:	85ea                	mv	a1,s10
  8005d2:	e03a                	sd	a4,0(sp)
  8005d4:	e442                	sd	a6,8(sp)
  8005d6:	12e000ef          	jal	ra,800704 <strnlen>
  8005da:	40ac8cbb          	subw	s9,s9,a0
  8005de:	6702                	ld	a4,0(sp)
  8005e0:	01905f63          	blez	s9,8005fe <vprintfmt+0x322>
  8005e4:	6822                	ld	a6,8(sp)
  8005e6:	0008079b          	sext.w	a5,a6
  8005ea:	e43e                	sd	a5,8(sp)
  8005ec:	6522                	ld	a0,8(sp)
  8005ee:	864a                	mv	a2,s2
  8005f0:	85a6                	mv	a1,s1
  8005f2:	e03a                	sd	a4,0(sp)
  8005f4:	3cfd                	addiw	s9,s9,-1
  8005f6:	9982                	jalr	s3
  8005f8:	6702                	ld	a4,0(sp)
  8005fa:	fe0c99e3          	bnez	s9,8005ec <vprintfmt+0x310>
  8005fe:	00074703          	lbu	a4,0(a4)
  800602:	0007051b          	sext.w	a0,a4
  800606:	e80512e3          	bnez	a0,80048a <vprintfmt+0x1ae>
  80060a:	b319                	j	800310 <vprintfmt+0x34>
  80060c:	000b2403          	lw	s0,0(s6)
  800610:	bb6d                	j	8003ca <vprintfmt+0xee>
  800612:	000b6683          	lwu	a3,0(s6)
  800616:	4729                	li	a4,10
  800618:	8b32                	mv	s6,a2
  80061a:	bd3d                	j	800458 <vprintfmt+0x17c>
  80061c:	000b6683          	lwu	a3,0(s6)
  800620:	4741                	li	a4,16
  800622:	8b32                	mv	s6,a2
  800624:	bd15                	j	800458 <vprintfmt+0x17c>
  800626:	000b6683          	lwu	a3,0(s6)
  80062a:	4721                	li	a4,8
  80062c:	8b32                	mv	s6,a2
  80062e:	b52d                	j	800458 <vprintfmt+0x17c>
  800630:	9982                	jalr	s3
  800632:	bd9d                	j	8004a8 <vprintfmt+0x1cc>
  800634:	864a                	mv	a2,s2
  800636:	85a6                	mv	a1,s1
  800638:	02d00513          	li	a0,45
  80063c:	e042                	sd	a6,0(sp)
  80063e:	9982                	jalr	s3
  800640:	8b52                	mv	s6,s4
  800642:	408006b3          	neg	a3,s0
  800646:	4729                	li	a4,10
  800648:	6802                	ld	a6,0(sp)
  80064a:	b539                	j	800458 <vprintfmt+0x17c>
  80064c:	01905663          	blez	s9,800658 <vprintfmt+0x37c>
  800650:	02d00713          	li	a4,45
  800654:	f6e815e3          	bne	a6,a4,8005be <vprintfmt+0x2e2>
  800658:	00000417          	auipc	s0,0x0
  80065c:	64140413          	addi	s0,s0,1601 # 800c99 <error_string+0x2b9>
  800660:	02800513          	li	a0,40
  800664:	02800713          	li	a4,40
  800668:	b50d                	j	80048a <vprintfmt+0x1ae>

000000000080066a <printfmt>:
  80066a:	7139                	addi	sp,sp,-64
  80066c:	02010313          	addi	t1,sp,32
  800670:	f03a                	sd	a4,32(sp)
  800672:	871a                	mv	a4,t1
  800674:	ec06                	sd	ra,24(sp)
  800676:	f43e                	sd	a5,40(sp)
  800678:	f842                	sd	a6,48(sp)
  80067a:	fc46                	sd	a7,56(sp)
  80067c:	e41a                	sd	t1,8(sp)
  80067e:	c5fff0ef          	jal	ra,8002dc <vprintfmt>
  800682:	60e2                	ld	ra,24(sp)
  800684:	6121                	addi	sp,sp,64
  800686:	8082                	ret

0000000000800688 <vsnprintf>:
  800688:	15fd                	addi	a1,a1,-1
  80068a:	7179                	addi	sp,sp,-48
  80068c:	95aa                	add	a1,a1,a0
  80068e:	f406                	sd	ra,40(sp)
  800690:	e42a                	sd	a0,8(sp)
  800692:	e82e                	sd	a1,16(sp)
  800694:	cc02                	sw	zero,24(sp)
  800696:	c515                	beqz	a0,8006c2 <vsnprintf+0x3a>
  800698:	02a5e563          	bltu	a1,a0,8006c2 <vsnprintf+0x3a>
  80069c:	75dd                	lui	a1,0xffff7
  80069e:	8736                	mv	a4,a3
  8006a0:	00000517          	auipc	a0,0x0
  8006a4:	c2250513          	addi	a0,a0,-990 # 8002c2 <sprintputch>
  8006a8:	86b2                	mv	a3,a2
  8006aa:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f60f9>
  8006ae:	0030                	addi	a2,sp,8
  8006b0:	c2dff0ef          	jal	ra,8002dc <vprintfmt>
  8006b4:	67a2                	ld	a5,8(sp)
  8006b6:	00078023          	sb	zero,0(a5)
  8006ba:	4562                	lw	a0,24(sp)
  8006bc:	70a2                	ld	ra,40(sp)
  8006be:	6145                	addi	sp,sp,48
  8006c0:	8082                	ret
  8006c2:	5575                	li	a0,-3
  8006c4:	bfe5                	j	8006bc <vsnprintf+0x34>

00000000008006c6 <snprintf>:
  8006c6:	715d                	addi	sp,sp,-80
  8006c8:	02810313          	addi	t1,sp,40
  8006cc:	f436                	sd	a3,40(sp)
  8006ce:	869a                	mv	a3,t1
  8006d0:	ec06                	sd	ra,24(sp)
  8006d2:	f83a                	sd	a4,48(sp)
  8006d4:	fc3e                	sd	a5,56(sp)
  8006d6:	e0c2                	sd	a6,64(sp)
  8006d8:	e4c6                	sd	a7,72(sp)
  8006da:	e41a                	sd	t1,8(sp)
  8006dc:	fadff0ef          	jal	ra,800688 <vsnprintf>
  8006e0:	60e2                	ld	ra,24(sp)
  8006e2:	6161                	addi	sp,sp,80
  8006e4:	8082                	ret

00000000008006e6 <strlen>:
  8006e6:	00054783          	lbu	a5,0(a0)
  8006ea:	cb91                	beqz	a5,8006fe <strlen+0x18>
  8006ec:	4781                	li	a5,0
  8006ee:	0785                	addi	a5,a5,1
  8006f0:	00f50733          	add	a4,a0,a5
  8006f4:	00074703          	lbu	a4,0(a4)
  8006f8:	fb7d                	bnez	a4,8006ee <strlen+0x8>
  8006fa:	853e                	mv	a0,a5
  8006fc:	8082                	ret
  8006fe:	4781                	li	a5,0
  800700:	853e                	mv	a0,a5
  800702:	8082                	ret

0000000000800704 <strnlen>:
  800704:	c185                	beqz	a1,800724 <strnlen+0x20>
  800706:	00054783          	lbu	a5,0(a0)
  80070a:	cf89                	beqz	a5,800724 <strnlen+0x20>
  80070c:	4781                	li	a5,0
  80070e:	a021                	j	800716 <strnlen+0x12>
  800710:	00074703          	lbu	a4,0(a4)
  800714:	c711                	beqz	a4,800720 <strnlen+0x1c>
  800716:	0785                	addi	a5,a5,1
  800718:	00f50733          	add	a4,a0,a5
  80071c:	fef59ae3          	bne	a1,a5,800710 <strnlen+0xc>
  800720:	853e                	mv	a0,a5
  800722:	8082                	ret
  800724:	4781                	li	a5,0
  800726:	853e                	mv	a0,a5
  800728:	8082                	ret

000000000080072a <forktree>:
  80072a:	1141                	addi	sp,sp,-16
  80072c:	e406                	sd	ra,8(sp)
  80072e:	e022                	sd	s0,0(sp)
  800730:	842a                	mv	s0,a0
  800732:	a5bff0ef          	jal	ra,80018c <getpid>
  800736:	8622                	mv	a2,s0
  800738:	85aa                	mv	a1,a0
  80073a:	00000517          	auipc	a0,0x0
  80073e:	58650513          	addi	a0,a0,1414 # 800cc0 <error_string+0x2e0>
  800742:	977ff0ef          	jal	ra,8000b8 <cprintf>
  800746:	8522                	mv	a0,s0
  800748:	03000593          	li	a1,48
  80074c:	014000ef          	jal	ra,800760 <forkchild>
  800750:	8522                	mv	a0,s0
  800752:	6402                	ld	s0,0(sp)
  800754:	60a2                	ld	ra,8(sp)
  800756:	03100593          	li	a1,49
  80075a:	0141                	addi	sp,sp,16
  80075c:	0040006f          	j	800760 <forkchild>

0000000000800760 <forkchild>:
  800760:	7179                	addi	sp,sp,-48
  800762:	f022                	sd	s0,32(sp)
  800764:	ec26                	sd	s1,24(sp)
  800766:	f406                	sd	ra,40(sp)
  800768:	842a                	mv	s0,a0
  80076a:	84ae                	mv	s1,a1
  80076c:	f7bff0ef          	jal	ra,8006e6 <strlen>
  800770:	478d                	li	a5,3
  800772:	00a7f763          	bleu	a0,a5,800780 <forkchild+0x20>
  800776:	70a2                	ld	ra,40(sp)
  800778:	7402                	ld	s0,32(sp)
  80077a:	64e2                	ld	s1,24(sp)
  80077c:	6145                	addi	sp,sp,48
  80077e:	8082                	ret
  800780:	8726                	mv	a4,s1
  800782:	86a2                	mv	a3,s0
  800784:	00000617          	auipc	a2,0x0
  800788:	53460613          	addi	a2,a2,1332 # 800cb8 <error_string+0x2d8>
  80078c:	4595                	li	a1,5
  80078e:	0028                	addi	a0,sp,8
  800790:	f37ff0ef          	jal	ra,8006c6 <snprintf>
  800794:	9f1ff0ef          	jal	ra,800184 <fork>
  800798:	fd79                	bnez	a0,800776 <forkchild+0x16>
  80079a:	0028                	addi	a0,sp,8
  80079c:	f8fff0ef          	jal	ra,80072a <forktree>
  8007a0:	9e9ff0ef          	jal	ra,800188 <yield>
  8007a4:	4501                	li	a0,0
  8007a6:	9c9ff0ef          	jal	ra,80016e <exit>

00000000008007aa <main>:
  8007aa:	1141                	addi	sp,sp,-16
  8007ac:	00000517          	auipc	a0,0x0
  8007b0:	52450513          	addi	a0,a0,1316 # 800cd0 <error_string+0x2f0>
  8007b4:	e406                	sd	ra,8(sp)
  8007b6:	f75ff0ef          	jal	ra,80072a <forktree>
  8007ba:	60a2                	ld	ra,8(sp)
  8007bc:	4501                	li	a0,0
  8007be:	0141                	addi	sp,sp,16
  8007c0:	8082                	ret
