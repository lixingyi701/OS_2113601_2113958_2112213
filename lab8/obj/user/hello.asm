
obj/__user_hello.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	11c0006f          	j	800140 <sys_open>

0000000000800028 <close>:
  800028:	1240006f          	j	80014c <sys_close>

000000000080002c <dup2>:
  80002c:	12a0006f          	j	800156 <sys_dup>

0000000000800030 <_start>:
  800030:	190000ef          	jal	ra,8001c0 <umain>
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
  800048:	69450513          	addi	a0,a0,1684 # 8006d8 <main+0x58>
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
  800064:	00001517          	auipc	a0,0x1
  800068:	b6450513          	addi	a0,a0,-1180 # 800bc8 <error_string+0x2f8>
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
  8000ac:	202000ef          	jal	ra,8002ae <vprintfmt>
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
  8000e6:	1c8000ef          	jal	ra,8002ae <vprintfmt>
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

0000000000800140 <sys_open>:
  800140:	862e                	mv	a2,a1
  800142:	85aa                	mv	a1,a0
  800144:	06400513          	li	a0,100
  800148:	fabff06f          	j	8000f2 <syscall>

000000000080014c <sys_close>:
  80014c:	85aa                	mv	a1,a0
  80014e:	06500513          	li	a0,101
  800152:	fa1ff06f          	j	8000f2 <syscall>

0000000000800156 <sys_dup>:
  800156:	862e                	mv	a2,a1
  800158:	85aa                	mv	a1,a0
  80015a:	08200513          	li	a0,130
  80015e:	f95ff06f          	j	8000f2 <syscall>

0000000000800162 <exit>:
  800162:	1141                	addi	sp,sp,-16
  800164:	e406                	sd	ra,8(sp)
  800166:	fc5ff0ef          	jal	ra,80012a <sys_exit>
  80016a:	00000517          	auipc	a0,0x0
  80016e:	58e50513          	addi	a0,a0,1422 # 8006f8 <main+0x78>
  800172:	f47ff0ef          	jal	ra,8000b8 <cprintf>
  800176:	a001                	j	800176 <exit+0x14>

0000000000800178 <getpid>:
  800178:	fbbff06f          	j	800132 <sys_getpid>

000000000080017c <initfd>:
  80017c:	1101                	addi	sp,sp,-32
  80017e:	87ae                	mv	a5,a1
  800180:	e426                	sd	s1,8(sp)
  800182:	85b2                	mv	a1,a2
  800184:	84aa                	mv	s1,a0
  800186:	853e                	mv	a0,a5
  800188:	e822                	sd	s0,16(sp)
  80018a:	ec06                	sd	ra,24(sp)
  80018c:	e95ff0ef          	jal	ra,800020 <open>
  800190:	842a                	mv	s0,a0
  800192:	00054463          	bltz	a0,80019a <initfd+0x1e>
  800196:	00951863          	bne	a0,s1,8001a6 <initfd+0x2a>
  80019a:	8522                	mv	a0,s0
  80019c:	60e2                	ld	ra,24(sp)
  80019e:	6442                	ld	s0,16(sp)
  8001a0:	64a2                	ld	s1,8(sp)
  8001a2:	6105                	addi	sp,sp,32
  8001a4:	8082                	ret
  8001a6:	8526                	mv	a0,s1
  8001a8:	e81ff0ef          	jal	ra,800028 <close>
  8001ac:	85a6                	mv	a1,s1
  8001ae:	8522                	mv	a0,s0
  8001b0:	e7dff0ef          	jal	ra,80002c <dup2>
  8001b4:	84aa                	mv	s1,a0
  8001b6:	8522                	mv	a0,s0
  8001b8:	e71ff0ef          	jal	ra,800028 <close>
  8001bc:	8426                	mv	s0,s1
  8001be:	bff1                	j	80019a <initfd+0x1e>

