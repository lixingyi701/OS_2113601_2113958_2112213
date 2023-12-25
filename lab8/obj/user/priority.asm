
obj/__user_priority.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1840006f          	j	8001a8 <sys_open>

0000000000800028 <close>:
  800028:	18c0006f          	j	8001b4 <sys_close>

000000000080002c <dup2>:
  80002c:	1920006f          	j	8001be <sys_dup>

0000000000800030 <_start>:
  800030:	210000ef          	jal	ra,800240 <umain>
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
  800048:	88c50513          	addi	a0,a0,-1908 # 8008d0 <main+0x1be>
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
  800068:	8e450513          	addi	a0,a0,-1820 # 800948 <main+0x236>
  80006c:	08c000ef          	jal	ra,8000f8 <cprintf>
  800070:	5559                	li	a0,-10
  800072:	158000ef          	jal	ra,8001ca <exit>

0000000000800076 <__warn>:
  800076:	715d                	addi	sp,sp,-80
  800078:	e822                	sd	s0,16(sp)
  80007a:	fc3e                	sd	a5,56(sp)
  80007c:	8432                	mv	s0,a2
  80007e:	103c                	addi	a5,sp,40
  800080:	862e                	mv	a2,a1
  800082:	85aa                	mv	a1,a0
  800084:	00001517          	auipc	a0,0x1
  800088:	86c50513          	addi	a0,a0,-1940 # 8008f0 <main+0x1de>
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
  8000a8:	8a450513          	addi	a0,a0,-1884 # 800948 <main+0x236>
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
  8000c0:	0d0000ef          	jal	ra,800190 <sys_putc>
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
  8000e4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <pids+0xffffffffff7f5aa9>
  8000e8:	ec06                	sd	ra,24(sp)
  8000ea:	c602                	sw	zero,12(sp)
  8000ec:	242000ef          	jal	ra,80032e <vprintfmt>
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
  800116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <pids+0xffffffffff7f5aa9>
  80011a:	ec06                	sd	ra,24(sp)
  80011c:	e4be                	sd	a5,72(sp)
  80011e:	e8c2                	sd	a6,80(sp)
  800120:	ecc6                	sd	a7,88(sp)
  800122:	e41a                	sd	t1,8(sp)
  800124:	c202                	sw	zero,4(sp)
  800126:	208000ef          	jal	ra,80032e <vprintfmt>
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

0000000000800182 <sys_kill>:
  800182:	85aa                	mv	a1,a0
  800184:	4531                	li	a0,12
  800186:	fadff06f          	j	800132 <syscall>

000000000080018a <sys_getpid>:
  80018a:	4549                	li	a0,18
  80018c:	fa7ff06f          	j	800132 <syscall>

0000000000800190 <sys_putc>:
  800190:	85aa                	mv	a1,a0
  800192:	4579                	li	a0,30
  800194:	f9fff06f          	j	800132 <syscall>

0000000000800198 <sys_lab6_set_priority>:
  800198:	85aa                	mv	a1,a0
  80019a:	0ff00513          	li	a0,255
  80019e:	f95ff06f          	j	800132 <syscall>

00000000008001a2 <sys_gettime>:
  8001a2:	4545                	li	a0,17
  8001a4:	f8fff06f          	j	800132 <syscall>

00000000008001a8 <sys_open>:
  8001a8:	862e                	mv	a2,a1
  8001aa:	85aa                	mv	a1,a0
  8001ac:	06400513          	li	a0,100
  8001b0:	f83ff06f          	j	800132 <syscall>

00000000008001b4 <sys_close>:
  8001b4:	85aa                	mv	a1,a0
  8001b6:	06500513          	li	a0,101
  8001ba:	f79ff06f          	j	800132 <syscall>

00000000008001be <sys_dup>:
  8001be:	862e                	mv	a2,a1
  8001c0:	85aa                	mv	a1,a0
  8001c2:	08200513          	li	a0,130
  8001c6:	f6dff06f          	j	800132 <syscall>

00000000008001ca <exit>:
  8001ca:	1141                	addi	sp,sp,-16
  8001cc:	e406                	sd	ra,8(sp)
  8001ce:	f9dff0ef          	jal	ra,80016a <sys_exit>
  8001d2:	00000517          	auipc	a0,0x0
  8001d6:	73e50513          	addi	a0,a0,1854 # 800910 <main+0x1fe>
  8001da:	f1fff0ef          	jal	ra,8000f8 <cprintf>
  8001de:	a001                	j	8001de <exit+0x14>

00000000008001e0 <fork>:
  8001e0:	f93ff06f          	j	800172 <sys_fork>

00000000008001e4 <waitpid>:
  8001e4:	f95ff06f          	j	800178 <sys_wait>

00000000008001e8 <kill>:
  8001e8:	f9bff06f          	j	800182 <sys_kill>

00000000008001ec <getpid>:
  8001ec:	f9fff06f          	j	80018a <sys_getpid>

00000000008001f0 <gettime_msec>:
  8001f0:	fb3ff06f          	j	8001a2 <sys_gettime>

00000000008001f4 <lab6_set_priority>:
  8001f4:	1502                	slli	a0,a0,0x20
  8001f6:	9101                	srli	a0,a0,0x20
  8001f8:	fa1ff06f          	j	800198 <sys_lab6_set_priority>

