
obj/__user_sleep.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1740006f          	j	800198 <sys_open>

0000000000800028 <close>:
  800028:	17c0006f          	j	8001a4 <sys_close>

000000000080002c <dup2>:
  80002c:	1820006f          	j	8001ae <sys_dup>

0000000000800030 <_start>:
  800030:	1f8000ef          	jal	ra,800228 <umain>
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
  800048:	74c50513          	addi	a0,a0,1868 # 800790 <main+0x72>
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
  800064:	00000517          	auipc	a0,0x0
  800068:	7a450513          	addi	a0,a0,1956 # 800808 <main+0xea>
  80006c:	08c000ef          	jal	ra,8000f8 <cprintf>
  800070:	5559                	li	a0,-10
  800072:	148000ef          	jal	ra,8001ba <exit>

0000000000800076 <__warn>:
  800076:	715d                	addi	sp,sp,-80
  800078:	e822                	sd	s0,16(sp)
  80007a:	fc3e                	sd	a5,56(sp)
  80007c:	8432                	mv	s0,a2
  80007e:	103c                	addi	a5,sp,40
  800080:	862e                	mv	a2,a1
  800082:	85aa                	mv	a1,a0
  800084:	00000517          	auipc	a0,0x0
  800088:	72c50513          	addi	a0,a0,1836 # 8007b0 <main+0x92>
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
  8000a8:	76450513          	addi	a0,a0,1892 # 800808 <main+0xea>
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
  8000c0:	0c2000ef          	jal	ra,800182 <sys_putc>
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
  8000e4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6131>
  8000e8:	ec06                	sd	ra,24(sp)
  8000ea:	c602                	sw	zero,12(sp)
  8000ec:	22a000ef          	jal	ra,800316 <vprintfmt>
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
  800116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6131>
  80011a:	ec06                	sd	ra,24(sp)
  80011c:	e4be                	sd	a5,72(sp)
  80011e:	e8c2                	sd	a6,80(sp)
  800120:	ecc6                	sd	a7,88(sp)
  800122:	e41a                	sd	t1,8(sp)
  800124:	c202                	sw	zero,4(sp)
  800126:	1f0000ef          	jal	ra,800316 <vprintfmt>
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

0000000000800182 <sys_putc>:
  800182:	85aa                	mv	a1,a0
  800184:	4579                	li	a0,30
  800186:	fadff06f          	j	800132 <syscall>

000000000080018a <sys_sleep>:
  80018a:	85aa                	mv	a1,a0
  80018c:	452d                	li	a0,11
  80018e:	fa5ff06f          	j	800132 <syscall>

0000000000800192 <sys_gettime>:
  800192:	4545                	li	a0,17
  800194:	f9fff06f          	j	800132 <syscall>

0000000000800198 <sys_open>:
  800198:	862e                	mv	a2,a1
  80019a:	85aa                	mv	a1,a0
  80019c:	06400513          	li	a0,100
  8001a0:	f93ff06f          	j	800132 <syscall>

00000000008001a4 <sys_close>:
  8001a4:	85aa                	mv	a1,a0
  8001a6:	06500513          	li	a0,101
  8001aa:	f89ff06f          	j	800132 <syscall>

00000000008001ae <sys_dup>:
  8001ae:	862e                	mv	a2,a1
  8001b0:	85aa                	mv	a1,a0
  8001b2:	08200513          	li	a0,130
  8001b6:	f7dff06f          	j	800132 <syscall>

00000000008001ba <exit>:
  8001ba:	1141                	addi	sp,sp,-16
  8001bc:	e406                	sd	ra,8(sp)
  8001be:	fadff0ef          	jal	ra,80016a <sys_exit>
  8001c2:	00000517          	auipc	a0,0x0
  8001c6:	60e50513          	addi	a0,a0,1550 # 8007d0 <main+0xb2>
  8001ca:	f2fff0ef          	jal	ra,8000f8 <cprintf>
  8001ce:	a001                	j	8001ce <exit+0x14>

00000000008001d0 <fork>:
  8001d0:	fa3ff06f          	j	800172 <sys_fork>

00000000008001d4 <waitpid>:
  8001d4:	fa5ff06f          	j	800178 <sys_wait>

00000000008001d8 <gettime_msec>:
  8001d8:	fbbff06f          	j	800192 <sys_gettime>

00000000008001dc <sleep>:
  8001dc:	1502                	slli	a0,a0,0x20
  8001de:	9101                	srli	a0,a0,0x20
  8001e0:	fabff06f          	j	80018a <sys_sleep>

