
obj/__user_pgdir.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1220006f          	j	800146 <sys_open>

0000000000800028 <close>:
  800028:	12a0006f          	j	800152 <sys_close>

000000000080002c <dup2>:
  80002c:	1300006f          	j	80015c <sys_dup>

0000000000800030 <_start>:
  800030:	19a000ef          	jal	ra,8001ca <umain>
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
  800048:	69450513          	addi	a0,a0,1684 # 8006d8 <main+0x4e>
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
  800068:	6cc50513          	addi	a0,a0,1740 # 800730 <main+0xa6>
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
  800080:	0b8000ef          	jal	ra,800138 <sys_putc>
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
  8000a4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6209>
  8000a8:	ec06                	sd	ra,24(sp)
  8000aa:	c602                	sw	zero,12(sp)
  8000ac:	20c000ef          	jal	ra,8002b8 <vprintfmt>
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
  8000d6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6209>
  8000da:	ec06                	sd	ra,24(sp)
  8000dc:	e4be                	sd	a5,72(sp)
  8000de:	e8c2                	sd	a6,80(sp)
  8000e0:	ecc6                	sd	a7,88(sp)
  8000e2:	e41a                	sd	t1,8(sp)
  8000e4:	c202                	sw	zero,4(sp)
  8000e6:	1d2000ef          	jal	ra,8002b8 <vprintfmt>
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

0000000000800132 <sys_getpid>:
  800132:	4549                	li	a0,18
  800134:	fbfff06f          	j	8000f2 <syscall>

0000000000800138 <sys_putc>:
  800138:	85aa                	mv	a1,a0
  80013a:	4579                	li	a0,30
  80013c:	fb7ff06f          	j	8000f2 <syscall>

0000000000800140 <sys_pgdir>:
  800140:	457d                	li	a0,31
  800142:	fb1ff06f          	j	8000f2 <syscall>

0000000000800146 <sys_open>:
  800146:	862e                	mv	a2,a1
  800148:	85aa                	mv	a1,a0
  80014a:	06400513          	li	a0,100
  80014e:	fa5ff06f          	j	8000f2 <syscall>

0000000000800152 <sys_close>:
  800152:	85aa                	mv	a1,a0
  800154:	06500513          	li	a0,101
  800158:	f9bff06f          	j	8000f2 <syscall>

000000000080015c <sys_dup>:
  80015c:	862e                	mv	a2,a1
  80015e:	85aa                	mv	a1,a0
  800160:	08200513          	li	a0,130
  800164:	f8fff06f          	j	8000f2 <syscall>

0000000000800168 <exit>:
  800168:	1141                	addi	sp,sp,-16
  80016a:	e406                	sd	ra,8(sp)
  80016c:	fbfff0ef          	jal	ra,80012a <sys_exit>
  800170:	00000517          	auipc	a0,0x0
  800174:	58850513          	addi	a0,a0,1416 # 8006f8 <main+0x6e>
  800178:	f41ff0ef          	jal	ra,8000b8 <cprintf>
  80017c:	a001                	j	80017c <exit+0x14>

000000000080017e <getpid>:
  80017e:	fb5ff06f          	j	800132 <sys_getpid>

0000000000800182 <print_pgdir>:
  800182:	fbfff06f          	j	800140 <sys_pgdir>