00000000008001fc <initfd>:
  8001fc:	1101                	addi	sp,sp,-32
  8001fe:	87ae                	mv	a5,a1
  800200:	e426                	sd	s1,8(sp)
  800202:	85b2                	mv	a1,a2
  800204:	84aa                	mv	s1,a0
  800206:	853e                	mv	a0,a5
  800208:	e822                	sd	s0,16(sp)
  80020a:	ec06                	sd	ra,24(sp)
  80020c:	e15ff0ef          	jal	ra,800020 <open>
  800210:	842a                	mv	s0,a0
  800212:	00054463          	bltz	a0,80021a <initfd+0x1e>
  800216:	00951863          	bne	a0,s1,800226 <initfd+0x2a>
  80021a:	8522                	mv	a0,s0
  80021c:	60e2                	ld	ra,24(sp)
  80021e:	6442                	ld	s0,16(sp)
  800220:	64a2                	ld	s1,8(sp)
  800222:	6105                	addi	sp,sp,32
  800224:	8082                	ret
  800226:	8526                	mv	a0,s1
  800228:	e01ff0ef          	jal	ra,800028 <close>
  80022c:	85a6                	mv	a1,s1
  80022e:	8522                	mv	a0,s0
  800230:	dfdff0ef          	jal	ra,80002c <dup2>
  800234:	84aa                	mv	s1,a0
  800236:	8522                	mv	a0,s0
  800238:	df1ff0ef          	jal	ra,800028 <close>
  80023c:	8426                	mv	s0,s1
  80023e:	bff1                	j	80021a <initfd+0x1e>

0000000000800240 <umain>:
  800240:	1101                	addi	sp,sp,-32
  800242:	e822                	sd	s0,16(sp)
  800244:	e426                	sd	s1,8(sp)
  800246:	842a                	mv	s0,a0
  800248:	84ae                	mv	s1,a1
  80024a:	4601                	li	a2,0
  80024c:	00000597          	auipc	a1,0x0
  800250:	6dc58593          	addi	a1,a1,1756 # 800928 <main+0x216>
  800254:	4501                	li	a0,0
  800256:	ec06                	sd	ra,24(sp)
  800258:	fa5ff0ef          	jal	ra,8001fc <initfd>
  80025c:	02054263          	bltz	a0,800280 <umain+0x40>
  800260:	4605                	li	a2,1
  800262:	00000597          	auipc	a1,0x0
  800266:	70658593          	addi	a1,a1,1798 # 800968 <main+0x256>
  80026a:	4505                	li	a0,1
  80026c:	f91ff0ef          	jal	ra,8001fc <initfd>
  800270:	02054663          	bltz	a0,80029c <umain+0x5c>
  800274:	85a6                	mv	a1,s1
  800276:	8522                	mv	a0,s0
  800278:	49a000ef          	jal	ra,800712 <main>
  80027c:	f4fff0ef          	jal	ra,8001ca <exit>
  800280:	86aa                	mv	a3,a0
  800282:	00000617          	auipc	a2,0x0
  800286:	6ae60613          	addi	a2,a2,1710 # 800930 <main+0x21e>
  80028a:	02000593          	li	a1,32
  80028e:	00000517          	auipc	a0,0x0
  800292:	6c250513          	addi	a0,a0,1730 # 800950 <main+0x23e>
  800296:	de1ff0ef          	jal	ra,800076 <__warn>
  80029a:	b7d9                	j	800260 <umain+0x20>
  80029c:	86aa                	mv	a3,a0
  80029e:	00000617          	auipc	a2,0x0
  8002a2:	6d260613          	addi	a2,a2,1746 # 800970 <main+0x25e>
  8002a6:	02500593          	li	a1,37
  8002aa:	00000517          	auipc	a0,0x0
  8002ae:	6a650513          	addi	a0,a0,1702 # 800950 <main+0x23e>
  8002b2:	dc5ff0ef          	jal	ra,800076 <__warn>
  8002b6:	bf7d                	j	800274 <umain+0x34>

00000000008002b8 <printnum>:
  8002b8:	02071893          	slli	a7,a4,0x20
  8002bc:	7139                	addi	sp,sp,-64
  8002be:	0208d893          	srli	a7,a7,0x20
  8002c2:	e456                	sd	s5,8(sp)
  8002c4:	0316fab3          	remu	s5,a3,a7
  8002c8:	f822                	sd	s0,48(sp)
  8002ca:	f426                	sd	s1,40(sp)
  8002cc:	f04a                	sd	s2,32(sp)
  8002ce:	ec4e                	sd	s3,24(sp)
  8002d0:	fc06                	sd	ra,56(sp)
  8002d2:	e852                	sd	s4,16(sp)
  8002d4:	84aa                	mv	s1,a0
  8002d6:	89ae                	mv	s3,a1
  8002d8:	8932                	mv	s2,a2
  8002da:	fff7841b          	addiw	s0,a5,-1
  8002de:	2a81                	sext.w	s5,s5
  8002e0:	0516f163          	bleu	a7,a3,800322 <printnum+0x6a>
  8002e4:	8a42                	mv	s4,a6
  8002e6:	00805863          	blez	s0,8002f6 <printnum+0x3e>
  8002ea:	347d                	addiw	s0,s0,-1
  8002ec:	864e                	mv	a2,s3
  8002ee:	85ca                	mv	a1,s2
  8002f0:	8552                	mv	a0,s4
  8002f2:	9482                	jalr	s1
  8002f4:	f87d                	bnez	s0,8002ea <printnum+0x32>
  8002f6:	1a82                	slli	s5,s5,0x20
  8002f8:	020ada93          	srli	s5,s5,0x20
  8002fc:	00001797          	auipc	a5,0x1
  800300:	8b478793          	addi	a5,a5,-1868 # 800bb0 <error_string+0xc8>
  800304:	9abe                	add	s5,s5,a5
  800306:	7442                	ld	s0,48(sp)
  800308:	000ac503          	lbu	a0,0(s5)
  80030c:	70e2                	ld	ra,56(sp)
  80030e:	6a42                	ld	s4,16(sp)
  800310:	6aa2                	ld	s5,8(sp)
  800312:	864e                	mv	a2,s3
  800314:	85ca                	mv	a1,s2
  800316:	69e2                	ld	s3,24(sp)
  800318:	7902                	ld	s2,32(sp)
  80031a:	8326                	mv	t1,s1
  80031c:	74a2                	ld	s1,40(sp)
  80031e:	6121                	addi	sp,sp,64
  800320:	8302                	jr	t1
  800322:	0316d6b3          	divu	a3,a3,a7
  800326:	87a2                	mv	a5,s0
  800328:	f91ff0ef          	jal	ra,8002b8 <printnum>
  80032c:	b7e9                	j	8002f6 <printnum+0x3e>

