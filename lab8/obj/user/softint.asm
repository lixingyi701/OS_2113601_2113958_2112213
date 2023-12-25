
obj/__user_softint.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1160006f          	j	80013a <sys_open>

0000000000800028 <close>:
  800028:	11e0006f          	j	800146 <sys_close>

000000000080002c <dup2>:
  80002c:	1240006f          	j	800150 <sys_dup>

0000000000800030 <_start>:
  800030:	186000ef          	jal	ra,8001b6 <umain>
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
  800048:	65c50513          	addi	a0,a0,1628 # 8006a0 <main+0x2a>
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
  800068:	69450513          	addi	a0,a0,1684 # 8006f8 <main+0x82>
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
  800080:	0b2000ef          	jal	ra,800132 <sys_putc>
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
  8000a4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6241>
  8000a8:	ec06                	sd	ra,24(sp)
  8000aa:	c602                	sw	zero,12(sp)
  8000ac:	1f8000ef          	jal	ra,8002a4 <vprintfmt>
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
  8000d6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6241>
  8000da:	ec06                	sd	ra,24(sp)
  8000dc:	e4be                	sd	a5,72(sp)
  8000de:	e8c2                	sd	a6,80(sp)
  8000e0:	ecc6                	sd	a7,88(sp)
  8000e2:	e41a                	sd	t1,8(sp)
  8000e4:	c202                	sw	zero,4(sp)
  8000e6:	1be000ef          	jal	ra,8002a4 <vprintfmt>
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

0000000000800132 <sys_putc>:
  800132:	85aa                	mv	a1,a0
  800134:	4579                	li	a0,30
  800136:	fbdff06f          	j	8000f2 <syscall>

000000000080013a <sys_open>:
  80013a:	862e                	mv	a2,a1
  80013c:	85aa                	mv	a1,a0
  80013e:	06400513          	li	a0,100
  800142:	fb1ff06f          	j	8000f2 <syscall>

0000000000800146 <sys_close>:
  800146:	85aa                	mv	a1,a0
  800148:	06500513          	li	a0,101
  80014c:	fa7ff06f          	j	8000f2 <syscall>

0000000000800150 <sys_dup>:
  800150:	862e                	mv	a2,a1
  800152:	85aa                	mv	a1,a0
  800154:	08200513          	li	a0,130
  800158:	f9bff06f          	j	8000f2 <syscall>

000000000080015c <exit>:
  80015c:	1141                	addi	sp,sp,-16
  80015e:	e406                	sd	ra,8(sp)
  800160:	fcbff0ef          	jal	ra,80012a <sys_exit>
  800164:	00000517          	auipc	a0,0x0
  800168:	55c50513          	addi	a0,a0,1372 # 8006c0 <main+0x4a>
  80016c:	f4dff0ef          	jal	ra,8000b8 <cprintf>
  800170:	a001                	j	800170 <exit+0x14>

0000000000800172 <initfd>:
  800172:	1101                	addi	sp,sp,-32
  800174:	87ae                	mv	a5,a1
  800176:	e426                	sd	s1,8(sp)
  800178:	85b2                	mv	a1,a2
  80017a:	84aa                	mv	s1,a0
  80017c:	853e                	mv	a0,a5
  80017e:	e822                	sd	s0,16(sp)
  800180:	ec06                	sd	ra,24(sp)
  800182:	e9fff0ef          	jal	ra,800020 <open>
  800186:	842a                	mv	s0,a0
  800188:	00054463          	bltz	a0,800190 <initfd+0x1e>
  80018c:	00951863          	bne	a0,s1,80019c <initfd+0x2a>
  800190:	8522                	mv	a0,s0
  800192:	60e2                	ld	ra,24(sp)
  800194:	6442                	ld	s0,16(sp)
  800196:	64a2                	ld	s1,8(sp)
  800198:	6105                	addi	sp,sp,32
  80019a:	8082                	ret
  80019c:	8526                	mv	a0,s1
  80019e:	e8bff0ef          	jal	ra,800028 <close>
  8001a2:	85a6                	mv	a1,s1
  8001a4:	8522                	mv	a0,s0
  8001a6:	e87ff0ef          	jal	ra,80002c <dup2>
  8001aa:	84aa                	mv	s1,a0
  8001ac:	8522                	mv	a0,s0
  8001ae:	e7bff0ef          	jal	ra,800028 <close>
  8001b2:	8426                	mv	s0,s1
  8001b4:	bff1                	j	800190 <initfd+0x1e>