0000000000800186 <initfd>:
  800186:	1101                	addi	sp,sp,-32
  800188:	87ae                	mv	a5,a1
  80018a:	e426                	sd	s1,8(sp)
  80018c:	85b2                	mv	a1,a2
  80018e:	84aa                	mv	s1,a0
  800190:	853e                	mv	a0,a5
  800192:	e822                	sd	s0,16(sp)
  800194:	ec06                	sd	ra,24(sp)
  800196:	e8bff0ef          	jal	ra,800020 <open>
  80019a:	842a                	mv	s0,a0
  80019c:	00054463          	bltz	a0,8001a4 <initfd+0x1e>
  8001a0:	00951863          	bne	a0,s1,8001b0 <initfd+0x2a>
  8001a4:	8522                	mv	a0,s0
  8001a6:	60e2                	ld	ra,24(sp)
  8001a8:	6442                	ld	s0,16(sp)
  8001aa:	64a2                	ld	s1,8(sp)
  8001ac:	6105                	addi	sp,sp,32
  8001ae:	8082                	ret
  8001b0:	8526                	mv	a0,s1
  8001b2:	e77ff0ef          	jal	ra,800028 <close>
  8001b6:	85a6                	mv	a1,s1
  8001b8:	8522                	mv	a0,s0
  8001ba:	e73ff0ef          	jal	ra,80002c <dup2>
  8001be:	84aa                	mv	s1,a0
  8001c0:	8522                	mv	a0,s0
  8001c2:	e67ff0ef          	jal	ra,800028 <close>
  8001c6:	8426                	mv	s0,s1
  8001c8:	bff1                	j	8001a4 <initfd+0x1e>

00000000008001ca <umain>:
  8001ca:	1101                	addi	sp,sp,-32
  8001cc:	e822                	sd	s0,16(sp)
  8001ce:	e426                	sd	s1,8(sp)
  8001d0:	842a                	mv	s0,a0
  8001d2:	84ae                	mv	s1,a1
  8001d4:	4601                	li	a2,0
  8001d6:	00000597          	auipc	a1,0x0
  8001da:	53a58593          	addi	a1,a1,1338 # 800710 <main+0x86>
  8001de:	4501                	li	a0,0
  8001e0:	ec06                	sd	ra,24(sp)
  8001e2:	fa5ff0ef          	jal	ra,800186 <initfd>
  8001e6:	02054263          	bltz	a0,80020a <umain+0x40>
  8001ea:	4605                	li	a2,1
  8001ec:	00000597          	auipc	a1,0x0
  8001f0:	56458593          	addi	a1,a1,1380 # 800750 <main+0xc6>
  8001f4:	4505                	li	a0,1
  8001f6:	f91ff0ef          	jal	ra,800186 <initfd>
  8001fa:	02054663          	bltz	a0,800226 <umain+0x5c>
  8001fe:	85a6                	mv	a1,s1
  800200:	8522                	mv	a0,s0
  800202:	488000ef          	jal	ra,80068a <main>
  800206:	f63ff0ef          	jal	ra,800168 <exit>
  80020a:	86aa                	mv	a3,a0
  80020c:	00000617          	auipc	a2,0x0
  800210:	50c60613          	addi	a2,a2,1292 # 800718 <main+0x8e>
  800214:	02000593          	li	a1,32
  800218:	00000517          	auipc	a0,0x0
  80021c:	52050513          	addi	a0,a0,1312 # 800738 <main+0xae>
  800220:	e17ff0ef          	jal	ra,800036 <__warn>
  800224:	b7d9                	j	8001ea <umain+0x20>
  800226:	86aa                	mv	a3,a0
  800228:	00000617          	auipc	a2,0x0
  80022c:	53060613          	addi	a2,a2,1328 # 800758 <main+0xce>
  800230:	02500593          	li	a1,37
  800234:	00000517          	auipc	a0,0x0
  800238:	50450513          	addi	a0,a0,1284 # 800738 <main+0xae>
  80023c:	dfbff0ef          	jal	ra,800036 <__warn>
  800240:	bf7d                	j	8001fe <umain+0x34>