00000000008001c0 <umain>:
  8001c0:	1101                	addi	sp,sp,-32
  8001c2:	e822                	sd	s0,16(sp)
  8001c4:	e426                	sd	s1,8(sp)
  8001c6:	842a                	mv	s0,a0
  8001c8:	84ae                	mv	s1,a1
  8001ca:	4601                	li	a2,0
  8001cc:	00000597          	auipc	a1,0x0
  8001d0:	54458593          	addi	a1,a1,1348 # 800710 <main+0x90>
  8001d4:	4501                	li	a0,0
  8001d6:	ec06                	sd	ra,24(sp)
  8001d8:	fa5ff0ef          	jal	ra,80017c <initfd>
  8001dc:	02054263          	bltz	a0,800200 <umain+0x40>
  8001e0:	4605                	li	a2,1
  8001e2:	00000597          	auipc	a1,0x0
  8001e6:	56e58593          	addi	a1,a1,1390 # 800750 <main+0xd0>
  8001ea:	4505                	li	a0,1
  8001ec:	f91ff0ef          	jal	ra,80017c <initfd>
  8001f0:	02054663          	bltz	a0,80021c <umain+0x5c>
  8001f4:	85a6                	mv	a1,s1
  8001f6:	8522                	mv	a0,s0
  8001f8:	488000ef          	jal	ra,800680 <main>
  8001fc:	f67ff0ef          	jal	ra,800162 <exit>
  800200:	86aa                	mv	a3,a0
  800202:	00000617          	auipc	a2,0x0
  800206:	51660613          	addi	a2,a2,1302 # 800718 <main+0x98>
  80020a:	02000593          	li	a1,32
  80020e:	00000517          	auipc	a0,0x0
  800212:	52a50513          	addi	a0,a0,1322 # 800738 <main+0xb8>
  800216:	e21ff0ef          	jal	ra,800036 <__warn>
  80021a:	b7d9                	j	8001e0 <umain+0x20>
  80021c:	86aa                	mv	a3,a0
  80021e:	00000617          	auipc	a2,0x0
  800222:	53a60613          	addi	a2,a2,1338 # 800758 <main+0xd8>
  800226:	02500593          	li	a1,37
  80022a:	00000517          	auipc	a0,0x0
  80022e:	50e50513          	addi	a0,a0,1294 # 800738 <main+0xb8>
  800232:	e05ff0ef          	jal	ra,800036 <__warn>
  800236:	bf7d                	j	8001f4 <umain+0x34>

0000000000800238 <printnum>:
  800238:	02071893          	slli	a7,a4,0x20
  80023c:	7139                	addi	sp,sp,-64
  80023e:	0208d893          	srli	a7,a7,0x20
  800242:	e456                	sd	s5,8(sp)
  800244:	0316fab3          	remu	s5,a3,a7
  800248:	f822                	sd	s0,48(sp)
  80024a:	f426                	sd	s1,40(sp)
  80024c:	f04a                	sd	s2,32(sp)
  80024e:	ec4e                	sd	s3,24(sp)
  800250:	fc06                	sd	ra,56(sp)
  800252:	e852                	sd	s4,16(sp)
  800254:	84aa                	mv	s1,a0
  800256:	89ae                	mv	s3,a1
  800258:	8932                	mv	s2,a2
  80025a:	fff7841b          	addiw	s0,a5,-1
  80025e:	2a81                	sext.w	s5,s5
  800260:	0516f163          	bleu	a7,a3,8002a2 <printnum+0x6a>
  800264:	8a42                	mv	s4,a6
  800266:	00805863          	blez	s0,800276 <printnum+0x3e>
  80026a:	347d                	addiw	s0,s0,-1
  80026c:	864e                	mv	a2,s3
  80026e:	85ca                	mv	a1,s2
  800270:	8552                	mv	a0,s4
  800272:	9482                	jalr	s1
  800274:	f87d                	bnez	s0,80026a <printnum+0x32>
  800276:	1a82                	slli	s5,s5,0x20
  800278:	020ada93          	srli	s5,s5,0x20
  80027c:	00000797          	auipc	a5,0x0
  800280:	71c78793          	addi	a5,a5,1820 # 800998 <error_string+0xc8>
  800284:	9abe                	add	s5,s5,a5
  800286:	7442                	ld	s0,48(sp)
  800288:	000ac503          	lbu	a0,0(s5)
  80028c:	70e2                	ld	ra,56(sp)
  80028e:	6a42                	ld	s4,16(sp)
  800290:	6aa2                	ld	s5,8(sp)
  800292:	864e                	mv	a2,s3
  800294:	85ca                	mv	a1,s2
  800296:	69e2                	ld	s3,24(sp)
  800298:	7902                	ld	s2,32(sp)
  80029a:	8326                	mv	t1,s1
  80029c:	74a2                	ld	s1,40(sp)
  80029e:	6121                	addi	sp,sp,64
  8002a0:	8302                	jr	t1
  8002a2:	0316d6b3          	divu	a3,a3,a7
  8002a6:	87a2                	mv	a5,s0
  8002a8:	f91ff0ef          	jal	ra,800238 <printnum>
  8002ac:	b7e9                	j	800276 <printnum+0x3e>