000000000080032e <vprintfmt>:
  80032e:	7119                	addi	sp,sp,-128
  800330:	f4a6                	sd	s1,104(sp)
  800332:	f0ca                	sd	s2,96(sp)
  800334:	ecce                	sd	s3,88(sp)
  800336:	e4d6                	sd	s5,72(sp)
  800338:	e0da                	sd	s6,64(sp)
  80033a:	fc5e                	sd	s7,56(sp)
  80033c:	f862                	sd	s8,48(sp)
  80033e:	ec6e                	sd	s11,24(sp)
  800340:	fc86                	sd	ra,120(sp)
  800342:	f8a2                	sd	s0,112(sp)
  800344:	e8d2                	sd	s4,80(sp)
  800346:	f466                	sd	s9,40(sp)
  800348:	f06a                	sd	s10,32(sp)
  80034a:	89aa                	mv	s3,a0
  80034c:	892e                	mv	s2,a1
  80034e:	84b2                	mv	s1,a2
  800350:	8db6                	mv	s11,a3
  800352:	8b3a                	mv	s6,a4
  800354:	5bfd                	li	s7,-1
  800356:	00000a97          	auipc	s5,0x0
  80035a:	636a8a93          	addi	s5,s5,1590 # 80098c <main+0x27a>
  80035e:	05e00c13          	li	s8,94
  800362:	000dc503          	lbu	a0,0(s11)
  800366:	02500793          	li	a5,37
  80036a:	001d8413          	addi	s0,s11,1
  80036e:	00f50f63          	beq	a0,a5,80038c <vprintfmt+0x5e>
  800372:	c529                	beqz	a0,8003bc <vprintfmt+0x8e>
  800374:	02500a13          	li	s4,37
  800378:	a011                	j	80037c <vprintfmt+0x4e>
  80037a:	c129                	beqz	a0,8003bc <vprintfmt+0x8e>
  80037c:	864a                	mv	a2,s2
  80037e:	85a6                	mv	a1,s1
  800380:	0405                	addi	s0,s0,1
  800382:	9982                	jalr	s3
  800384:	fff44503          	lbu	a0,-1(s0)
  800388:	ff4519e3          	bne	a0,s4,80037a <vprintfmt+0x4c>
  80038c:	00044603          	lbu	a2,0(s0)
  800390:	02000813          	li	a6,32
  800394:	4a01                	li	s4,0
  800396:	4881                	li	a7,0
  800398:	5d7d                	li	s10,-1
  80039a:	5cfd                	li	s9,-1
  80039c:	05500593          	li	a1,85
  8003a0:	4525                	li	a0,9
  8003a2:	fdd6071b          	addiw	a4,a2,-35
  8003a6:	0ff77713          	andi	a4,a4,255
  8003aa:	00140d93          	addi	s11,s0,1
  8003ae:	22e5e363          	bltu	a1,a4,8005d4 <vprintfmt+0x2a6>
  8003b2:	070a                	slli	a4,a4,0x2
  8003b4:	9756                	add	a4,a4,s5
  8003b6:	4318                	lw	a4,0(a4)
  8003b8:	9756                	add	a4,a4,s5
  8003ba:	8702                	jr	a4
  8003bc:	70e6                	ld	ra,120(sp)
  8003be:	7446                	ld	s0,112(sp)
  8003c0:	74a6                	ld	s1,104(sp)
  8003c2:	7906                	ld	s2,96(sp)
  8003c4:	69e6                	ld	s3,88(sp)
  8003c6:	6a46                	ld	s4,80(sp)
  8003c8:	6aa6                	ld	s5,72(sp)
  8003ca:	6b06                	ld	s6,64(sp)
  8003cc:	7be2                	ld	s7,56(sp)
  8003ce:	7c42                	ld	s8,48(sp)
  8003d0:	7ca2                	ld	s9,40(sp)
  8003d2:	7d02                	ld	s10,32(sp)
  8003d4:	6de2                	ld	s11,24(sp)
  8003d6:	6109                	addi	sp,sp,128
  8003d8:	8082                	ret
  8003da:	4705                	li	a4,1
  8003dc:	008b0613          	addi	a2,s6,8
  8003e0:	01174463          	blt	a4,a7,8003e8 <vprintfmt+0xba>
  8003e4:	28088563          	beqz	a7,80066e <vprintfmt+0x340>
  8003e8:	000b3683          	ld	a3,0(s6)
  8003ec:	4741                	li	a4,16
  8003ee:	8b32                	mv	s6,a2
  8003f0:	a86d                	j	8004aa <vprintfmt+0x17c>
  8003f2:	00144603          	lbu	a2,1(s0)
  8003f6:	4a05                	li	s4,1
  8003f8:	846e                	mv	s0,s11
  8003fa:	b765                	j	8003a2 <vprintfmt+0x74>
  8003fc:	000b2503          	lw	a0,0(s6)
  800400:	864a                	mv	a2,s2
  800402:	85a6                	mv	a1,s1
  800404:	0b21                	addi	s6,s6,8
  800406:	9982                	jalr	s3
  800408:	bfa9                	j	800362 <vprintfmt+0x34>
  80040a:	4705                	li	a4,1
  80040c:	008b0a13          	addi	s4,s6,8
  800410:	01174463          	blt	a4,a7,800418 <vprintfmt+0xea>
  800414:	24088563          	beqz	a7,80065e <vprintfmt+0x330>
  800418:	000b3403          	ld	s0,0(s6)
  80041c:	26044563          	bltz	s0,800686 <vprintfmt+0x358>
  800420:	86a2                	mv	a3,s0
  800422:	8b52                	mv	s6,s4
  800424:	4729                	li	a4,10
  800426:	a051                	j	8004aa <vprintfmt+0x17c>
  800428:	000b2783          	lw	a5,0(s6)
  80042c:	46e1                	li	a3,24
  80042e:	0b21                	addi	s6,s6,8
  800430:	41f7d71b          	sraiw	a4,a5,0x1f
  800434:	8fb9                	xor	a5,a5,a4
  800436:	40e7873b          	subw	a4,a5,a4
  80043a:	1ce6c163          	blt	a3,a4,8005fc <vprintfmt+0x2ce>
  80043e:	00371793          	slli	a5,a4,0x3
  800442:	00000697          	auipc	a3,0x0
  800446:	6a668693          	addi	a3,a3,1702 # 800ae8 <error_string>
  80044a:	97b6                	add	a5,a5,a3
  80044c:	639c                	ld	a5,0(a5)
  80044e:	1a078763          	beqz	a5,8005fc <vprintfmt+0x2ce>
  800452:	873e                	mv	a4,a5
  800454:	00001697          	auipc	a3,0x1
  800458:	96468693          	addi	a3,a3,-1692 # 800db8 <error_string+0x2d0>
  80045c:	8626                	mv	a2,s1
  80045e:	85ca                	mv	a1,s2
  800460:	854e                	mv	a0,s3
  800462:	25a000ef          	jal	ra,8006bc <printfmt>
  800466:	bdf5                	j	800362 <vprintfmt+0x34>
  800468:	00144603          	lbu	a2,1(s0)
  80046c:	2885                	addiw	a7,a7,1
  80046e:	846e                	mv	s0,s11
  800470:	bf0d                	j	8003a2 <vprintfmt+0x74>
  800472:	4705                	li	a4,1
  800474:	008b0613          	addi	a2,s6,8
  800478:	01174463          	blt	a4,a7,800480 <vprintfmt+0x152>
  80047c:	1e088e63          	beqz	a7,800678 <vprintfmt+0x34a>
  800480:	000b3683          	ld	a3,0(s6)
  800484:	4721                	li	a4,8
  800486:	8b32                	mv	s6,a2
  800488:	a00d                	j	8004aa <vprintfmt+0x17c>
  80048a:	03000513          	li	a0,48
  80048e:	864a                	mv	a2,s2
  800490:	85a6                	mv	a1,s1
  800492:	e042                	sd	a6,0(sp)
  800494:	9982                	jalr	s3
  800496:	864a                	mv	a2,s2
  800498:	85a6                	mv	a1,s1
  80049a:	07800513          	li	a0,120
  80049e:	9982                	jalr	s3
  8004a0:	0b21                	addi	s6,s6,8
  8004a2:	ff8b3683          	ld	a3,-8(s6)
  8004a6:	6802                	ld	a6,0(sp)
  8004a8:	4741                	li	a4,16
  8004aa:	87e6                	mv	a5,s9
  8004ac:	8626                	mv	a2,s1
  8004ae:	85ca                	mv	a1,s2
  8004b0:	854e                	mv	a0,s3
  8004b2:	e07ff0ef          	jal	ra,8002b8 <printnum>
  8004b6:	b575                	j	800362 <vprintfmt+0x34>
  8004b8:	000b3703          	ld	a4,0(s6)
  8004bc:	0b21                	addi	s6,s6,8
  8004be:	1e070063          	beqz	a4,80069e <vprintfmt+0x370>
  8004c2:	00170413          	addi	s0,a4,1
  8004c6:	19905563          	blez	s9,800650 <vprintfmt+0x322>
  8004ca:	02d00613          	li	a2,45
  8004ce:	14c81963          	bne	a6,a2,800620 <vprintfmt+0x2f2>
  8004d2:	00074703          	lbu	a4,0(a4)
  8004d6:	0007051b          	sext.w	a0,a4
  8004da:	c90d                	beqz	a0,80050c <vprintfmt+0x1de>
  8004dc:	000d4563          	bltz	s10,8004e6 <vprintfmt+0x1b8>
  8004e0:	3d7d                	addiw	s10,s10,-1
  8004e2:	037d0363          	beq	s10,s7,800508 <vprintfmt+0x1da>
  8004e6:	864a                	mv	a2,s2
  8004e8:	85a6                	mv	a1,s1
  8004ea:	180a0c63          	beqz	s4,800682 <vprintfmt+0x354>
  8004ee:	3701                	addiw	a4,a4,-32
  8004f0:	18ec7963          	bleu	a4,s8,800682 <vprintfmt+0x354>
  8004f4:	03f00513          	li	a0,63
  8004f8:	9982                	jalr	s3
  8004fa:	0405                	addi	s0,s0,1
  8004fc:	fff44703          	lbu	a4,-1(s0)
  800500:	3cfd                	addiw	s9,s9,-1
  800502:	0007051b          	sext.w	a0,a4
  800506:	f979                	bnez	a0,8004dc <vprintfmt+0x1ae>
  800508:	e5905de3          	blez	s9,800362 <vprintfmt+0x34>
  80050c:	3cfd                	addiw	s9,s9,-1
  80050e:	864a                	mv	a2,s2
  800510:	85a6                	mv	a1,s1
  800512:	02000513          	li	a0,32
  800516:	9982                	jalr	s3
  800518:	e40c85e3          	beqz	s9,800362 <vprintfmt+0x34>
  80051c:	3cfd                	addiw	s9,s9,-1
  80051e:	864a                	mv	a2,s2
  800520:	85a6                	mv	a1,s1
  800522:	02000513          	li	a0,32
  800526:	9982                	jalr	s3
  800528:	fe0c92e3          	bnez	s9,80050c <vprintfmt+0x1de>
  80052c:	bd1d                	j	800362 <vprintfmt+0x34>
  80052e:	4705                	li	a4,1
  800530:	008b0613          	addi	a2,s6,8
  800534:	01174463          	blt	a4,a7,80053c <vprintfmt+0x20e>
  800538:	12088663          	beqz	a7,800664 <vprintfmt+0x336>
  80053c:	000b3683          	ld	a3,0(s6)
  800540:	4729                	li	a4,10
  800542:	8b32                	mv	s6,a2
  800544:	b79d                	j	8004aa <vprintfmt+0x17c>
  800546:	00144603          	lbu	a2,1(s0)
  80054a:	02d00813          	li	a6,45
  80054e:	846e                	mv	s0,s11
  800550:	bd89                	j	8003a2 <vprintfmt+0x74>
  800552:	864a                	mv	a2,s2
  800554:	85a6                	mv	a1,s1
  800556:	02500513          	li	a0,37
  80055a:	9982                	jalr	s3
  80055c:	b519                	j	800362 <vprintfmt+0x34>
  80055e:	000b2d03          	lw	s10,0(s6)
  800562:	00144603          	lbu	a2,1(s0)
  800566:	0b21                	addi	s6,s6,8
  800568:	846e                	mv	s0,s11
  80056a:	e20cdce3          	bgez	s9,8003a2 <vprintfmt+0x74>
  80056e:	8cea                	mv	s9,s10
  800570:	5d7d                	li	s10,-1
  800572:	bd05                	j	8003a2 <vprintfmt+0x74>
  800574:	00144603          	lbu	a2,1(s0)
  800578:	03000813          	li	a6,48
  80057c:	846e                	mv	s0,s11
  80057e:	b515                	j	8003a2 <vprintfmt+0x74>
  800580:	fd060d1b          	addiw	s10,a2,-48
  800584:	00144603          	lbu	a2,1(s0)
  800588:	846e                	mv	s0,s11
  80058a:	fd06071b          	addiw	a4,a2,-48
  80058e:	0006031b          	sext.w	t1,a2
  800592:	fce56ce3          	bltu	a0,a4,80056a <vprintfmt+0x23c>
  800596:	0405                	addi	s0,s0,1
  800598:	002d171b          	slliw	a4,s10,0x2
  80059c:	00044603          	lbu	a2,0(s0)
  8005a0:	01a706bb          	addw	a3,a4,s10
  8005a4:	0016969b          	slliw	a3,a3,0x1
  8005a8:	006686bb          	addw	a3,a3,t1
  8005ac:	fd06071b          	addiw	a4,a2,-48
  8005b0:	fd068d1b          	addiw	s10,a3,-48
  8005b4:	0006031b          	sext.w	t1,a2
  8005b8:	fce57fe3          	bleu	a4,a0,800596 <vprintfmt+0x268>
  8005bc:	b77d                	j	80056a <vprintfmt+0x23c>
  8005be:	fffcc713          	not	a4,s9
  8005c2:	977d                	srai	a4,a4,0x3f
  8005c4:	00ecf7b3          	and	a5,s9,a4
  8005c8:	00144603          	lbu	a2,1(s0)
  8005cc:	00078c9b          	sext.w	s9,a5
  8005d0:	846e                	mv	s0,s11
  8005d2:	bbc1                	j	8003a2 <vprintfmt+0x74>
  8005d4:	864a                	mv	a2,s2
  8005d6:	85a6                	mv	a1,s1
  8005d8:	02500513          	li	a0,37
  8005dc:	9982                	jalr	s3
  8005de:	fff44703          	lbu	a4,-1(s0)
  8005e2:	02500793          	li	a5,37
  8005e6:	8da2                	mv	s11,s0
  8005e8:	d6f70de3          	beq	a4,a5,800362 <vprintfmt+0x34>
  8005ec:	02500713          	li	a4,37
  8005f0:	1dfd                	addi	s11,s11,-1
  8005f2:	fffdc783          	lbu	a5,-1(s11)
  8005f6:	fee79de3          	bne	a5,a4,8005f0 <vprintfmt+0x2c2>
  8005fa:	b3a5                	j	800362 <vprintfmt+0x34>
  8005fc:	00000697          	auipc	a3,0x0
  800600:	7ac68693          	addi	a3,a3,1964 # 800da8 <error_string+0x2c0>
  800604:	8626                	mv	a2,s1
  800606:	85ca                	mv	a1,s2
  800608:	854e                	mv	a0,s3
  80060a:	0b2000ef          	jal	ra,8006bc <printfmt>
  80060e:	bb91                	j	800362 <vprintfmt+0x34>
  800610:	00000717          	auipc	a4,0x0
  800614:	79070713          	addi	a4,a4,1936 # 800da0 <error_string+0x2b8>
  800618:	00000417          	auipc	s0,0x0
  80061c:	78940413          	addi	s0,s0,1929 # 800da1 <error_string+0x2b9>
  800620:	853a                	mv	a0,a4
  800622:	85ea                	mv	a1,s10
  800624:	e03a                	sd	a4,0(sp)
  800626:	e442                	sd	a6,8(sp)
  800628:	0b2000ef          	jal	ra,8006da <strnlen>
  80062c:	40ac8cbb          	subw	s9,s9,a0
  800630:	6702                	ld	a4,0(sp)
  800632:	01905f63          	blez	s9,800650 <vprintfmt+0x322>
  800636:	6822                	ld	a6,8(sp)
  800638:	0008079b          	sext.w	a5,a6
  80063c:	e43e                	sd	a5,8(sp)
  80063e:	6522                	ld	a0,8(sp)
  800640:	864a                	mv	a2,s2
  800642:	85a6                	mv	a1,s1
  800644:	e03a                	sd	a4,0(sp)
  800646:	3cfd                	addiw	s9,s9,-1
  800648:	9982                	jalr	s3
  80064a:	6702                	ld	a4,0(sp)
  80064c:	fe0c99e3          	bnez	s9,80063e <vprintfmt+0x310>
  800650:	00074703          	lbu	a4,0(a4)
  800654:	0007051b          	sext.w	a0,a4
  800658:	e80512e3          	bnez	a0,8004dc <vprintfmt+0x1ae>
  80065c:	b319                	j	800362 <vprintfmt+0x34>
  80065e:	000b2403          	lw	s0,0(s6)
  800662:	bb6d                	j	80041c <vprintfmt+0xee>
  800664:	000b6683          	lwu	a3,0(s6)
  800668:	4729                	li	a4,10
  80066a:	8b32                	mv	s6,a2
  80066c:	bd3d                	j	8004aa <vprintfmt+0x17c>
  80066e:	000b6683          	lwu	a3,0(s6)
  800672:	4741                	li	a4,16
  800674:	8b32                	mv	s6,a2
  800676:	bd15                	j	8004aa <vprintfmt+0x17c>
  800678:	000b6683          	lwu	a3,0(s6)
  80067c:	4721                	li	a4,8
  80067e:	8b32                	mv	s6,a2
  800680:	b52d                	j	8004aa <vprintfmt+0x17c>
  800682:	9982                	jalr	s3
  800684:	bd9d                	j	8004fa <vprintfmt+0x1cc>
  800686:	864a                	mv	a2,s2
  800688:	85a6                	mv	a1,s1
  80068a:	02d00513          	li	a0,45
  80068e:	e042                	sd	a6,0(sp)
  800690:	9982                	jalr	s3
  800692:	8b52                	mv	s6,s4
  800694:	408006b3          	neg	a3,s0
  800698:	4729                	li	a4,10
  80069a:	6802                	ld	a6,0(sp)
  80069c:	b539                	j	8004aa <vprintfmt+0x17c>
  80069e:	01905663          	blez	s9,8006aa <vprintfmt+0x37c>
  8006a2:	02d00713          	li	a4,45
  8006a6:	f6e815e3          	bne	a6,a4,800610 <vprintfmt+0x2e2>
  8006aa:	00000417          	auipc	s0,0x0
  8006ae:	6f740413          	addi	s0,s0,1783 # 800da1 <error_string+0x2b9>
  8006b2:	02800513          	li	a0,40
  8006b6:	02800713          	li	a4,40
  8006ba:	b50d                	j	8004dc <vprintfmt+0x1ae>