0000000000800242 <printnum>:
  800242:	02071893          	slli	a7,a4,0x20
  800246:	7139                	addi	sp,sp,-64
  800248:	0208d893          	srli	a7,a7,0x20
  80024c:	e456                	sd	s5,8(sp)
  80024e:	0316fab3          	remu	s5,a3,a7
  800252:	f822                	sd	s0,48(sp)
  800254:	f426                	sd	s1,40(sp)
  800256:	f04a                	sd	s2,32(sp)
  800258:	ec4e                	sd	s3,24(sp)
  80025a:	fc06                	sd	ra,56(sp)
  80025c:	e852                	sd	s4,16(sp)
  80025e:	84aa                	mv	s1,a0
  800260:	89ae                	mv	s3,a1
  800262:	8932                	mv	s2,a2
  800264:	fff7841b          	addiw	s0,a5,-1
  800268:	2a81                	sext.w	s5,s5
  80026a:	0516f163          	bleu	a7,a3,8002ac <printnum+0x6a>
  80026e:	8a42                	mv	s4,a6
  800270:	00805863          	blez	s0,800280 <printnum+0x3e>
  800274:	347d                	addiw	s0,s0,-1
  800276:	864e                	mv	a2,s3
  800278:	85ca                	mv	a1,s2
  80027a:	8552                	mv	a0,s4
  80027c:	9482                	jalr	s1
  80027e:	f87d                	bnez	s0,800274 <printnum+0x32>
  800280:	1a82                	slli	s5,s5,0x20
  800282:	020ada93          	srli	s5,s5,0x20
  800286:	00000797          	auipc	a5,0x0
  80028a:	71278793          	addi	a5,a5,1810 # 800998 <error_string+0xc8>
  80028e:	9abe                	add	s5,s5,a5
  800290:	7442                	ld	s0,48(sp)
  800292:	000ac503          	lbu	a0,0(s5)
  800296:	70e2                	ld	ra,56(sp)
  800298:	6a42                	ld	s4,16(sp)
  80029a:	6aa2                	ld	s5,8(sp)
  80029c:	864e                	mv	a2,s3
  80029e:	85ca                	mv	a1,s2
  8002a0:	69e2                	ld	s3,24(sp)
  8002a2:	7902                	ld	s2,32(sp)
  8002a4:	8326                	mv	t1,s1
  8002a6:	74a2                	ld	s1,40(sp)
  8002a8:	6121                	addi	sp,sp,64
  8002aa:	8302                	jr	t1
  8002ac:	0316d6b3          	divu	a3,a3,a7
  8002b0:	87a2                	mv	a5,s0
  8002b2:	f91ff0ef          	jal	ra,800242 <printnum>
  8002b6:	b7e9                	j	800280 <printnum+0x3e>