00000000008002ae <vprintfmt>:
  8002ae:	7119                	addi	sp,sp,-128
  8002b0:	f4a6                	sd	s1,104(sp)
  8002b2:	f0ca                	sd	s2,96(sp)
  8002b4:	ecce                	sd	s3,88(sp)
  8002b6:	e4d6                	sd	s5,72(sp)
  8002b8:	e0da                	sd	s6,64(sp)
  8002ba:	fc5e                	sd	s7,56(sp)
  8002bc:	f862                	sd	s8,48(sp)
  8002be:	ec6e                	sd	s11,24(sp)
  8002c0:	fc86                	sd	ra,120(sp)
  8002c2:	f8a2                	sd	s0,112(sp)
  8002c4:	e8d2                	sd	s4,80(sp)
  8002c6:	f466                	sd	s9,40(sp)
  8002c8:	f06a                	sd	s10,32(sp)
  8002ca:	89aa                	mv	s3,a0
  8002cc:	892e                	mv	s2,a1
  8002ce:	84b2                	mv	s1,a2
  8002d0:	8db6                	mv	s11,a3
  8002d2:	8b3a                	mv	s6,a4
  8002d4:	5bfd                	li	s7,-1
  8002d6:	00000a97          	auipc	s5,0x0
  8002da:	49ea8a93          	addi	s5,s5,1182 # 800774 <main+0xf4>
  8002de:	05e00c13          	li	s8,94
  8002e2:	000dc503          	lbu	a0,0(s11)
  8002e6:	02500793          	li	a5,37
  8002ea:	001d8413          	addi	s0,s11,1
  8002ee:	00f50f63          	beq	a0,a5,80030c <vprintfmt+0x5e>
  8002f2:	c529                	beqz	a0,80033c <vprintfmt+0x8e>
  8002f4:	02500a13          	li	s4,37
  8002f8:	a011                	j	8002fc <vprintfmt+0x4e>
  8002fa:	c129                	beqz	a0,80033c <vprintfmt+0x8e>
  8002fc:	864a                	mv	a2,s2
  8002fe:	85a6                	mv	a1,s1
  800300:	0405                	addi	s0,s0,1
  800302:	9982                	jalr	s3
  800304:	fff44503          	lbu	a0,-1(s0)
  800308:	ff4519e3          	bne	a0,s4,8002fa <vprintfmt+0x4c>
  80030c:	00044603          	lbu	a2,0(s0)
  800310:	02000813          	li	a6,32
  800314:	4a01                	li	s4,0
  800316:	4881                	li	a7,0
  800318:	5d7d                	li	s10,-1
  80031a:	5cfd                	li	s9,-1
  80031c:	05500593          	li	a1,85
  800320:	4525                	li	a0,9
  800322:	fdd6071b          	addiw	a4,a2,-35
  800326:	0ff77713          	andi	a4,a4,255
  80032a:	00140d93          	addi	s11,s0,1
  80032e:	22e5e363          	bltu	a1,a4,800554 <vprintfmt+0x2a6>
  800332:	070a                	slli	a4,a4,0x2
  800334:	9756                	add	a4,a4,s5
  800336:	4318                	lw	a4,0(a4)
  800338:	9756                	add	a4,a4,s5
  80033a:	8702                	jr	a4
  80033c:	70e6                	ld	ra,120(sp)
  80033e:	7446                	ld	s0,112(sp)
  800340:	74a6                	ld	s1,104(sp)
  800342:	7906                	ld	s2,96(sp)
  800344:	69e6                	ld	s3,88(sp)
  800346:	6a46                	ld	s4,80(sp)
  800348:	6aa6                	ld	s5,72(sp)
  80034a:	6b06                	ld	s6,64(sp)
  80034c:	7be2                	ld	s7,56(sp)
  80034e:	7c42                	ld	s8,48(sp)
  800350:	7ca2                	ld	s9,40(sp)
  800352:	7d02                	ld	s10,32(sp)
  800354:	6de2                	ld	s11,24(sp)
  800356:	6109                	addi	sp,sp,128
  800358:	8082                	ret
  80035a:	4705                	li	a4,1
  80035c:	008b0613          	addi	a2,s6,8
  800360:	01174463          	blt	a4,a7,800368 <vprintfmt+0xba>
  800364:	28088563          	beqz	a7,8005ee <vprintfmt+0x340>
  800368:	000b3683          	ld	a3,0(s6)
  80036c:	4741                	li	a4,16
  80036e:	8b32                	mv	s6,a2
  800370:	a86d                	j	80042a <vprintfmt+0x17c>
  800372:	00144603          	lbu	a2,1(s0)
  800376:	4a05                	li	s4,1
  800378:	846e                	mv	s0,s11
  80037a:	b765                	j	800322 <vprintfmt+0x74>
  80037c:	000b2503          	lw	a0,0(s6)
  800380:	864a                	mv	a2,s2
  800382:	85a6                	mv	a1,s1
  800384:	0b21                	addi	s6,s6,8
  800386:	9982                	jalr	s3
  800388:	bfa9                	j	8002e2 <vprintfmt+0x34>
  80038a:	4705                	li	a4,1
  80038c:	008b0a13          	addi	s4,s6,8
  800390:	01174463          	blt	a4,a7,800398 <vprintfmt+0xea>
  800394:	24088563          	beqz	a7,8005de <vprintfmt+0x330>
  800398:	000b3403          	ld	s0,0(s6)
  80039c:	26044563          	bltz	s0,800606 <vprintfmt+0x358>
  8003a0:	86a2                	mv	a3,s0
  8003a2:	8b52                	mv	s6,s4
  8003a4:	4729                	li	a4,10
  8003a6:	a051                	j	80042a <vprintfmt+0x17c>
  8003a8:	000b2783          	lw	a5,0(s6)
  8003ac:	46e1                	li	a3,24
  8003ae:	0b21                	addi	s6,s6,8
  8003b0:	41f7d71b          	sraiw	a4,a5,0x1f
  8003b4:	8fb9                	xor	a5,a5,a4
  8003b6:	40e7873b          	subw	a4,a5,a4
  8003ba:	1ce6c163          	blt	a3,a4,80057c <vprintfmt+0x2ce>
  8003be:	00371793          	slli	a5,a4,0x3
  8003c2:	00000697          	auipc	a3,0x0
  8003c6:	50e68693          	addi	a3,a3,1294 # 8008d0 <error_string>
  8003ca:	97b6                	add	a5,a5,a3
  8003cc:	639c                	ld	a5,0(a5)
  8003ce:	1a078763          	beqz	a5,80057c <vprintfmt+0x2ce>
  8003d2:	873e                	mv	a4,a5
  8003d4:	00000697          	auipc	a3,0x0
  8003d8:	7cc68693          	addi	a3,a3,1996 # 800ba0 <error_string+0x2d0>
  8003dc:	8626                	mv	a2,s1
  8003de:	85ca                	mv	a1,s2
  8003e0:	854e                	mv	a0,s3
  8003e2:	25a000ef          	jal	ra,80063c <printfmt>
  8003e6:	bdf5                	j	8002e2 <vprintfmt+0x34>
  8003e8:	00144603          	lbu	a2,1(s0)
  8003ec:	2885                	addiw	a7,a7,1
  8003ee:	846e                	mv	s0,s11
  8003f0:	bf0d                	j	800322 <vprintfmt+0x74>
  8003f2:	4705                	li	a4,1
  8003f4:	008b0613          	addi	a2,s6,8
  8003f8:	01174463          	blt	a4,a7,800400 <vprintfmt+0x152>
  8003fc:	1e088e63          	beqz	a7,8005f8 <vprintfmt+0x34a>
  800400:	000b3683          	ld	a3,0(s6)
  800404:	4721                	li	a4,8
  800406:	8b32                	mv	s6,a2
  800408:	a00d                	j	80042a <vprintfmt+0x17c>
  80040a:	03000513          	li	a0,48
  80040e:	864a                	mv	a2,s2
  800410:	85a6                	mv	a1,s1
  800412:	e042                	sd	a6,0(sp)
  800414:	9982                	jalr	s3
  800416:	864a                	mv	a2,s2
  800418:	85a6                	mv	a1,s1
  80041a:	07800513          	li	a0,120
  80041e:	9982                	jalr	s3
  800420:	0b21                	addi	s6,s6,8
  800422:	ff8b3683          	ld	a3,-8(s6)
  800426:	6802                	ld	a6,0(sp)
  800428:	4741                	li	a4,16
  80042a:	87e6                	mv	a5,s9
  80042c:	8626                	mv	a2,s1
  80042e:	85ca                	mv	a1,s2
  800430:	854e                	mv	a0,s3
  800432:	e07ff0ef          	jal	ra,800238 <printnum>
  800436:	b575                	j	8002e2 <vprintfmt+0x34>
  800438:	000b3703          	ld	a4,0(s6)
  80043c:	0b21                	addi	s6,s6,8
  80043e:	1e070063          	beqz	a4,80061e <vprintfmt+0x370>
  800442:	00170413          	addi	s0,a4,1
  800446:	19905563          	blez	s9,8005d0 <vprintfmt+0x322>
  80044a:	02d00613          	li	a2,45
  80044e:	14c81963          	bne	a6,a2,8005a0 <vprintfmt+0x2f2>
  800452:	00074703          	lbu	a4,0(a4)
  800456:	0007051b          	sext.w	a0,a4
  80045a:	c90d                	beqz	a0,80048c <vprintfmt+0x1de>
  80045c:	000d4563          	bltz	s10,800466 <vprintfmt+0x1b8>
  800460:	3d7d                	addiw	s10,s10,-1
  800462:	037d0363          	beq	s10,s7,800488 <vprintfmt+0x1da>
  800466:	864a                	mv	a2,s2
  800468:	85a6                	mv	a1,s1
  80046a:	180a0c63          	beqz	s4,800602 <vprintfmt+0x354>
  80046e:	3701                	addiw	a4,a4,-32
  800470:	18ec7963          	bleu	a4,s8,800602 <vprintfmt+0x354>
  800474:	03f00513          	li	a0,63
  800478:	9982                	jalr	s3
  80047a:	0405                	addi	s0,s0,1
  80047c:	fff44703          	lbu	a4,-1(s0)
  800480:	3cfd                	addiw	s9,s9,-1
  800482:	0007051b          	sext.w	a0,a4
  800486:	f979                	bnez	a0,80045c <vprintfmt+0x1ae>
  800488:	e5905de3          	blez	s9,8002e2 <vprintfmt+0x34>
  80048c:	3cfd                	addiw	s9,s9,-1
  80048e:	864a                	mv	a2,s2
  800490:	85a6                	mv	a1,s1
  800492:	02000513          	li	a0,32
  800496:	9982                	jalr	s3
  800498:	e40c85e3          	beqz	s9,8002e2 <vprintfmt+0x34>
  80049c:	3cfd                	addiw	s9,s9,-1
  80049e:	864a                	mv	a2,s2
  8004a0:	85a6                	mv	a1,s1
  8004a2:	02000513          	li	a0,32
  8004a6:	9982                	jalr	s3
  8004a8:	fe0c92e3          	bnez	s9,80048c <vprintfmt+0x1de>
  8004ac:	bd1d                	j	8002e2 <vprintfmt+0x34>
  8004ae:	4705                	li	a4,1
  8004b0:	008b0613          	addi	a2,s6,8
  8004b4:	01174463          	blt	a4,a7,8004bc <vprintfmt+0x20e>
  8004b8:	12088663          	beqz	a7,8005e4 <vprintfmt+0x336>
  8004bc:	000b3683          	ld	a3,0(s6)
  8004c0:	4729                	li	a4,10
  8004c2:	8b32                	mv	s6,a2
  8004c4:	b79d                	j	80042a <vprintfmt+0x17c>
  8004c6:	00144603          	lbu	a2,1(s0)
  8004ca:	02d00813          	li	a6,45
  8004ce:	846e                	mv	s0,s11
  8004d0:	bd89                	j	800322 <vprintfmt+0x74>
  8004d2:	864a                	mv	a2,s2
  8004d4:	85a6                	mv	a1,s1
  8004d6:	02500513          	li	a0,37
  8004da:	9982                	jalr	s3
  8004dc:	b519                	j	8002e2 <vprintfmt+0x34>
  8004de:	000b2d03          	lw	s10,0(s6)
  8004e2:	00144603          	lbu	a2,1(s0)
  8004e6:	0b21                	addi	s6,s6,8
  8004e8:	846e                	mv	s0,s11
  8004ea:	e20cdce3          	bgez	s9,800322 <vprintfmt+0x74>
  8004ee:	8cea                	mv	s9,s10
  8004f0:	5d7d                	li	s10,-1
  8004f2:	bd05                	j	800322 <vprintfmt+0x74>
  8004f4:	00144603          	lbu	a2,1(s0)
  8004f8:	03000813          	li	a6,48
  8004fc:	846e                	mv	s0,s11
  8004fe:	b515                	j	800322 <vprintfmt+0x74>
  800500:	fd060d1b          	addiw	s10,a2,-48
  800504:	00144603          	lbu	a2,1(s0)
  800508:	846e                	mv	s0,s11
  80050a:	fd06071b          	addiw	a4,a2,-48
  80050e:	0006031b          	sext.w	t1,a2
  800512:	fce56ce3          	bltu	a0,a4,8004ea <vprintfmt+0x23c>
  800516:	0405                	addi	s0,s0,1
  800518:	002d171b          	slliw	a4,s10,0x2
  80051c:	00044603          	lbu	a2,0(s0)
  800520:	01a706bb          	addw	a3,a4,s10
  800524:	0016969b          	slliw	a3,a3,0x1
  800528:	006686bb          	addw	a3,a3,t1
  80052c:	fd06071b          	addiw	a4,a2,-48
  800530:	fd068d1b          	addiw	s10,a3,-48
  800534:	0006031b          	sext.w	t1,a2
  800538:	fce57fe3          	bleu	a4,a0,800516 <vprintfmt+0x268>
  80053c:	b77d                	j	8004ea <vprintfmt+0x23c>
  80053e:	fffcc713          	not	a4,s9
  800542:	977d                	srai	a4,a4,0x3f
  800544:	00ecf7b3          	and	a5,s9,a4
  800548:	00144603          	lbu	a2,1(s0)
  80054c:	00078c9b          	sext.w	s9,a5
  800550:	846e                	mv	s0,s11
  800552:	bbc1                	j	800322 <vprintfmt+0x74>
  800554:	864a                	mv	a2,s2
  800556:	85a6                	mv	a1,s1
  800558:	02500513          	li	a0,37
  80055c:	9982                	jalr	s3
  80055e:	fff44703          	lbu	a4,-1(s0)
  800562:	02500793          	li	a5,37
  800566:	8da2                	mv	s11,s0
  800568:	d6f70de3          	beq	a4,a5,8002e2 <vprintfmt+0x34>
  80056c:	02500713          	li	a4,37
  800570:	1dfd                	addi	s11,s11,-1
  800572:	fffdc783          	lbu	a5,-1(s11)
  800576:	fee79de3          	bne	a5,a4,800570 <vprintfmt+0x2c2>
  80057a:	b3a5                	j	8002e2 <vprintfmt+0x34>
  80057c:	00000697          	auipc	a3,0x0
  800580:	61468693          	addi	a3,a3,1556 # 800b90 <error_string+0x2c0>
  800584:	8626                	mv	a2,s1
  800586:	85ca                	mv	a1,s2
  800588:	854e                	mv	a0,s3
  80058a:	0b2000ef          	jal	ra,80063c <printfmt>
  80058e:	bb91                	j	8002e2 <vprintfmt+0x34>
  800590:	00000717          	auipc	a4,0x0
  800594:	5f870713          	addi	a4,a4,1528 # 800b88 <error_string+0x2b8>
  800598:	00000417          	auipc	s0,0x0
  80059c:	5f140413          	addi	s0,s0,1521 # 800b89 <error_string+0x2b9>
  8005a0:	853a                	mv	a0,a4
  8005a2:	85ea                	mv	a1,s10
  8005a4:	e03a                	sd	a4,0(sp)
  8005a6:	e442                	sd	a6,8(sp)
  8005a8:	0b2000ef          	jal	ra,80065a <strnlen>
  8005ac:	40ac8cbb          	subw	s9,s9,a0
  8005b0:	6702                	ld	a4,0(sp)
  8005b2:	01905f63          	blez	s9,8005d0 <vprintfmt+0x322>
  8005b6:	6822                	ld	a6,8(sp)
  8005b8:	0008079b          	sext.w	a5,a6
  8005bc:	e43e                	sd	a5,8(sp)
  8005be:	6522                	ld	a0,8(sp)
  8005c0:	864a                	mv	a2,s2
  8005c2:	85a6                	mv	a1,s1
  8005c4:	e03a                	sd	a4,0(sp)
  8005c6:	3cfd                	addiw	s9,s9,-1
  8005c8:	9982                	jalr	s3
  8005ca:	6702                	ld	a4,0(sp)
  8005cc:	fe0c99e3          	bnez	s9,8005be <vprintfmt+0x310>
  8005d0:	00074703          	lbu	a4,0(a4)
  8005d4:	0007051b          	sext.w	a0,a4
  8005d8:	e80512e3          	bnez	a0,80045c <vprintfmt+0x1ae>
  8005dc:	b319                	j	8002e2 <vprintfmt+0x34>
  8005de:	000b2403          	lw	s0,0(s6)
  8005e2:	bb6d                	j	80039c <vprintfmt+0xee>
  8005e4:	000b6683          	lwu	a3,0(s6)
  8005e8:	4729                	li	a4,10
  8005ea:	8b32                	mv	s6,a2
  8005ec:	bd3d                	j	80042a <vprintfmt+0x17c>
  8005ee:	000b6683          	lwu	a3,0(s6)
  8005f2:	4741                	li	a4,16
  8005f4:	8b32                	mv	s6,a2
  8005f6:	bd15                	j	80042a <vprintfmt+0x17c>
  8005f8:	000b6683          	lwu	a3,0(s6)
  8005fc:	4721                	li	a4,8
  8005fe:	8b32                	mv	s6,a2
  800600:	b52d                	j	80042a <vprintfmt+0x17c>
  800602:	9982                	jalr	s3
  800604:	bd9d                	j	80047a <vprintfmt+0x1cc>
  800606:	864a                	mv	a2,s2
  800608:	85a6                	mv	a1,s1
  80060a:	02d00513          	li	a0,45
  80060e:	e042                	sd	a6,0(sp)
  800610:	9982                	jalr	s3
  800612:	8b52                	mv	s6,s4
  800614:	408006b3          	neg	a3,s0
  800618:	4729                	li	a4,10
  80061a:	6802                	ld	a6,0(sp)
  80061c:	b539                	j	80042a <vprintfmt+0x17c>
  80061e:	01905663          	blez	s9,80062a <vprintfmt+0x37c>
  800622:	02d00713          	li	a4,45
  800626:	f6e815e3          	bne	a6,a4,800590 <vprintfmt+0x2e2>
  80062a:	00000417          	auipc	s0,0x0
  80062e:	55f40413          	addi	s0,s0,1375 # 800b89 <error_string+0x2b9>
  800632:	02800513          	li	a0,40
  800636:	02800713          	li	a4,40
  80063a:	b50d                	j	80045c <vprintfmt+0x1ae>