00000000008006bc <printfmt>:
  8006bc:	7139                	addi	sp,sp,-64
  8006be:	02010313          	addi	t1,sp,32
  8006c2:	f03a                	sd	a4,32(sp)
  8006c4:	871a                	mv	a4,t1
  8006c6:	ec06                	sd	ra,24(sp)
  8006c8:	f43e                	sd	a5,40(sp)
  8006ca:	f842                	sd	a6,48(sp)
  8006cc:	fc46                	sd	a7,56(sp)
  8006ce:	e41a                	sd	t1,8(sp)
  8006d0:	c5fff0ef          	jal	ra,80032e <vprintfmt>
  8006d4:	60e2                	ld	ra,24(sp)
  8006d6:	6121                	addi	sp,sp,64
  8006d8:	8082                	ret

00000000008006da <strnlen>:
  8006da:	c185                	beqz	a1,8006fa <strnlen+0x20>
  8006dc:	00054783          	lbu	a5,0(a0)
  8006e0:	cf89                	beqz	a5,8006fa <strnlen+0x20>
  8006e2:	4781                	li	a5,0
  8006e4:	a021                	j	8006ec <strnlen+0x12>
  8006e6:	00074703          	lbu	a4,0(a4)
  8006ea:	c711                	beqz	a4,8006f6 <strnlen+0x1c>
  8006ec:	0785                	addi	a5,a5,1
  8006ee:	00f50733          	add	a4,a0,a5
  8006f2:	fef59ae3          	bne	a1,a5,8006e6 <strnlen+0xc>
  8006f6:	853e                	mv	a0,a5
  8006f8:	8082                	ret
  8006fa:	4781                	li	a5,0
  8006fc:	853e                	mv	a0,a5
  8006fe:	8082                	ret