00000000008002b8 <vprintfmt>:
  8002b8:	7119                	addi	sp,sp,-128
  8002ba:	f4a6                	sd	s1,104(sp)
  8002bc:	f0ca                	sd	s2,96(sp)
  8002be:	ecce                	sd	s3,88(sp)
  8002c0:	e4d6                	sd	s5,72(sp)
  8002c2:	e0da                	sd	s6,64(sp)
  8002c4:	fc5e                	sd	s7,56(sp)
  8002c6:	f862                	sd	s8,48(sp)
  8002c8:	ec6e                	sd	s11,24(sp)
  8002ca:	fc86                	sd	ra,120(sp)
  8002cc:	f8a2                	sd	s0,112(sp)
  8002ce:	e8d2                	sd	s4,80(sp)
  8002d0:	f466                	sd	s9,40(sp)
  8002d2:	f06a                	sd	s10,32(sp)
  8002d4:	89aa                	mv	s3,a0
  8002d6:	892e                	mv	s2,a1
  8002d8:	84b2                	mv	s1,a2
  8002da:	8db6                	mv	s11,a3
  8002dc:	8b3a                	mv	s6,a4
  8002de:	5bfd                	li	s7,-1
  8002e0:	00000a97          	auipc	s5,0x0
  8002e4:	494a8a93          	addi	s5,s5,1172 # 800774 <main+0xea>
  8002e8:	05e00c13          	li	s8,94
  8002ec:	000dc503          	lbu	a0,0(s11)
  8002f0:	02500793          	li	a5,37
  8002f4:	001d8413          	addi	s0,s11,1
  8002f8:	00f50f63          	beq	a0,a5,800316 <vprintfmt+0x5e>
  8002fc:	c529                	beqz	a0,800346 <vprintfmt+0x8e>
  8002fe:	02500a13          	li	s4,37
  800302:	a011                	j	800306 <vprintfmt+0x4e>
  800304:	c129                	beqz	a0,800346 <vprintfmt+0x8e>
  800306:	864a                	mv	a2,s2
  800308:	85a6                	mv	a1,s1
  80030a:	0405                	addi	s0,s0,1
  80030c:	9982                	jalr	s3
  80030e:	fff44503          	lbu	a0,-1(s0)
  800312:	ff4519e3          	bne	a0,s4,800304 <vprintfmt+0x4c>
  800316:	00044603          	lbu	a2,0(s0)
  80031a:	02000813          	li	a6,32
  80031e:	4a01                	li	s4,0
  800320:	4881                	li	a7,0
  800322:	5d7d                	li	s10,-1
  800324:	5cfd                	li	s9,-1
  800326:	05500593          	li	a1,85
  80032a:	4525                	li	a0,9
  80032c:	fdd6071b          	addiw	a4,a2,-35
  800330:	0ff77713          	andi	a4,a4,255
  800334:	00140d93          	addi	s11,s0,1
  800338:	22e5e363          	bltu	a1,a4,80055e <vprintfmt+0x2a6>
  80033c:	070a                	slli	a4,a4,0x2
  80033e:	9756                	add	a4,a4,s5
  800340:	4318                	lw	a4,0(a4)
  800342:	9756                	add	a4,a4,s5
  800344:	8702                	jr	a4
  800346:	70e6                	ld	ra,120(sp)
  800348:	7446                	ld	s0,112(sp)
  80034a:	74a6                	ld	s1,104(sp)
  80034c:	7906                	ld	s2,96(sp)
  80034e:	69e6                	ld	s3,88(sp)
  800350:	6a46                	ld	s4,80(sp)
  800352:	6aa6                	ld	s5,72(sp)
  800354:	6b06                	ld	s6,64(sp)
  800356:	7be2                	ld	s7,56(sp)
  800358:	7c42                	ld	s8,48(sp)
  80035a:	7ca2                	ld	s9,40(sp)
  80035c:	7d02                	ld	s10,32(sp)
  80035e:	6de2                	ld	s11,24(sp)
  800360:	6109                	addi	sp,sp,128
  800362:	8082                	ret
  800364:	4705                	li	a4,1
  800366:	008b0613          	addi	a2,s6,8
  80036a:	01174463          	blt	a4,a7,800372 <vprintfmt+0xba>
  80036e:	28088563          	beqz	a7,8005f8 <vprintfmt+0x340>
  800372:	000b3683          	ld	a3,0(s6)
  800376:	4741                	li	a4,16
  800378:	8b32                	mv	s6,a2
  80037a:	a86d                	j	800434 <vprintfmt+0x17c>
  80037c:	00144603          	lbu	a2,1(s0)
  800380:	4a05                	li	s4,1
  800382:	846e                	mv	s0,s11
  800384:	b765                	j	80032c <vprintfmt+0x74>
  800386:	000b2503          	lw	a0,0(s6)
  80038a:	864a                	mv	a2,s2
  80038c:	85a6                	mv	a1,s1
  80038e:	0b21                	addi	s6,s6,8
  800390:	9982                	jalr	s3
  800392:	bfa9                	j	8002ec <vprintfmt+0x34>
  800394:	4705                	li	a4,1
  800396:	008b0a13          	addi	s4,s6,8
  80039a:	01174463          	blt	a4,a7,8003a2 <vprintfmt+0xea>
  80039e:	24088563          	beqz	a7,8005e8 <vprintfmt+0x330>
  8003a2:	000b3403          	ld	s0,0(s6)
  8003a6:	26044563          	bltz	s0,800610 <vprintfmt+0x358>
  8003aa:	86a2                	mv	a3,s0
  8003ac:	8b52                	mv	s6,s4
  8003ae:	4729                	li	a4,10
  8003b0:	a051                	j	800434 <vprintfmt+0x17c>
  8003b2:	000b2783          	lw	a5,0(s6)
  8003b6:	46e1                	li	a3,24
  8003b8:	0b21                	addi	s6,s6,8
  8003ba:	41f7d71b          	sraiw	a4,a5,0x1f
  8003be:	8fb9                	xor	a5,a5,a4
  8003c0:	40e7873b          	subw	a4,a5,a4
  8003c4:	1ce6c163          	blt	a3,a4,800586 <vprintfmt+0x2ce>
  8003c8:	00371793          	slli	a5,a4,0x3
  8003cc:	00000697          	auipc	a3,0x0
  8003d0:	50468693          	addi	a3,a3,1284 # 8008d0 <error_string>
  8003d4:	97b6                	add	a5,a5,a3
  8003d6:	639c                	ld	a5,0(a5)
  8003d8:	1a078763          	beqz	a5,800586 <vprintfmt+0x2ce>
  8003dc:	873e                	mv	a4,a5
  8003de:	00000697          	auipc	a3,0x0
  8003e2:	7c268693          	addi	a3,a3,1986 # 800ba0 <error_string+0x2d0>
  8003e6:	8626                	mv	a2,s1
  8003e8:	85ca                	mv	a1,s2
  8003ea:	854e                	mv	a0,s3
  8003ec:	25a000ef          	jal	ra,800646 <printfmt>
  8003f0:	bdf5                	j	8002ec <vprintfmt+0x34>
  8003f2:	00144603          	lbu	a2,1(s0)
  8003f6:	2885                	addiw	a7,a7,1
  8003f8:	846e                	mv	s0,s11
  8003fa:	bf0d                	j	80032c <vprintfmt+0x74>
  8003fc:	4705                	li	a4,1
  8003fe:	008b0613          	addi	a2,s6,8
  800402:	01174463          	blt	a4,a7,80040a <vprintfmt+0x152>
  800406:	1e088e63          	beqz	a7,800602 <vprintfmt+0x34a>
  80040a:	000b3683          	ld	a3,0(s6)
  80040e:	4721                	li	a4,8
  800410:	8b32                	mv	s6,a2
  800412:	a00d                	j	800434 <vprintfmt+0x17c>
  800414:	03000513          	li	a0,48
  800418:	864a                	mv	a2,s2
  80041a:	85a6                	mv	a1,s1
  80041c:	e042                	sd	a6,0(sp)
  80041e:	9982                	jalr	s3
  800420:	864a                	mv	a2,s2
  800422:	85a6                	mv	a1,s1
  800424:	07800513          	li	a0,120
  800428:	9982                	jalr	s3
  80042a:	0b21                	addi	s6,s6,8
  80042c:	ff8b3683          	ld	a3,-8(s6)
  800430:	6802                	ld	a6,0(sp)
  800432:	4741                	li	a4,16
  800434:	87e6                	mv	a5,s9
  800436:	8626                	mv	a2,s1
  800438:	85ca                	mv	a1,s2
  80043a:	854e                	mv	a0,s3
  80043c:	e07ff0ef          	jal	ra,800242 <printnum>
  800440:	b575                	j	8002ec <vprintfmt+0x34>
  800442:	000b3703          	ld	a4,0(s6)
  800446:	0b21                	addi	s6,s6,8
  800448:	1e070063          	beqz	a4,800628 <vprintfmt+0x370>
  80044c:	00170413          	addi	s0,a4,1
  800450:	19905563          	blez	s9,8005da <vprintfmt+0x322>
  800454:	02d00613          	li	a2,45
  800458:	14c81963          	bne	a6,a2,8005aa <vprintfmt+0x2f2>
  80045c:	00074703          	lbu	a4,0(a4)
  800460:	0007051b          	sext.w	a0,a4
  800464:	c90d                	beqz	a0,800496 <vprintfmt+0x1de>
  800466:	000d4563          	bltz	s10,800470 <vprintfmt+0x1b8>
  80046a:	3d7d                	addiw	s10,s10,-1
  80046c:	037d0363          	beq	s10,s7,800492 <vprintfmt+0x1da>
  800470:	864a                	mv	a2,s2
  800472:	85a6                	mv	a1,s1
  800474:	180a0c63          	beqz	s4,80060c <vprintfmt+0x354>
  800478:	3701                	addiw	a4,a4,-32
  80047a:	18ec7963          	bleu	a4,s8,80060c <vprintfmt+0x354>
  80047e:	03f00513          	li	a0,63
  800482:	9982                	jalr	s3
  800484:	0405                	addi	s0,s0,1
  800486:	fff44703          	lbu	a4,-1(s0)
  80048a:	3cfd                	addiw	s9,s9,-1
  80048c:	0007051b          	sext.w	a0,a4
  800490:	f979                	bnez	a0,800466 <vprintfmt+0x1ae>
  800492:	e5905de3          	blez	s9,8002ec <vprintfmt+0x34>
  800496:	3cfd                	addiw	s9,s9,-1
  800498:	864a                	mv	a2,s2
  80049a:	85a6                	mv	a1,s1
  80049c:	02000513          	li	a0,32
  8004a0:	9982                	jalr	s3
  8004a2:	e40c85e3          	beqz	s9,8002ec <vprintfmt+0x34>
  8004a6:	3cfd                	addiw	s9,s9,-1
  8004a8:	864a                	mv	a2,s2
  8004aa:	85a6                	mv	a1,s1
  8004ac:	02000513          	li	a0,32
  8004b0:	9982                	jalr	s3
  8004b2:	fe0c92e3          	bnez	s9,800496 <vprintfmt+0x1de>
  8004b6:	bd1d                	j	8002ec <vprintfmt+0x34>
  8004b8:	4705                	li	a4,1
  8004ba:	008b0613          	addi	a2,s6,8
  8004be:	01174463          	blt	a4,a7,8004c6 <vprintfmt+0x20e>
  8004c2:	12088663          	beqz	a7,8005ee <vprintfmt+0x336>
  8004c6:	000b3683          	ld	a3,0(s6)
  8004ca:	4729                	li	a4,10
  8004cc:	8b32                	mv	s6,a2
  8004ce:	b79d                	j	800434 <vprintfmt+0x17c>
  8004d0:	00144603          	lbu	a2,1(s0)
  8004d4:	02d00813          	li	a6,45
  8004d8:	846e                	mv	s0,s11
  8004da:	bd89                	j	80032c <vprintfmt+0x74>
  8004dc:	864a                	mv	a2,s2
  8004de:	85a6                	mv	a1,s1
  8004e0:	02500513          	li	a0,37
  8004e4:	9982                	jalr	s3
  8004e6:	b519                	j	8002ec <vprintfmt+0x34>
  8004e8:	000b2d03          	lw	s10,0(s6)
  8004ec:	00144603          	lbu	a2,1(s0)
  8004f0:	0b21                	addi	s6,s6,8
  8004f2:	846e                	mv	s0,s11
  8004f4:	e20cdce3          	bgez	s9,80032c <vprintfmt+0x74>
  8004f8:	8cea                	mv	s9,s10
  8004fa:	5d7d                	li	s10,-1
  8004fc:	bd05                	j	80032c <vprintfmt+0x74>
  8004fe:	00144603          	lbu	a2,1(s0)
  800502:	03000813          	li	a6,48
  800506:	846e                	mv	s0,s11
  800508:	b515                	j	80032c <vprintfmt+0x74>
  80050a:	fd060d1b          	addiw	s10,a2,-48
  80050e:	00144603          	lbu	a2,1(s0)
  800512:	846e                	mv	s0,s11
  800514:	fd06071b          	addiw	a4,a2,-48
  800518:	0006031b          	sext.w	t1,a2
  80051c:	fce56ce3          	bltu	a0,a4,8004f4 <vprintfmt+0x23c>
  800520:	0405                	addi	s0,s0,1
  800522:	002d171b          	slliw	a4,s10,0x2
  800526:	00044603          	lbu	a2,0(s0)
  80052a:	01a706bb          	addw	a3,a4,s10
  80052e:	0016969b          	slliw	a3,a3,0x1
  800532:	006686bb          	addw	a3,a3,t1
  800536:	fd06071b          	addiw	a4,a2,-48
  80053a:	fd068d1b          	addiw	s10,a3,-48
  80053e:	0006031b          	sext.w	t1,a2
  800542:	fce57fe3          	bleu	a4,a0,800520 <vprintfmt+0x268>
  800546:	b77d                	j	8004f4 <vprintfmt+0x23c>
  800548:	fffcc713          	not	a4,s9
  80054c:	977d                	srai	a4,a4,0x3f
  80054e:	00ecf7b3          	and	a5,s9,a4
  800552:	00144603          	lbu	a2,1(s0)
  800556:	00078c9b          	sext.w	s9,a5
  80055a:	846e                	mv	s0,s11
  80055c:	bbc1                	j	80032c <vprintfmt+0x74>
  80055e:	864a                	mv	a2,s2
  800560:	85a6                	mv	a1,s1
  800562:	02500513          	li	a0,37
  800566:	9982                	jalr	s3
  800568:	fff44703          	lbu	a4,-1(s0)
  80056c:	02500793          	li	a5,37
  800570:	8da2                	mv	s11,s0
  800572:	d6f70de3          	beq	a4,a5,8002ec <vprintfmt+0x34>
  800576:	02500713          	li	a4,37
  80057a:	1dfd                	addi	s11,s11,-1
  80057c:	fffdc783          	lbu	a5,-1(s11)
  800580:	fee79de3          	bne	a5,a4,80057a <vprintfmt+0x2c2>
  800584:	b3a5                	j	8002ec <vprintfmt+0x34>
  800586:	00000697          	auipc	a3,0x0
  80058a:	60a68693          	addi	a3,a3,1546 # 800b90 <error_string+0x2c0>
  80058e:	8626                	mv	a2,s1
  800590:	85ca                	mv	a1,s2
  800592:	854e                	mv	a0,s3
  800594:	0b2000ef          	jal	ra,800646 <printfmt>
  800598:	bb91                	j	8002ec <vprintfmt+0x34>
  80059a:	00000717          	auipc	a4,0x0
  80059e:	5ee70713          	addi	a4,a4,1518 # 800b88 <error_string+0x2b8>
  8005a2:	00000417          	auipc	s0,0x0
  8005a6:	5e740413          	addi	s0,s0,1511 # 800b89 <error_string+0x2b9>
  8005aa:	853a                	mv	a0,a4
  8005ac:	85ea                	mv	a1,s10
  8005ae:	e03a                	sd	a4,0(sp)
  8005b0:	e442                	sd	a6,8(sp)
  8005b2:	0b2000ef          	jal	ra,800664 <strnlen>
  8005b6:	40ac8cbb          	subw	s9,s9,a0
  8005ba:	6702                	ld	a4,0(sp)
  8005bc:	01905f63          	blez	s9,8005da <vprintfmt+0x322>
  8005c0:	6822                	ld	a6,8(sp)
  8005c2:	0008079b          	sext.w	a5,a6
  8005c6:	e43e                	sd	a5,8(sp)
  8005c8:	6522                	ld	a0,8(sp)
  8005ca:	864a                	mv	a2,s2
  8005cc:	85a6                	mv	a1,s1
  8005ce:	e03a                	sd	a4,0(sp)
  8005d0:	3cfd                	addiw	s9,s9,-1
  8005d2:	9982                	jalr	s3
  8005d4:	6702                	ld	a4,0(sp)
  8005d6:	fe0c99e3          	bnez	s9,8005c8 <vprintfmt+0x310>
  8005da:	00074703          	lbu	a4,0(a4)
  8005de:	0007051b          	sext.w	a0,a4
  8005e2:	e80512e3          	bnez	a0,800466 <vprintfmt+0x1ae>
  8005e6:	b319                	j	8002ec <vprintfmt+0x34>
  8005e8:	000b2403          	lw	s0,0(s6)
  8005ec:	bb6d                	j	8003a6 <vprintfmt+0xee>
  8005ee:	000b6683          	lwu	a3,0(s6)
  8005f2:	4729                	li	a4,10
  8005f4:	8b32                	mv	s6,a2
  8005f6:	bd3d                	j	800434 <vprintfmt+0x17c>
  8005f8:	000b6683          	lwu	a3,0(s6)
  8005fc:	4741                	li	a4,16
  8005fe:	8b32                	mv	s6,a2
  800600:	bd15                	j	800434 <vprintfmt+0x17c>
  800602:	000b6683          	lwu	a3,0(s6)
  800606:	4721                	li	a4,8
  800608:	8b32                	mv	s6,a2
  80060a:	b52d                	j	800434 <vprintfmt+0x17c>
  80060c:	9982                	jalr	s3
  80060e:	bd9d                	j	800484 <vprintfmt+0x1cc>
  800610:	864a                	mv	a2,s2
  800612:	85a6                	mv	a1,s1
  800614:	02d00513          	li	a0,45
  800618:	e042                	sd	a6,0(sp)
  80061a:	9982                	jalr	s3
  80061c:	8b52                	mv	s6,s4
  80061e:	408006b3          	neg	a3,s0
  800622:	4729                	li	a4,10
  800624:	6802                	ld	a6,0(sp)
  800626:	b539                	j	800434 <vprintfmt+0x17c>
  800628:	01905663          	blez	s9,800634 <vprintfmt+0x37c>
  80062c:	02d00713          	li	a4,45
  800630:	f6e815e3          	bne	a6,a4,80059a <vprintfmt+0x2e2>
  800634:	00000417          	auipc	s0,0x0
  800638:	55540413          	addi	s0,s0,1365 # 800b89 <error_string+0x2b9>
  80063c:	02800513          	li	a0,40
  800640:	02800713          	li	a4,40
  800644:	b50d                	j	800466 <vprintfmt+0x1ae>