000000000080063c <printfmt>:
  80063c:	7139                	addi	sp,sp,-64
  80063e:	02010313          	addi	t1,sp,32
  800642:	f03a                	sd	a4,32(sp)
  800644:	871a                	mv	a4,t1
  800646:	ec06                	sd	ra,24(sp)
  800648:	f43e                	sd	a5,40(sp)
  80064a:	f842                	sd	a6,48(sp)
  80064c:	fc46                	sd	a7,56(sp)
  80064e:	e41a                	sd	t1,8(sp)
  800650:	c5fff0ef          	jal	ra,8002ae <vprintfmt>
  800654:	60e2                	ld	ra,24(sp)
  800656:	6121                	addi	sp,sp,64
  800658:	8082                	ret

000000000080065a <strnlen>:
  80065a:	c185                	beqz	a1,80067a <strnlen+0x20>
  80065c:	00054783          	lbu	a5,0(a0)
  800660:	cf89                	beqz	a5,80067a <strnlen+0x20>
  800662:	4781                	li	a5,0
  800664:	a021                	j	80066c <strnlen+0x12>
  800666:	00074703          	lbu	a4,0(a4)
  80066a:	c711                	beqz	a4,800676 <strnlen+0x1c>
  80066c:	0785                	addi	a5,a5,1
  80066e:	00f50733          	add	a4,a0,a5
  800672:	fef59ae3          	bne	a1,a5,800666 <strnlen+0xc>
  800676:	853e                	mv	a0,a5
  800678:	8082                	ret
  80067a:	4781                	li	a5,0
  80067c:	853e                	mv	a0,a5
  80067e:	8082                	ret

0000000000800680 <main>:
  800680:	1141                	addi	sp,sp,-16
  800682:	00000517          	auipc	a0,0x0
  800686:	52650513          	addi	a0,a0,1318 # 800ba8 <error_string+0x2d8>
  80068a:	e406                	sd	ra,8(sp)
  80068c:	a2dff0ef          	jal	ra,8000b8 <cprintf>
  800690:	ae9ff0ef          	jal	ra,800178 <getpid>
  800694:	85aa                	mv	a1,a0
  800696:	00000517          	auipc	a0,0x0
  80069a:	52250513          	addi	a0,a0,1314 # 800bb8 <error_string+0x2e8>
  80069e:	a1bff0ef          	jal	ra,8000b8 <cprintf>
  8006a2:	00000517          	auipc	a0,0x0
  8006a6:	52e50513          	addi	a0,a0,1326 # 800bd0 <error_string+0x300>
  8006aa:	a0fff0ef          	jal	ra,8000b8 <cprintf>
  8006ae:	60a2                	ld	ra,8(sp)
  8006b0:	4501                	li	a0,0
  8006b2:	0141                	addi	sp,sp,16
  8006b4:	8082                	ret