0000000000800700 <memset>:
  800700:	ca01                	beqz	a2,800710 <memset+0x10>
  800702:	962a                	add	a2,a2,a0
  800704:	87aa                	mv	a5,a0
  800706:	0785                	addi	a5,a5,1
  800708:	feb78fa3          	sb	a1,-1(a5)
  80070c:	fec79de3          	bne	a5,a2,800706 <memset+0x6>
  800710:	8082                	ret

0000000000800712 <main>:
  800712:	711d                	addi	sp,sp,-96
  800714:	4651                	li	a2,20
  800716:	4581                	li	a1,0
  800718:	00001517          	auipc	a0,0x1
  80071c:	91850513          	addi	a0,a0,-1768 # 801030 <pids>
  800720:	ec86                	sd	ra,88(sp)
  800722:	e8a2                	sd	s0,80(sp)
  800724:	e4a6                	sd	s1,72(sp)
  800726:	e0ca                	sd	s2,64(sp)
  800728:	fc4e                	sd	s3,56(sp)
  80072a:	f852                	sd	s4,48(sp)
  80072c:	f456                	sd	s5,40(sp)
  80072e:	f05a                	sd	s6,32(sp)
  800730:	ec5e                	sd	s7,24(sp)
  800732:	fcfff0ef          	jal	ra,800700 <memset>
  800736:	4519                	li	a0,6
  800738:	00001a97          	auipc	s5,0x1
  80073c:	8c8a8a93          	addi	s5,s5,-1848 # 801000 <acc>
  800740:	00001917          	auipc	s2,0x1
  800744:	8f090913          	addi	s2,s2,-1808 # 801030 <pids>
  800748:	aadff0ef          	jal	ra,8001f4 <lab6_set_priority>
  80074c:	89d6                	mv	s3,s5
  80074e:	84ca                	mv	s1,s2
  800750:	4401                	li	s0,0
  800752:	4a15                	li	s4,5
  800754:	0009a023          	sw	zero,0(s3)
  800758:	a89ff0ef          	jal	ra,8001e0 <fork>
  80075c:	c088                	sw	a0,0(s1)
  80075e:	c969                	beqz	a0,800830 <main+0x11e>
  800760:	12054d63          	bltz	a0,80089a <main+0x188>
  800764:	2405                	addiw	s0,s0,1
  800766:	0991                	addi	s3,s3,4
  800768:	0491                	addi	s1,s1,4
  80076a:	ff4415e3          	bne	s0,s4,800754 <main+0x42>
  80076e:	00001497          	auipc	s1,0x1
  800772:	8aa48493          	addi	s1,s1,-1878 # 801018 <status>
  800776:	00000517          	auipc	a0,0x0
  80077a:	66a50513          	addi	a0,a0,1642 # 800de0 <error_string+0x2f8>
  80077e:	97bff0ef          	jal	ra,8000f8 <cprintf>
  800782:	00001997          	auipc	s3,0x1
  800786:	8aa98993          	addi	s3,s3,-1878 # 80102c <status+0x14>
  80078a:	8a26                	mv	s4,s1
  80078c:	8426                	mv	s0,s1
  80078e:	00000b97          	auipc	s7,0x0
  800792:	67ab8b93          	addi	s7,s7,1658 # 800e08 <error_string+0x320>
  800796:	00092503          	lw	a0,0(s2)
  80079a:	85a2                	mv	a1,s0
  80079c:	00042023          	sw	zero,0(s0)
  8007a0:	a45ff0ef          	jal	ra,8001e4 <waitpid>
  8007a4:	00092a83          	lw	s5,0(s2)
  8007a8:	00042b03          	lw	s6,0(s0)
  8007ac:	a45ff0ef          	jal	ra,8001f0 <gettime_msec>
  8007b0:	0005069b          	sext.w	a3,a0
  8007b4:	865a                	mv	a2,s6
  8007b6:	85d6                	mv	a1,s5
  8007b8:	855e                	mv	a0,s7
  8007ba:	0411                	addi	s0,s0,4
  8007bc:	93dff0ef          	jal	ra,8000f8 <cprintf>
  8007c0:	0911                	addi	s2,s2,4
  8007c2:	fd341ae3          	bne	s0,s3,800796 <main+0x84>
  8007c6:	00000517          	auipc	a0,0x0
  8007ca:	66250513          	addi	a0,a0,1634 # 800e28 <error_string+0x340>
  8007ce:	92bff0ef          	jal	ra,8000f8 <cprintf>
  8007d2:	00000517          	auipc	a0,0x0
  8007d6:	66e50513          	addi	a0,a0,1646 # 800e40 <error_string+0x358>
  8007da:	91fff0ef          	jal	ra,8000f8 <cprintf>
  8007de:	00000417          	auipc	s0,0x0
  8007e2:	68240413          	addi	s0,s0,1666 # 800e60 <error_string+0x378>
  8007e6:	408c                	lw	a1,0(s1)
  8007e8:	000a2783          	lw	a5,0(s4)
  8007ec:	0491                	addi	s1,s1,4
  8007ee:	0015959b          	slliw	a1,a1,0x1
  8007f2:	02f5c5bb          	divw	a1,a1,a5
  8007f6:	8522                	mv	a0,s0
  8007f8:	2585                	addiw	a1,a1,1
  8007fa:	01f5d79b          	srliw	a5,a1,0x1f
  8007fe:	9dbd                	addw	a1,a1,a5
  800800:	4015d59b          	sraiw	a1,a1,0x1
  800804:	8f5ff0ef          	jal	ra,8000f8 <cprintf>
  800808:	fd349fe3          	bne	s1,s3,8007e6 <main+0xd4>
  80080c:	00000517          	auipc	a0,0x0
  800810:	13c50513          	addi	a0,a0,316 # 800948 <main+0x236>
  800814:	8e5ff0ef          	jal	ra,8000f8 <cprintf>
  800818:	60e6                	ld	ra,88(sp)
  80081a:	6446                	ld	s0,80(sp)
  80081c:	64a6                	ld	s1,72(sp)
  80081e:	6906                	ld	s2,64(sp)
  800820:	79e2                	ld	s3,56(sp)
  800822:	7a42                	ld	s4,48(sp)
  800824:	7aa2                	ld	s5,40(sp)
  800826:	7b02                	ld	s6,32(sp)
  800828:	6be2                	ld	s7,24(sp)
  80082a:	4501                	li	a0,0
  80082c:	6125                	addi	sp,sp,96
  80082e:	8082                	ret
  800830:	0014051b          	addiw	a0,s0,1
  800834:	040a                	slli	s0,s0,0x2
  800836:	9456                	add	s0,s0,s5
  800838:	6485                	lui	s1,0x1
  80083a:	6909                	lui	s2,0x2
  80083c:	9b9ff0ef          	jal	ra,8001f4 <lab6_set_priority>
  800840:	fa04849b          	addiw	s1,s1,-96
  800844:	00042023          	sw	zero,0(s0)
  800848:	71090913          	addi	s2,s2,1808 # 2710 <open-0x7fd910>
  80084c:	4014                	lw	a3,0(s0)
  80084e:	2685                	addiw	a3,a3,1
  800850:	0c800713          	li	a4,200
  800854:	47b2                	lw	a5,12(sp)
  800856:	377d                	addiw	a4,a4,-1
  800858:	2781                	sext.w	a5,a5
  80085a:	0017b793          	seqz	a5,a5
  80085e:	c63e                	sw	a5,12(sp)
  800860:	fb75                	bnez	a4,800854 <main+0x142>
  800862:	0296f7bb          	remuw	a5,a3,s1
  800866:	0016871b          	addiw	a4,a3,1
  80086a:	c399                	beqz	a5,800870 <main+0x15e>
  80086c:	86ba                	mv	a3,a4
  80086e:	b7cd                	j	800850 <main+0x13e>
  800870:	c014                	sw	a3,0(s0)
  800872:	97fff0ef          	jal	ra,8001f0 <gettime_msec>
  800876:	0005099b          	sext.w	s3,a0
  80087a:	fd3959e3          	ble	s3,s2,80084c <main+0x13a>
  80087e:	96fff0ef          	jal	ra,8001ec <getpid>
  800882:	4010                	lw	a2,0(s0)
  800884:	85aa                	mv	a1,a0
  800886:	86ce                	mv	a3,s3
  800888:	00000517          	auipc	a0,0x0
  80088c:	53850513          	addi	a0,a0,1336 # 800dc0 <error_string+0x2d8>
  800890:	869ff0ef          	jal	ra,8000f8 <cprintf>
  800894:	4008                	lw	a0,0(s0)
  800896:	935ff0ef          	jal	ra,8001ca <exit>
  80089a:	00000417          	auipc	s0,0x0
  80089e:	7aa40413          	addi	s0,s0,1962 # 801044 <pids+0x14>
  8008a2:	00092503          	lw	a0,0(s2)
  8008a6:	00a05463          	blez	a0,8008ae <main+0x19c>
  8008aa:	93fff0ef          	jal	ra,8001e8 <kill>
  8008ae:	0911                	addi	s2,s2,4
  8008b0:	ff2419e3          	bne	s0,s2,8008a2 <main+0x190>
  8008b4:	00000617          	auipc	a2,0x0
  8008b8:	5b460613          	addi	a2,a2,1460 # 800e68 <error_string+0x380>
  8008bc:	04b00593          	li	a1,75
  8008c0:	00000517          	auipc	a0,0x0
  8008c4:	5b850513          	addi	a0,a0,1464 # 800e78 <error_string+0x390>
  8008c8:	f6eff0ef          	jal	ra,800036 <__panic>