00000000008001b6 <umain>:
  8001b6:	1101                	addi	sp,sp,-32
  8001b8:	e822                	sd	s0,16(sp)
  8001ba:	e426                	sd	s1,8(sp)
  8001bc:	842a                	mv	s0,a0
  8001be:	84ae                	mv	s1,a1
  8001c0:	4601                	li	a2,0
  8001c2:	00000597          	auipc	a1,0x0
  8001c6:	51658593          	addi	a1,a1,1302 # 8006d8 <main+0x62>
  8001ca:	4501                	li	a0,0
  8001cc:	ec06                	sd	ra,24(sp)
  8001ce:	fa5ff0ef          	jal	ra,800172 <initfd>
  8001d2:	02054263          	bltz	a0,8001f6 <umain+0x40>
  8001d6:	4605                	li	a2,1
  8001d8:	00000597          	auipc	a1,0x0
  8001dc:	54058593          	addi	a1,a1,1344 # 800718 <main+0xa2>
  8001e0:	4505                	li	a0,1
  8001e2:	f91ff0ef          	jal	ra,800172 <initfd>
  8001e6:	02054663          	bltz	a0,800212 <umain+0x5c>
  8001ea:	85a6                	mv	a1,s1
  8001ec:	8522                	mv	a0,s0
  8001ee:	488000ef          	jal	ra,800676 <main>
  8001f2:	f6bff0ef          	jal	ra,80015c <exit>
  8001f6:	86aa                	mv	a3,a0
  8001f8:	00000617          	auipc	a2,0x0
  8001fc:	4e860613          	addi	a2,a2,1256 # 8006e0 <main+0x6a>
  800200:	02000593          	li	a1,32
  800204:	00000517          	auipc	a0,0x0
  800208:	4fc50513          	addi	a0,a0,1276 # 800700 <main+0x8a>
  80020c:	e2bff0ef          	jal	ra,800036 <__warn>
  800210:	b7d9                	j	8001d6 <umain+0x20>
  800212:	86aa                	mv	a3,a0
  800214:	00000617          	auipc	a2,0x0
  800218:	50c60613          	addi	a2,a2,1292 # 800720 <main+0xaa>
  80021c:	02500593          	li	a1,37
  800220:	00000517          	auipc	a0,0x0
  800224:	4e050513          	addi	a0,a0,1248 # 800700 <main+0x8a>
  800228:	e0fff0ef          	jal	ra,800036 <__warn>
  80022c:	bf7d                	j	8001ea <umain+0x34>