0000000000800646 <printfmt>:
  800646:	7139                	addi	sp,sp,-64
  800648:	02010313          	addi	t1,sp,32
  80064c:	f03a                	sd	a4,32(sp)
  80064e:	871a                	mv	a4,t1
  800650:	ec06                	sd	ra,24(sp)
  800652:	f43e                	sd	a5,40(sp)
  800654:	f842                	sd	a6,48(sp)
  800656:	fc46                	sd	a7,56(sp)
  800658:	e41a                	sd	t1,8(sp)
  80065a:	c5fff0ef          	jal	ra,8002b8 <vprintfmt>
  80065e:	60e2                	ld	ra,24(sp)
  800660:	6121                	addi	sp,sp,64
  800662:	8082                	ret

0000000000800664 <strnlen>:
  800664:	c185                	beqz	a1,800684 <strnlen+0x20>
  800666:	00054783          	lbu	a5,0(a0)
  80066a:	cf89                	beqz	a5,800684 <strnlen+0x20>
  80066c:	4781                	li	a5,0
  80066e:	a021                	j	800676 <strnlen+0x12>
  800670:	00074703          	lbu	a4,0(a4)
  800674:	c711                	beqz	a4,800680 <strnlen+0x1c>
  800676:	0785                	addi	a5,a5,1
  800678:	00f50733          	add	a4,a0,a5
  80067c:	fef59ae3          	bne	a1,a5,800670 <strnlen+0xc>
  800680:	853e                	mv	a0,a5
  800682:	8082                	ret
  800684:	4781                	li	a5,0
  800686:	853e                	mv	a0,a5
  800688:	8082                	ret

000000000080068a <main>:
  80068a:	1141                	addi	sp,sp,-16
  80068c:	e406                	sd	ra,8(sp)
  80068e:	af1ff0ef          	jal	ra,80017e <getpid>
  800692:	85aa                	mv	a1,a0
  800694:	00000517          	auipc	a0,0x0
  800698:	51450513          	addi	a0,a0,1300 # 800ba8 <error_string+0x2d8>
  80069c:	a1dff0ef          	jal	ra,8000b8 <cprintf>
  8006a0:	ae3ff0ef          	jal	ra,800182 <print_pgdir>
  8006a4:	00000517          	auipc	a0,0x0
  8006a8:	51c50513          	addi	a0,a0,1308 # 800bc0 <error_string+0x2f0>
  8006ac:	a0dff0ef          	jal	ra,8000b8 <cprintf>
  8006b0:	60a2                	ld	ra,8(sp)
  8006b2:	4501                	li	a0,0
  8006b4:	0141                	addi	sp,sp,16
  8006b6:	8082                	ret