00000000008001e4 <initfd>:
  8001e4:	1101                	addi	sp,sp,-32
  8001e6:	87ae                	mv	a5,a1
  8001e8:	e426                	sd	s1,8(sp)
  8001ea:	85b2                	mv	a1,a2
  8001ec:	84aa                	mv	s1,a0
  8001ee:	853e                	mv	a0,a5
  8001f0:	e822                	sd	s0,16(sp)
  8001f2:	ec06                	sd	ra,24(sp)
  8001f4:	e2dff0ef          	jal	ra,800020 <open>
  8001f8:	842a                	mv	s0,a0
  8001fa:	00054463          	bltz	a0,800202 <initfd+0x1e>
  8001fe:	00951863          	bne	a0,s1,80020e <initfd+0x2a>
  800202:	8522                	mv	a0,s0
  800204:	60e2                	ld	ra,24(sp)
  800206:	6442                	ld	s0,16(sp)
  800208:	64a2                	ld	s1,8(sp)
  80020a:	6105                	addi	sp,sp,32
  80020c:	8082                	ret
  80020e:	8526                	mv	a0,s1
  800210:	e19ff0ef          	jal	ra,800028 <close>
  800214:	85a6                	mv	a1,s1
  800216:	8522                	mv	a0,s0
  800218:	e15ff0ef          	jal	ra,80002c <dup2>
  80021c:	84aa                	mv	s1,a0
  80021e:	8522                	mv	a0,s0
  800220:	e09ff0ef          	jal	ra,800028 <close>
  800224:	8426                	mv	s0,s1
  800226:	bff1                	j	800202 <initfd+0x1e>

0000000000800228 <umain>:
  800228:	1101                	addi	sp,sp,-32
  80022a:	e822                	sd	s0,16(sp)
  80022c:	e426                	sd	s1,8(sp)
  80022e:	842a                	mv	s0,a0
  800230:	84ae                	mv	s1,a1
  800232:	4601                	li	a2,0
  800234:	00000597          	auipc	a1,0x0
  800238:	5b458593          	addi	a1,a1,1460 # 8007e8 <main+0xca>
  80023c:	4501                	li	a0,0
  80023e:	ec06                	sd	ra,24(sp)
  800240:	fa5ff0ef          	jal	ra,8001e4 <initfd>
  800244:	02054263          	bltz	a0,800268 <umain+0x40>
  800248:	4605                	li	a2,1
  80024a:	00000597          	auipc	a1,0x0
  80024e:	5de58593          	addi	a1,a1,1502 # 800828 <main+0x10a>
  800252:	4505                	li	a0,1
  800254:	f91ff0ef          	jal	ra,8001e4 <initfd>
  800258:	02054663          	bltz	a0,800284 <umain+0x5c>
  80025c:	85a6                	mv	a1,s1
  80025e:	8522                	mv	a0,s0
  800260:	4be000ef          	jal	ra,80071e <main>
  800264:	f57ff0ef          	jal	ra,8001ba <exit>
  800268:	86aa                	mv	a3,a0
  80026a:	00000617          	auipc	a2,0x0
  80026e:	58660613          	addi	a2,a2,1414 # 8007f0 <main+0xd2>
  800272:	02000593          	li	a1,32
  800276:	00000517          	auipc	a0,0x0
  80027a:	59a50513          	addi	a0,a0,1434 # 800810 <main+0xf2>
  80027e:	df9ff0ef          	jal	ra,800076 <__warn>
  800282:	b7d9                	j	800248 <umain+0x20>
  800284:	86aa                	mv	a3,a0
  800286:	00000617          	auipc	a2,0x0
  80028a:	5aa60613          	addi	a2,a2,1450 # 800830 <main+0x112>
  80028e:	02500593          	li	a1,37
  800292:	00000517          	auipc	a0,0x0
  800296:	57e50513          	addi	a0,a0,1406 # 800810 <main+0xf2>
  80029a:	dddff0ef          	jal	ra,800076 <__warn>
  80029e:	bf7d                	j	80025c <umain+0x34>