000000000080022e <printnum>:
  80022e:	02071893          	slli	a7,a4,0x20
  800232:	7139                	addi	sp,sp,-64
  800234:	0208d893          	srli	a7,a7,0x20
  800238:	e456                	sd	s5,8(sp)
  80023a:	0316fab3          	remu	s5,a3,a7
  80023e:	f822                	sd	s0,48(sp)
  800240:	f426                	sd	s1,40(sp)
  800242:	f04a                	sd	s2,32(sp)
  800244:	ec4e                	sd	s3,24(sp)
  800246:	fc06                	sd	ra,56(sp)
  800248:	e852                	sd	s4,16(sp)
  80024a:	84aa                	mv	s1,a0
  80024c:	89ae                	mv	s3,a1
  80024e:	8932                	mv	s2,a2
  800250:	fff7841b          	addiw	s0,a5,-1
  800254:	2a81                	sext.w	s5,s5
  800256:	0516f163          	bleu	a7,a3,800298 <printnum+0x6a>
  80025a:	8a42                	mv	s4,a6
  80025c:	00805863          	blez	s0,80026c <printnum+0x3e>
  800260:	347d                	addiw	s0,s0,-1
  800262:	864e                	mv	a2,s3
  800264:	85ca                	mv	a1,s2
  800266:	8552                	mv	a0,s4
  800268:	9482                	jalr	s1
  80026a:	f87d                	bnez	s0,800260 <printnum+0x32>
  80026c:	1a82                	slli	s5,s5,0x20
  80026e:	020ada93          	srli	s5,s5,0x20
  800272:	00000797          	auipc	a5,0x0
  800276:	6ee78793          	addi	a5,a5,1774 # 800960 <error_string+0xc8>
  80027a:	9abe                	add	s5,s5,a5
  80027c:	7442                	ld	s0,48(sp)
  80027e:	000ac503          	lbu	a0,0(s5)
  800282:	70e2                	ld	ra,56(sp)
  800284:	6a42                	ld	s4,16(sp)
  800286:	6aa2                	ld	s5,8(sp)
  800288:	864e                	mv	a2,s3
  80028a:	85ca                	mv	a1,s2
  80028c:	69e2                	ld	s3,24(sp)
  80028e:	7902                	ld	s2,32(sp)
  800290:	8326                	mv	t1,s1
  800292:	74a2                	ld	s1,40(sp)
  800294:	6121                	addi	sp,sp,64
  800296:	8302                	jr	t1
  800298:	0316d6b3          	divu	a3,a3,a7
  80029c:	87a2                	mv	a5,s0
  80029e:	f91ff0ef          	jal	ra,80022e <printnum>
  8002a2:	b7e9                	j	80026c <printnum+0x3e>