00000000008002a0 <printnum>:
  8002a0:	02071893          	slli	a7,a4,0x20
  8002a4:	7139                	addi	sp,sp,-64
  8002a6:	0208d893          	srli	a7,a7,0x20
  8002aa:	e456                	sd	s5,8(sp)
  8002ac:	0316fab3          	remu	s5,a3,a7
  8002b0:	f822                	sd	s0,48(sp)
  8002b2:	f426                	sd	s1,40(sp)
  8002b4:	f04a                	sd	s2,32(sp)
  8002b6:	ec4e                	sd	s3,24(sp)
  8002b8:	fc06                	sd	ra,56(sp)
  8002ba:	e852                	sd	s4,16(sp)
  8002bc:	84aa                	mv	s1,a0
  8002be:	89ae                	mv	s3,a1
  8002c0:	8932                	mv	s2,a2
  8002c2:	fff7841b          	addiw	s0,a5,-1
  8002c6:	2a81                	sext.w	s5,s5
  8002c8:	0516f163          	bleu	a7,a3,80030a <printnum+0x6a>
  8002cc:	8a42                	mv	s4,a6
  8002ce:	00805863          	blez	s0,8002de <printnum+0x3e>
  8002d2:	347d                	addiw	s0,s0,-1
  8002d4:	864e                	mv	a2,s3
  8002d6:	85ca                	mv	a1,s2
  8002d8:	8552                	mv	a0,s4
  8002da:	9482                	jalr	s1
  8002dc:	f87d                	bnez	s0,8002d2 <printnum+0x32>
  8002de:	1a82                	slli	s5,s5,0x20
  8002e0:	020ada93          	srli	s5,s5,0x20
  8002e4:	00000797          	auipc	a5,0x0
  8002e8:	78c78793          	addi	a5,a5,1932 # 800a70 <error_string+0xc8>
  8002ec:	9abe                	add	s5,s5,a5
  8002ee:	7442                	ld	s0,48(sp)
  8002f0:	000ac503          	lbu	a0,0(s5)
  8002f4:	70e2                	ld	ra,56(sp)
  8002f6:	6a42                	ld	s4,16(sp)
  8002f8:	6aa2                	ld	s5,8(sp)
  8002fa:	864e                	mv	a2,s3
  8002fc:	85ca                	mv	a1,s2
  8002fe:	69e2                	ld	s3,24(sp)
  800300:	7902                	ld	s2,32(sp)
  800302:	8326                	mv	t1,s1
  800304:	74a2                	ld	s1,40(sp)
  800306:	6121                	addi	sp,sp,64
  800308:	8302                	jr	t1
  80030a:	0316d6b3          	divu	a3,a3,a7
  80030e:	87a2                	mv	a5,s0
  800310:	f91ff0ef          	jal	ra,8002a0 <printnum>
  800314:	b7e9                	j	8002de <printnum+0x3e>