00000000008002a4 <vprintfmt>:
  8002a4:	7119                	addi	sp,sp,-128
  8002a6:	f4a6                	sd	s1,104(sp)
  8002a8:	f0ca                	sd	s2,96(sp)
  8002aa:	ecce                	sd	s3,88(sp)
  8002ac:	e4d6                	sd	s5,72(sp)
  8002ae:	e0da                	sd	s6,64(sp)
  8002b0:	fc5e                	sd	s7,56(sp)
  8002b2:	f862                	sd	s8,48(sp)
  8002b4:	ec6e                	sd	s11,24(sp)
  8002b6:	fc86                	sd	ra,120(sp)
  8002b8:	f8a2                	sd	s0,112(sp)
  8002ba:	e8d2                	sd	s4,80(sp)
  8002bc:	f466                	sd	s9,40(sp)
  8002be:	f06a                	sd	s10,32(sp)
  8002c0:	89aa                	mv	s3,a0
  8002c2:	892e                	mv	s2,a1
  8002c4:	84b2                	mv	s1,a2
  8002c6:	8db6                	mv	s11,a3
  8002c8:	8b3a                	mv	s6,a4
  8002ca:	5bfd                	li	s7,-1
  8002cc:	00000a97          	auipc	s5,0x0
  8002d0:	470a8a93          	addi	s5,s5,1136 # 80073c <main+0xc6>
  8002d4:	05e00c13          	li	s8,94
  8002d8:	000dc503          	lbu	a0,0(s11)
  8002dc:	02500793          	li	a5,37
  8002e0:	001d8413          	addi	s0,s11,1
  8002e4:	00f50f63          	beq	a0,a5,800302 <vprintfmt+0x5e>
  8002e8:	c529                	beqz	a0,800332 <vprintfmt+0x8e>
  8002ea:	02500a13          	li	s4,37
  8002ee:	a011                	j	8002f2 <vprintfmt+0x4e>
  8002f0:	c129                	beqz	a0,800332 <vprintfmt+0x8e>
  8002f2:	864a                	mv	a2,s2
  8002f4:	85a6                	mv	a1,s1
  8002f6:	0405                	addi	s0,s0,1
  8002f8:	9982                	jalr	s3
  8002fa:	fff44503          	lbu	a0,-1(s0)
  8002fe:	ff4519e3          	bne	a0,s4,8002f0 <vprintfmt+0x4c>
  800302:	00044603          	lbu	a2,0(s0)
  800306:	02000813          	li	a6,32
  80030a:	4a01                	li	s4,0
  80030c:	4881                	li	a7,0
  80030e:	5d7d                	li	s10,-1
  800310:	5cfd                	li	s9,-1
  800312:	05500593          	li	a1,85
  800316:	4525                	li	a0,9
  800318:	fdd6071b          	addiw	a4,a2,-35
  80031c:	0ff77713          	andi	a4,a4,255
  800320:	00140d93          	addi	s11,s0,1
  800324:	22e5e363          	bltu	a1,a4,80054a <vprintfmt+0x2a6>
  800328:	070a                	slli	a4,a4,0x2
  80032a:	9756                	add	a4,a4,s5
  80032c:	4318                	lw	a4,0(a4)
  80032e:	9756                	add	a4,a4,s5
  800330:	8702                	jr	a4
  800332:	70e6                	ld	ra,120(sp)
  800334:	7446                	ld	s0,112(sp)
  800336:	74a6                	ld	s1,104(sp)
  800338:	7906                	ld	s2,96(sp)
  80033a:	69e6                	ld	s3,88(sp)
  80033c:	6a46                	ld	s4,80(sp)
  80033e:	6aa6                	ld	s5,72(sp)
  800340:	6b06                	ld	s6,64(sp)
  800342:	7be2                	ld	s7,56(sp)
  800344:	7c42                	ld	s8,48(sp)
  800346:	7ca2                	ld	s9,40(sp)
  800348:	7d02                	ld	s10,32(sp)
  80034a:	6de2                	ld	s11,24(sp)
  80034c:	6109                	addi	sp,sp,128
  80034e:	8082                	ret
  800350:	4705                	li	a4,1
  800352:	008b0613          	addi	a2,s6,8
  800356:	01174463          	blt	a4,a7,80035e <vprintfmt+0xba>
  80035a:	28088563          	beqz	a7,8005e4 <vprintfmt+0x340>
  80035e:	000b3683          	ld	a3,0(s6)
  800362:	4741                	li	a4,16
  800364:	8b32                	mv	s6,a2
  800366:	a86d                	j	800420 <vprintfmt+0x17c>
  800368:	00144603          	lbu	a2,1(s0)
  80036c:	4a05                	li	s4,1
  80036e:	846e                	mv	s0,s11
  800370:	b765                	j	800318 <vprintfmt+0x74>
  800372:	000b2503          	lw	a0,0(s6)
  800376:	864a                	mv	a2,s2
  800378:	85a6                	mv	a1,s1
  80037a:	0b21                	addi	s6,s6,8
  80037c:	9982                	jalr	s3
  80037e:	bfa9                	j	8002d8 <vprintfmt+0x34>
  800380:	4705                	li	a4,1
  800382:	008b0a13          	addi	s4,s6,8
  800386:	01174463          	blt	a4,a7,80038e <vprintfmt+0xea>
  80038a:	24088563          	beqz	a7,8005d4 <vprintfmt+0x330>
  80038e:	000b3403          	ld	s0,0(s6)
  800392:	26044563          	bltz	s0,8005fc <vprintfmt+0x358>
  800396:	86a2                	mv	a3,s0
  800398:	8b52                	mv	s6,s4
  80039a:	4729                	li	a4,10
  80039c:	a051                	j	800420 <vprintfmt+0x17c>
  80039e:	000b2783          	lw	a5,0(s6)
  8003a2:	46e1                	li	a3,24
  8003a4:	0b21                	addi	s6,s6,8
  8003a6:	41f7d71b          	sraiw	a4,a5,0x1f
  8003aa:	8fb9                	xor	a5,a5,a4
  8003ac:	40e7873b          	subw	a4,a5,a4
  8003b0:	1ce6c163          	blt	a3,a4,800572 <vprintfmt+0x2ce>
  8003b4:	00371793          	slli	a5,a4,0x3
  8003b8:	00000697          	auipc	a3,0x0
  8003bc:	4e068693          	addi	a3,a3,1248 # 800898 <error_string>
  8003c0:	97b6                	add	a5,a5,a3
  8003c2:	639c                	ld	a5,0(a5)
  8003c4:	1a078763          	beqz	a5,800572 <vprintfmt+0x2ce>
  8003c8:	873e                	mv	a4,a5
  8003ca:	00000697          	auipc	a3,0x0
  8003ce:	79e68693          	addi	a3,a3,1950 # 800b68 <error_string+0x2d0>
  8003d2:	8626                	mv	a2,s1
  8003d4:	85ca                	mv	a1,s2
  8003d6:	854e                	mv	a0,s3
  8003d8:	25a000ef          	jal	ra,800632 <printfmt>
  8003dc:	bdf5                	j	8002d8 <vprintfmt+0x34>
  8003de:	00144603          	lbu	a2,1(s0)
  8003e2:	2885                	addiw	a7,a7,1
  8003e4:	846e                	mv	s0,s11
  8003e6:	bf0d                	j	800318 <vprintfmt+0x74>
  8003e8:	4705                	li	a4,1
  8003ea:	008b0613          	addi	a2,s6,8
  8003ee:	01174463          	blt	a4,a7,8003f6 <vprintfmt+0x152>
  8003f2:	1e088e63          	beqz	a7,8005ee <vprintfmt+0x34a>
  8003f6:	000b3683          	ld	a3,0(s6)
  8003fa:	4721                	li	a4,8
  8003fc:	8b32                	mv	s6,a2
  8003fe:	a00d                	j	800420 <vprintfmt+0x17c>
  800400:	03000513          	li	a0,48
  800404:	864a                	mv	a2,s2
  800406:	85a6                	mv	a1,s1
  800408:	e042                	sd	a6,0(sp)
  80040a:	9982                	jalr	s3
  80040c:	864a                	mv	a2,s2
  80040e:	85a6                	mv	a1,s1
  800410:	07800513          	li	a0,120
  800414:	9982                	jalr	s3
  800416:	0b21                	addi	s6,s6,8
  800418:	ff8b3683          	ld	a3,-8(s6)
  80041c:	6802                	ld	a6,0(sp)
  80041e:	4741                	li	a4,16
  800420:	87e6                	mv	a5,s9
  800422:	8626                	mv	a2,s1
  800424:	85ca                	mv	a1,s2
  800426:	854e                	mv	a0,s3
  800428:	e07ff0ef          	jal	ra,80022e <printnum>
  80042c:	b575                	j	8002d8 <vprintfmt+0x34>
  80042e:	000b3703          	ld	a4,0(s6)
  800432:	0b21                	addi	s6,s6,8
  800434:	1e070063          	beqz	a4,800614 <vprintfmt+0x370>
  800438:	00170413          	addi	s0,a4,1
  80043c:	19905563          	blez	s9,8005c6 <vprintfmt+0x322>
  800440:	02d00613          	li	a2,45
  800444:	14c81963          	bne	a6,a2,800596 <vprintfmt+0x2f2>
  800448:	00074703          	lbu	a4,0(a4)
  80044c:	0007051b          	sext.w	a0,a4
  800450:	c90d                	beqz	a0,800482 <vprintfmt+0x1de>
  800452:	000d4563          	bltz	s10,80045c <vprintfmt+0x1b8>
  800456:	3d7d                	addiw	s10,s10,-1
  800458:	037d0363          	beq	s10,s7,80047e <vprintfmt+0x1da>
  80045c:	864a                	mv	a2,s2
  80045e:	85a6                	mv	a1,s1
  800460:	180a0c63          	beqz	s4,8005f8 <vprintfmt+0x354>
  800464:	3701                	addiw	a4,a4,-32
  800466:	18ec7963          	bleu	a4,s8,8005f8 <vprintfmt+0x354>
  80046a:	03f00513          	li	a0,63
  80046e:	9982                	jalr	s3
  800470:	0405                	addi	s0,s0,1
  800472:	fff44703          	lbu	a4,-1(s0)
  800476:	3cfd                	addiw	s9,s9,-1
  800478:	0007051b          	sext.w	a0,a4
  80047c:	f979                	bnez	a0,800452 <vprintfmt+0x1ae>
  80047e:	e5905de3          	blez	s9,8002d8 <vprintfmt+0x34>
  800482:	3cfd                	addiw	s9,s9,-1
  800484:	864a                	mv	a2,s2
  800486:	85a6                	mv	a1,s1
  800488:	02000513          	li	a0,32
  80048c:	9982                	jalr	s3
  80048e:	e40c85e3          	beqz	s9,8002d8 <vprintfmt+0x34>
  800492:	3cfd                	addiw	s9,s9,-1
  800494:	864a                	mv	a2,s2
  800496:	85a6                	mv	a1,s1
  800498:	02000513          	li	a0,32
  80049c:	9982                	jalr	s3
  80049e:	fe0c92e3          	bnez	s9,800482 <vprintfmt+0x1de>
  8004a2:	bd1d                	j	8002d8 <vprintfmt+0x34>
  8004a4:	4705                	li	a4,1
  8004a6:	008b0613          	addi	a2,s6,8
  8004aa:	01174463          	blt	a4,a7,8004b2 <vprintfmt+0x20e>
  8004ae:	12088663          	beqz	a7,8005da <vprintfmt+0x336>
  8004b2:	000b3683          	ld	a3,0(s6)
  8004b6:	4729                	li	a4,10
  8004b8:	8b32                	mv	s6,a2
  8004ba:	b79d                	j	800420 <vprintfmt+0x17c>
  8004bc:	00144603          	lbu	a2,1(s0)
  8004c0:	02d00813          	li	a6,45
  8004c4:	846e                	mv	s0,s11
  8004c6:	bd89                	j	800318 <vprintfmt+0x74>
  8004c8:	864a                	mv	a2,s2
  8004ca:	85a6                	mv	a1,s1
  8004cc:	02500513          	li	a0,37
  8004d0:	9982                	jalr	s3
  8004d2:	b519                	j	8002d8 <vprintfmt+0x34>
  8004d4:	000b2d03          	lw	s10,0(s6)
  8004d8:	00144603          	lbu	a2,1(s0)
  8004dc:	0b21                	addi	s6,s6,8
  8004de:	846e                	mv	s0,s11
  8004e0:	e20cdce3          	bgez	s9,800318 <vprintfmt+0x74>
  8004e4:	8cea                	mv	s9,s10
  8004e6:	5d7d                	li	s10,-1
  8004e8:	bd05                	j	800318 <vprintfmt+0x74>
  8004ea:	00144603          	lbu	a2,1(s0)
  8004ee:	03000813          	li	a6,48
  8004f2:	846e                	mv	s0,s11
  8004f4:	b515                	j	800318 <vprintfmt+0x74>
  8004f6:	fd060d1b          	addiw	s10,a2,-48
  8004fa:	00144603          	lbu	a2,1(s0)
  8004fe:	846e                	mv	s0,s11
  800500:	fd06071b          	addiw	a4,a2,-48
  800504:	0006031b          	sext.w	t1,a2
  800508:	fce56ce3          	bltu	a0,a4,8004e0 <vprintfmt+0x23c>
  80050c:	0405                	addi	s0,s0,1
  80050e:	002d171b          	slliw	a4,s10,0x2
  800512:	00044603          	lbu	a2,0(s0)
  800516:	01a706bb          	addw	a3,a4,s10
  80051a:	0016969b          	slliw	a3,a3,0x1
  80051e:	006686bb          	addw	a3,a3,t1
  800522:	fd06071b          	addiw	a4,a2,-48
  800526:	fd068d1b          	addiw	s10,a3,-48
  80052a:	0006031b          	sext.w	t1,a2
  80052e:	fce57fe3          	bleu	a4,a0,80050c <vprintfmt+0x268>
  800532:	b77d                	j	8004e0 <vprintfmt+0x23c>
  800534:	fffcc713          	not	a4,s9
  800538:	977d                	srai	a4,a4,0x3f
  80053a:	00ecf7b3          	and	a5,s9,a4
  80053e:	00144603          	lbu	a2,1(s0)
  800542:	00078c9b          	sext.w	s9,a5
  800546:	846e                	mv	s0,s11
  800548:	bbc1                	j	800318 <vprintfmt+0x74>
  80054a:	864a                	mv	a2,s2
  80054c:	85a6                	mv	a1,s1
  80054e:	02500513          	li	a0,37
  800552:	9982                	jalr	s3
  800554:	fff44703          	lbu	a4,-1(s0)
  800558:	02500793          	li	a5,37
  80055c:	8da2                	mv	s11,s0
  80055e:	d6f70de3          	beq	a4,a5,8002d8 <vprintfmt+0x34>
  800562:	02500713          	li	a4,37
  800566:	1dfd                	addi	s11,s11,-1
  800568:	fffdc783          	lbu	a5,-1(s11)
  80056c:	fee79de3          	bne	a5,a4,800566 <vprintfmt+0x2c2>
  800570:	b3a5                	j	8002d8 <vprintfmt+0x34>
  800572:	00000697          	auipc	a3,0x0
  800576:	5e668693          	addi	a3,a3,1510 # 800b58 <error_string+0x2c0>
  80057a:	8626                	mv	a2,s1
  80057c:	85ca                	mv	a1,s2
  80057e:	854e                	mv	a0,s3
  800580:	0b2000ef          	jal	ra,800632 <printfmt>
  800584:	bb91                	j	8002d8 <vprintfmt+0x34>
  800586:	00000717          	auipc	a4,0x0
  80058a:	5ca70713          	addi	a4,a4,1482 # 800b50 <error_string+0x2b8>
  80058e:	00000417          	auipc	s0,0x0
  800592:	5c340413          	addi	s0,s0,1475 # 800b51 <error_string+0x2b9>
  800596:	853a                	mv	a0,a4
  800598:	85ea                	mv	a1,s10
  80059a:	e03a                	sd	a4,0(sp)
  80059c:	e442                	sd	a6,8(sp)
  80059e:	0b2000ef          	jal	ra,800650 <strnlen>
  8005a2:	40ac8cbb          	subw	s9,s9,a0
  8005a6:	6702                	ld	a4,0(sp)
  8005a8:	01905f63          	blez	s9,8005c6 <vprintfmt+0x322>
  8005ac:	6822                	ld	a6,8(sp)
  8005ae:	0008079b          	sext.w	a5,a6
  8005b2:	e43e                	sd	a5,8(sp)
  8005b4:	6522                	ld	a0,8(sp)
  8005b6:	864a                	mv	a2,s2
  8005b8:	85a6                	mv	a1,s1
  8005ba:	e03a                	sd	a4,0(sp)
  8005bc:	3cfd                	addiw	s9,s9,-1
  8005be:	9982                	jalr	s3
  8005c0:	6702                	ld	a4,0(sp)
  8005c2:	fe0c99e3          	bnez	s9,8005b4 <vprintfmt+0x310>
  8005c6:	00074703          	lbu	a4,0(a4)
  8005ca:	0007051b          	sext.w	a0,a4
  8005ce:	e80512e3          	bnez	a0,800452 <vprintfmt+0x1ae>
  8005d2:	b319                	j	8002d8 <vprintfmt+0x34>
  8005d4:	000b2403          	lw	s0,0(s6)
  8005d8:	bb6d                	j	800392 <vprintfmt+0xee>
  8005da:	000b6683          	lwu	a3,0(s6)
  8005de:	4729                	li	a4,10
  8005e0:	8b32                	mv	s6,a2
  8005e2:	bd3d                	j	800420 <vprintfmt+0x17c>
  8005e4:	000b6683          	lwu	a3,0(s6)
  8005e8:	4741                	li	a4,16
  8005ea:	8b32                	mv	s6,a2
  8005ec:	bd15                	j	800420 <vprintfmt+0x17c>
  8005ee:	000b6683          	lwu	a3,0(s6)
  8005f2:	4721                	li	a4,8
  8005f4:	8b32                	mv	s6,a2
  8005f6:	b52d                	j	800420 <vprintfmt+0x17c>
  8005f8:	9982                	jalr	s3
  8005fa:	bd9d                	j	800470 <vprintfmt+0x1cc>
  8005fc:	864a                	mv	a2,s2
  8005fe:	85a6                	mv	a1,s1
  800600:	02d00513          	li	a0,45
  800604:	e042                	sd	a6,0(sp)
  800606:	9982                	jalr	s3
  800608:	8b52                	mv	s6,s4
  80060a:	408006b3          	neg	a3,s0
  80060e:	4729                	li	a4,10
  800610:	6802                	ld	a6,0(sp)
  800612:	b539                	j	800420 <vprintfmt+0x17c>
  800614:	01905663          	blez	s9,800620 <vprintfmt+0x37c>
  800618:	02d00713          	li	a4,45
  80061c:	f6e815e3          	bne	a6,a4,800586 <vprintfmt+0x2e2>
  800620:	00000417          	auipc	s0,0x0
  800624:	53140413          	addi	s0,s0,1329 # 800b51 <error_string+0x2b9>
  800628:	02800513          	li	a0,40
  80062c:	02800713          	li	a4,40
  800630:	b50d                	j	800452 <vprintfmt+0x1ae>