0000000000800316 <vprintfmt>:
  800316:	7119                	addi	sp,sp,-128
  800318:	f4a6                	sd	s1,104(sp)
  80031a:	f0ca                	sd	s2,96(sp)
  80031c:	ecce                	sd	s3,88(sp)
  80031e:	e4d6                	sd	s5,72(sp)
  800320:	e0da                	sd	s6,64(sp)
  800322:	fc5e                	sd	s7,56(sp)
  800324:	f862                	sd	s8,48(sp)
  800326:	ec6e                	sd	s11,24(sp)
  800328:	fc86                	sd	ra,120(sp)
  80032a:	f8a2                	sd	s0,112(sp)
  80032c:	e8d2                	sd	s4,80(sp)
  80032e:	f466                	sd	s9,40(sp)
  800330:	f06a                	sd	s10,32(sp)
  800332:	89aa                	mv	s3,a0
  800334:	892e                	mv	s2,a1
  800336:	84b2                	mv	s1,a2
  800338:	8db6                	mv	s11,a3
  80033a:	8b3a                	mv	s6,a4
  80033c:	5bfd                	li	s7,-1
  80033e:	00000a97          	auipc	s5,0x0
  800342:	50ea8a93          	addi	s5,s5,1294 # 80084c <main+0x12e>
  800346:	05e00c13          	li	s8,94
  80034a:	000dc503          	lbu	a0,0(s11)
  80034e:	02500793          	li	a5,37
  800352:	001d8413          	addi	s0,s11,1
  800356:	00f50f63          	beq	a0,a5,800374 <vprintfmt+0x5e>
  80035a:	c529                	beqz	a0,8003a4 <vprintfmt+0x8e>
  80035c:	02500a13          	li	s4,37
  800360:	a011                	j	800364 <vprintfmt+0x4e>
  800362:	c129                	beqz	a0,8003a4 <vprintfmt+0x8e>
  800364:	864a                	mv	a2,s2
  800366:	85a6                	mv	a1,s1
  800368:	0405                	addi	s0,s0,1
  80036a:	9982                	jalr	s3
  80036c:	fff44503          	lbu	a0,-1(s0)
  800370:	ff4519e3          	bne	a0,s4,800362 <vprintfmt+0x4c>
  800374:	00044603          	lbu	a2,0(s0)
  800378:	02000813          	li	a6,32
  80037c:	4a01                	li	s4,0
  80037e:	4881                	li	a7,0
  800380:	5d7d                	li	s10,-1
  800382:	5cfd                	li	s9,-1
  800384:	05500593          	li	a1,85
  800388:	4525                	li	a0,9
  80038a:	fdd6071b          	addiw	a4,a2,-35
  80038e:	0ff77713          	andi	a4,a4,255
  800392:	00140d93          	addi	s11,s0,1
  800396:	22e5e363          	bltu	a1,a4,8005bc <vprintfmt+0x2a6>
  80039a:	070a                	slli	a4,a4,0x2
  80039c:	9756                	add	a4,a4,s5
  80039e:	4318                	lw	a4,0(a4)
  8003a0:	9756                	add	a4,a4,s5
  8003a2:	8702                	jr	a4
  8003a4:	70e6                	ld	ra,120(sp)
  8003a6:	7446                	ld	s0,112(sp)
  8003a8:	74a6                	ld	s1,104(sp)
  8003aa:	7906                	ld	s2,96(sp)
  8003ac:	69e6                	ld	s3,88(sp)
  8003ae:	6a46                	ld	s4,80(sp)
  8003b0:	6aa6                	ld	s5,72(sp)
  8003b2:	6b06                	ld	s6,64(sp)
  8003b4:	7be2                	ld	s7,56(sp)
  8003b6:	7c42                	ld	s8,48(sp)
  8003b8:	7ca2                	ld	s9,40(sp)
  8003ba:	7d02                	ld	s10,32(sp)
  8003bc:	6de2                	ld	s11,24(sp)
  8003be:	6109                	addi	sp,sp,128
  8003c0:	8082                	ret
  8003c2:	4705                	li	a4,1
  8003c4:	008b0613          	addi	a2,s6,8
  8003c8:	01174463          	blt	a4,a7,8003d0 <vprintfmt+0xba>
  8003cc:	28088563          	beqz	a7,800656 <vprintfmt+0x340>
  8003d0:	000b3683          	ld	a3,0(s6)
  8003d4:	4741                	li	a4,16
  8003d6:	8b32                	mv	s6,a2
  8003d8:	a86d                	j	800492 <vprintfmt+0x17c>
  8003da:	00144603          	lbu	a2,1(s0)
  8003de:	4a05                	li	s4,1
  8003e0:	846e                	mv	s0,s11
  8003e2:	b765                	j	80038a <vprintfmt+0x74>
  8003e4:	000b2503          	lw	a0,0(s6)
  8003e8:	864a                	mv	a2,s2
  8003ea:	85a6                	mv	a1,s1
  8003ec:	0b21                	addi	s6,s6,8
  8003ee:	9982                	jalr	s3
  8003f0:	bfa9                	j	80034a <vprintfmt+0x34>
  8003f2:	4705                	li	a4,1
  8003f4:	008b0a13          	addi	s4,s6,8
  8003f8:	01174463          	blt	a4,a7,800400 <vprintfmt+0xea>
  8003fc:	24088563          	beqz	a7,800646 <vprintfmt+0x330>
  800400:	000b3403          	ld	s0,0(s6)
  800404:	26044563          	bltz	s0,80066e <vprintfmt+0x358>
  800408:	86a2                	mv	a3,s0
  80040a:	8b52                	mv	s6,s4
  80040c:	4729                	li	a4,10
  80040e:	a051                	j	800492 <vprintfmt+0x17c>
  800410:	000b2783          	lw	a5,0(s6)
  800414:	46e1                	li	a3,24
  800416:	0b21                	addi	s6,s6,8
  800418:	41f7d71b          	sraiw	a4,a5,0x1f
  80041c:	8fb9                	xor	a5,a5,a4
  80041e:	40e7873b          	subw	a4,a5,a4
  800422:	1ce6c163          	blt	a3,a4,8005e4 <vprintfmt+0x2ce>
  800426:	00371793          	slli	a5,a4,0x3
  80042a:	00000697          	auipc	a3,0x0
  80042e:	57e68693          	addi	a3,a3,1406 # 8009a8 <error_string>
  800432:	97b6                	add	a5,a5,a3
  800434:	639c                	ld	a5,0(a5)
  800436:	1a078763          	beqz	a5,8005e4 <vprintfmt+0x2ce>
  80043a:	873e                	mv	a4,a5
  80043c:	00001697          	auipc	a3,0x1
  800440:	83c68693          	addi	a3,a3,-1988 # 800c78 <error_string+0x2d0>
  800444:	8626                	mv	a2,s1
  800446:	85ca                	mv	a1,s2
  800448:	854e                	mv	a0,s3
  80044a:	25a000ef          	jal	ra,8006a4 <printfmt>
  80044e:	bdf5                	j	80034a <vprintfmt+0x34>
  800450:	00144603          	lbu	a2,1(s0)
  800454:	2885                	addiw	a7,a7,1
  800456:	846e                	mv	s0,s11
  800458:	bf0d                	j	80038a <vprintfmt+0x74>
  80045a:	4705                	li	a4,1
  80045c:	008b0613          	addi	a2,s6,8
  800460:	01174463          	blt	a4,a7,800468 <vprintfmt+0x152>
  800464:	1e088e63          	beqz	a7,800660 <vprintfmt+0x34a>
  800468:	000b3683          	ld	a3,0(s6)
  80046c:	4721                	li	a4,8
  80046e:	8b32                	mv	s6,a2
  800470:	a00d                	j	800492 <vprintfmt+0x17c>
  800472:	03000513          	li	a0,48
  800476:	864a                	mv	a2,s2
  800478:	85a6                	mv	a1,s1
  80047a:	e042                	sd	a6,0(sp)
  80047c:	9982                	jalr	s3
  80047e:	864a                	mv	a2,s2
  800480:	85a6                	mv	a1,s1
  800482:	07800513          	li	a0,120
  800486:	9982                	jalr	s3
  800488:	0b21                	addi	s6,s6,8
  80048a:	ff8b3683          	ld	a3,-8(s6)
  80048e:	6802                	ld	a6,0(sp)
  800490:	4741                	li	a4,16
  800492:	87e6                	mv	a5,s9
  800494:	8626                	mv	a2,s1
  800496:	85ca                	mv	a1,s2
  800498:	854e                	mv	a0,s3
  80049a:	e07ff0ef          	jal	ra,8002a0 <printnum>
  80049e:	b575                	j	80034a <vprintfmt+0x34>
  8004a0:	000b3703          	ld	a4,0(s6)
  8004a4:	0b21                	addi	s6,s6,8
  8004a6:	1e070063          	beqz	a4,800686 <vprintfmt+0x370>
  8004aa:	00170413          	addi	s0,a4,1
  8004ae:	19905563          	blez	s9,800638 <vprintfmt+0x322>
  8004b2:	02d00613          	li	a2,45
  8004b6:	14c81963          	bne	a6,a2,800608 <vprintfmt+0x2f2>
  8004ba:	00074703          	lbu	a4,0(a4)
  8004be:	0007051b          	sext.w	a0,a4
  8004c2:	c90d                	beqz	a0,8004f4 <vprintfmt+0x1de>
  8004c4:	000d4563          	bltz	s10,8004ce <vprintfmt+0x1b8>
  8004c8:	3d7d                	addiw	s10,s10,-1
  8004ca:	037d0363          	beq	s10,s7,8004f0 <vprintfmt+0x1da>
  8004ce:	864a                	mv	a2,s2
  8004d0:	85a6                	mv	a1,s1
  8004d2:	180a0c63          	beqz	s4,80066a <vprintfmt+0x354>
  8004d6:	3701                	addiw	a4,a4,-32
  8004d8:	18ec7963          	bleu	a4,s8,80066a <vprintfmt+0x354>
  8004dc:	03f00513          	li	a0,63
  8004e0:	9982                	jalr	s3
  8004e2:	0405                	addi	s0,s0,1
  8004e4:	fff44703          	lbu	a4,-1(s0)
  8004e8:	3cfd                	addiw	s9,s9,-1
  8004ea:	0007051b          	sext.w	a0,a4
  8004ee:	f979                	bnez	a0,8004c4 <vprintfmt+0x1ae>
  8004f0:	e5905de3          	blez	s9,80034a <vprintfmt+0x34>
  8004f4:	3cfd                	addiw	s9,s9,-1
  8004f6:	864a                	mv	a2,s2
  8004f8:	85a6                	mv	a1,s1
  8004fa:	02000513          	li	a0,32
  8004fe:	9982                	jalr	s3
  800500:	e40c85e3          	beqz	s9,80034a <vprintfmt+0x34>
  800504:	3cfd                	addiw	s9,s9,-1
  800506:	864a                	mv	a2,s2
  800508:	85a6                	mv	a1,s1
  80050a:	02000513          	li	a0,32
  80050e:	9982                	jalr	s3
  800510:	fe0c92e3          	bnez	s9,8004f4 <vprintfmt+0x1de>
  800514:	bd1d                	j	80034a <vprintfmt+0x34>
  800516:	4705                	li	a4,1
  800518:	008b0613          	addi	a2,s6,8
  80051c:	01174463          	blt	a4,a7,800524 <vprintfmt+0x20e>
  800520:	12088663          	beqz	a7,80064c <vprintfmt+0x336>
  800524:	000b3683          	ld	a3,0(s6)
  800528:	4729                	li	a4,10
  80052a:	8b32                	mv	s6,a2
  80052c:	b79d                	j	800492 <vprintfmt+0x17c>
  80052e:	00144603          	lbu	a2,1(s0)
  800532:	02d00813          	li	a6,45
  800536:	846e                	mv	s0,s11
  800538:	bd89                	j	80038a <vprintfmt+0x74>
  80053a:	864a                	mv	a2,s2
  80053c:	85a6                	mv	a1,s1
  80053e:	02500513          	li	a0,37
  800542:	9982                	jalr	s3
  800544:	b519                	j	80034a <vprintfmt+0x34>
  800546:	000b2d03          	lw	s10,0(s6)
  80054a:	00144603          	lbu	a2,1(s0)
  80054e:	0b21                	addi	s6,s6,8
  800550:	846e                	mv	s0,s11
  800552:	e20cdce3          	bgez	s9,80038a <vprintfmt+0x74>
  800556:	8cea                	mv	s9,s10
  800558:	5d7d                	li	s10,-1
  80055a:	bd05                	j	80038a <vprintfmt+0x74>
  80055c:	00144603          	lbu	a2,1(s0)
  800560:	03000813          	li	a6,48
  800564:	846e                	mv	s0,s11
  800566:	b515                	j	80038a <vprintfmt+0x74>
  800568:	fd060d1b          	addiw	s10,a2,-48
  80056c:	00144603          	lbu	a2,1(s0)
  800570:	846e                	mv	s0,s11
  800572:	fd06071b          	addiw	a4,a2,-48
  800576:	0006031b          	sext.w	t1,a2
  80057a:	fce56ce3          	bltu	a0,a4,800552 <vprintfmt+0x23c>
  80057e:	0405                	addi	s0,s0,1
  800580:	002d171b          	slliw	a4,s10,0x2
  800584:	00044603          	lbu	a2,0(s0)
  800588:	01a706bb          	addw	a3,a4,s10
  80058c:	0016969b          	slliw	a3,a3,0x1
  800590:	006686bb          	addw	a3,a3,t1
  800594:	fd06071b          	addiw	a4,a2,-48
  800598:	fd068d1b          	addiw	s10,a3,-48
  80059c:	0006031b          	sext.w	t1,a2
  8005a0:	fce57fe3          	bleu	a4,a0,80057e <vprintfmt+0x268>
  8005a4:	b77d                	j	800552 <vprintfmt+0x23c>
  8005a6:	fffcc713          	not	a4,s9
  8005aa:	977d                	srai	a4,a4,0x3f
  8005ac:	00ecf7b3          	and	a5,s9,a4
  8005b0:	00144603          	lbu	a2,1(s0)
  8005b4:	00078c9b          	sext.w	s9,a5
  8005b8:	846e                	mv	s0,s11
  8005ba:	bbc1                	j	80038a <vprintfmt+0x74>
  8005bc:	864a                	mv	a2,s2
  8005be:	85a6                	mv	a1,s1
  8005c0:	02500513          	li	a0,37
  8005c4:	9982                	jalr	s3
  8005c6:	fff44703          	lbu	a4,-1(s0)
  8005ca:	02500793          	li	a5,37
  8005ce:	8da2                	mv	s11,s0
  8005d0:	d6f70de3          	beq	a4,a5,80034a <vprintfmt+0x34>
  8005d4:	02500713          	li	a4,37
  8005d8:	1dfd                	addi	s11,s11,-1
  8005da:	fffdc783          	lbu	a5,-1(s11)
  8005de:	fee79de3          	bne	a5,a4,8005d8 <vprintfmt+0x2c2>
  8005e2:	b3a5                	j	80034a <vprintfmt+0x34>
  8005e4:	00000697          	auipc	a3,0x0
  8005e8:	68468693          	addi	a3,a3,1668 # 800c68 <error_string+0x2c0>
  8005ec:	8626                	mv	a2,s1
  8005ee:	85ca                	mv	a1,s2
  8005f0:	854e                	mv	a0,s3
  8005f2:	0b2000ef          	jal	ra,8006a4 <printfmt>
  8005f6:	bb91                	j	80034a <vprintfmt+0x34>
  8005f8:	00000717          	auipc	a4,0x0
  8005fc:	66870713          	addi	a4,a4,1640 # 800c60 <error_string+0x2b8>
  800600:	00000417          	auipc	s0,0x0
  800604:	66140413          	addi	s0,s0,1633 # 800c61 <error_string+0x2b9>
  800608:	853a                	mv	a0,a4
  80060a:	85ea                	mv	a1,s10
  80060c:	e03a                	sd	a4,0(sp)
  80060e:	e442                	sd	a6,8(sp)
  800610:	0b2000ef          	jal	ra,8006c2 <strnlen>
  800614:	40ac8cbb          	subw	s9,s9,a0
  800618:	6702                	ld	a4,0(sp)
  80061a:	01905f63          	blez	s9,800638 <vprintfmt+0x322>
  80061e:	6822                	ld	a6,8(sp)
  800620:	0008079b          	sext.w	a5,a6
  800624:	e43e                	sd	a5,8(sp)
  800626:	6522                	ld	a0,8(sp)
  800628:	864a                	mv	a2,s2
  80062a:	85a6                	mv	a1,s1
  80062c:	e03a                	sd	a4,0(sp)
  80062e:	3cfd                	addiw	s9,s9,-1
  800630:	9982                	jalr	s3
  800632:	6702                	ld	a4,0(sp)
  800634:	fe0c99e3          	bnez	s9,800626 <vprintfmt+0x310>
  800638:	00074703          	lbu	a4,0(a4)
  80063c:	0007051b          	sext.w	a0,a4
  800640:	e80512e3          	bnez	a0,8004c4 <vprintfmt+0x1ae>
  800644:	b319                	j	80034a <vprintfmt+0x34>
  800646:	000b2403          	lw	s0,0(s6)
  80064a:	bb6d                	j	800404 <vprintfmt+0xee>
  80064c:	000b6683          	lwu	a3,0(s6)
  800650:	4729                	li	a4,10
  800652:	8b32                	mv	s6,a2
  800654:	bd3d                	j	800492 <vprintfmt+0x17c>
  800656:	000b6683          	lwu	a3,0(s6)
  80065a:	4741                	li	a4,16
  80065c:	8b32                	mv	s6,a2
  80065e:	bd15                	j	800492 <vprintfmt+0x17c>
  800660:	000b6683          	lwu	a3,0(s6)
  800664:	4721                	li	a4,8
  800666:	8b32                	mv	s6,a2
  800668:	b52d                	j	800492 <vprintfmt+0x17c>
  80066a:	9982                	jalr	s3
  80066c:	bd9d                	j	8004e2 <vprintfmt+0x1cc>
  80066e:	864a                	mv	a2,s2
  800670:	85a6                	mv	a1,s1
  800672:	02d00513          	li	a0,45
  800676:	e042                	sd	a6,0(sp)
  800678:	9982                	jalr	s3
  80067a:	8b52                	mv	s6,s4
  80067c:	408006b3          	neg	a3,s0
  800680:	4729                	li	a4,10
  800682:	6802                	ld	a6,0(sp)
  800684:	b539                	j	800492 <vprintfmt+0x17c>
  800686:	01905663          	blez	s9,800692 <vprintfmt+0x37c>
  80068a:	02d00713          	li	a4,45
  80068e:	f6e815e3          	bne	a6,a4,8005f8 <vprintfmt+0x2e2>
  800692:	00000417          	auipc	s0,0x0
  800696:	5cf40413          	addi	s0,s0,1487 # 800c61 <error_string+0x2b9>
  80069a:	02800513          	li	a0,40
  80069e:	02800713          	li	a4,40
  8006a2:	b50d                	j	8004c4 <vprintfmt+0x1ae>