0000000000800632 <printfmt>:
  800632:	7139                	addi	sp,sp,-64
  800634:	02010313          	addi	t1,sp,32
  800638:	f03a                	sd	a4,32(sp)
  80063a:	871a                	mv	a4,t1
  80063c:	ec06                	sd	ra,24(sp)
  80063e:	f43e                	sd	a5,40(sp)
  800640:	f842                	sd	a6,48(sp)
  800642:	fc46                	sd	a7,56(sp)
  800644:	e41a                	sd	t1,8(sp)
  800646:	c5fff0ef          	jal	ra,8002a4 <vprintfmt>
  80064a:	60e2                	ld	ra,24(sp)
  80064c:	6121                	addi	sp,sp,64
  80064e:	8082                	ret

0000000000800650 <strnlen>:
  800650:	c185                	beqz	a1,800670 <strnlen+0x20>
  800652:	00054783          	lbu	a5,0(a0)
  800656:	cf89                	beqz	a5,800670 <strnlen+0x20>
  800658:	4781                	li	a5,0
  80065a:	a021                	j	800662 <strnlen+0x12>
  80065c:	00074703          	lbu	a4,0(a4)
  800660:	c711                	beqz	a4,80066c <strnlen+0x1c>
  800662:	0785                	addi	a5,a5,1
  800664:	00f50733          	add	a4,a0,a5
  800668:	fef59ae3          	bne	a1,a5,80065c <strnlen+0xc>
  80066c:	853e                	mv	a0,a5
  80066e:	8082                	ret
  800670:	4781                	li	a5,0
  800672:	853e                	mv	a0,a5
  800674:	8082                	ret

0000000000800676 <main>:
  800676:	1141                	addi	sp,sp,-16
  800678:	4501                	li	a0,0
  80067a:	e406                	sd	ra,8(sp)
  80067c:	ae1ff0ef          	jal	ra,80015c <exit>