00000000008006a4 <printfmt>:
  8006a4:	7139                	addi	sp,sp,-64
  8006a6:	02010313          	addi	t1,sp,32
  8006aa:	f03a                	sd	a4,32(sp)
  8006ac:	871a                	mv	a4,t1
  8006ae:	ec06                	sd	ra,24(sp)
  8006b0:	f43e                	sd	a5,40(sp)
  8006b2:	f842                	sd	a6,48(sp)
  8006b4:	fc46                	sd	a7,56(sp)
  8006b6:	e41a                	sd	t1,8(sp)
  8006b8:	c5fff0ef          	jal	ra,800316 <vprintfmt>
  8006bc:	60e2                	ld	ra,24(sp)
  8006be:	6121                	addi	sp,sp,64
  8006c0:	8082                	ret

00000000008006c2 <strnlen>:
  8006c2:	c185                	beqz	a1,8006e2 <strnlen+0x20>
  8006c4:	00054783          	lbu	a5,0(a0)
  8006c8:	cf89                	beqz	a5,8006e2 <strnlen+0x20>
  8006ca:	4781                	li	a5,0
  8006cc:	a021                	j	8006d4 <strnlen+0x12>
  8006ce:	00074703          	lbu	a4,0(a4)
  8006d2:	c711                	beqz	a4,8006de <strnlen+0x1c>
  8006d4:	0785                	addi	a5,a5,1
  8006d6:	00f50733          	add	a4,a0,a5
  8006da:	fef59ae3          	bne	a1,a5,8006ce <strnlen+0xc>
  8006de:	853e                	mv	a0,a5
  8006e0:	8082                	ret
  8006e2:	4781                	li	a5,0
  8006e4:	853e                	mv	a0,a5
  8006e6:	8082                	ret

00000000008006e8 <sleepy>:
  8006e8:	1101                	addi	sp,sp,-32
  8006ea:	e822                	sd	s0,16(sp)
  8006ec:	e426                	sd	s1,8(sp)
  8006ee:	e04a                	sd	s2,0(sp)
  8006f0:	ec06                	sd	ra,24(sp)
  8006f2:	4401                	li	s0,0
  8006f4:	00000917          	auipc	s2,0x0
  8006f8:	61490913          	addi	s2,s2,1556 # 800d08 <error_string+0x360>
  8006fc:	44a9                	li	s1,10
  8006fe:	06400513          	li	a0,100
  800702:	adbff0ef          	jal	ra,8001dc <sleep>
  800706:	2405                	addiw	s0,s0,1
  800708:	06400613          	li	a2,100
  80070c:	85a2                	mv	a1,s0
  80070e:	854a                	mv	a0,s2
  800710:	9e9ff0ef          	jal	ra,8000f8 <cprintf>
  800714:	fe9415e3          	bne	s0,s1,8006fe <sleepy+0x16>
  800718:	4501                	li	a0,0
  80071a:	aa1ff0ef          	jal	ra,8001ba <exit>

000000000080071e <main>:
  80071e:	1101                	addi	sp,sp,-32
  800720:	e822                	sd	s0,16(sp)
  800722:	ec06                	sd	ra,24(sp)
  800724:	ab5ff0ef          	jal	ra,8001d8 <gettime_msec>
  800728:	0005041b          	sext.w	s0,a0
  80072c:	aa5ff0ef          	jal	ra,8001d0 <fork>
  800730:	cd21                	beqz	a0,800788 <main+0x6a>
  800732:	006c                	addi	a1,sp,12
  800734:	aa1ff0ef          	jal	ra,8001d4 <waitpid>
  800738:	47b2                	lw	a5,12(sp)
  80073a:	8d5d                	or	a0,a0,a5
  80073c:	2501                	sext.w	a0,a0
  80073e:	e515                	bnez	a0,80076a <main+0x4c>
  800740:	a99ff0ef          	jal	ra,8001d8 <gettime_msec>
  800744:	408505bb          	subw	a1,a0,s0
  800748:	00000517          	auipc	a0,0x0
  80074c:	59850513          	addi	a0,a0,1432 # 800ce0 <error_string+0x338>
  800750:	9a9ff0ef          	jal	ra,8000f8 <cprintf>
  800754:	00000517          	auipc	a0,0x0
  800758:	5a450513          	addi	a0,a0,1444 # 800cf8 <error_string+0x350>
  80075c:	99dff0ef          	jal	ra,8000f8 <cprintf>
  800760:	60e2                	ld	ra,24(sp)
  800762:	6442                	ld	s0,16(sp)
  800764:	4501                	li	a0,0
  800766:	6105                	addi	sp,sp,32
  800768:	8082                	ret
  80076a:	00000697          	auipc	a3,0x0
  80076e:	51668693          	addi	a3,a3,1302 # 800c80 <error_string+0x2d8>
  800772:	00000617          	auipc	a2,0x0
  800776:	54660613          	addi	a2,a2,1350 # 800cb8 <error_string+0x310>
  80077a:	45dd                	li	a1,23
  80077c:	00000517          	auipc	a0,0x0
  800780:	55450513          	addi	a0,a0,1364 # 800cd0 <error_string+0x328>
  800784:	8b3ff0ef          	jal	ra,800036 <__panic>
  800788:	f61ff0ef          	jal	ra,8006e8 <sleepy>
