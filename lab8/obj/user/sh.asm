
obj/__user_sh.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	2160006f          	j	80023a <sys_open>

0000000000800028 <close>:
  800028:	21e0006f          	j	800246 <sys_close>

000000000080002c <read>:
  80002c:	2240006f          	j	800250 <sys_read>

0000000000800030 <write>:
  800030:	22e0006f          	j	80025e <sys_write>

0000000000800034 <dup2>:
  800034:	2380006f          	j	80026c <sys_dup>

0000000000800038 <_start>:
  800038:	2c4000ef          	jal	ra,8002fc <umain>
  80003c:	a001                	j	80003c <_start+0x4>

000000000080003e <__panic>:
  80003e:	715d                	addi	sp,sp,-80
  800040:	e822                	sd	s0,16(sp)
  800042:	fc3e                	sd	a5,56(sp)
  800044:	8432                	mv	s0,a2
  800046:	103c                	addi	a5,sp,40
  800048:	862e                	mv	a2,a1
  80004a:	85aa                	mv	a1,a0
  80004c:	00001517          	auipc	a0,0x1
  800050:	d4c50513          	addi	a0,a0,-692 # 800d98 <main+0xce>
  800054:	ec06                	sd	ra,24(sp)
  800056:	f436                	sd	a3,40(sp)
  800058:	f83a                	sd	a4,48(sp)
  80005a:	e0c2                	sd	a6,64(sp)
  80005c:	e4c6                	sd	a7,72(sp)
  80005e:	e43e                	sd	a5,8(sp)
  800060:	0c8000ef          	jal	ra,800128 <cprintf>
  800064:	65a2                	ld	a1,8(sp)
  800066:	8522                	mv	a0,s0
  800068:	09a000ef          	jal	ra,800102 <vcprintf>
  80006c:	00001517          	auipc	a0,0x1
  800070:	da450513          	addi	a0,a0,-604 # 800e10 <main+0x146>
  800074:	0b4000ef          	jal	ra,800128 <cprintf>
  800078:	5559                	li	a0,-10
  80007a:	1fe000ef          	jal	ra,800278 <exit>

000000000080007e <__warn>:
  80007e:	715d                	addi	sp,sp,-80
  800080:	e822                	sd	s0,16(sp)
  800082:	fc3e                	sd	a5,56(sp)
  800084:	8432                	mv	s0,a2
  800086:	103c                	addi	a5,sp,40
  800088:	862e                	mv	a2,a1
  80008a:	85aa                	mv	a1,a0
  80008c:	00001517          	auipc	a0,0x1
  800090:	d2c50513          	addi	a0,a0,-724 # 800db8 <main+0xee>
  800094:	ec06                	sd	ra,24(sp)
  800096:	f436                	sd	a3,40(sp)
  800098:	f83a                	sd	a4,48(sp)
  80009a:	e0c2                	sd	a6,64(sp)
  80009c:	e4c6                	sd	a7,72(sp)
  80009e:	e43e                	sd	a5,8(sp)
  8000a0:	088000ef          	jal	ra,800128 <cprintf>
  8000a4:	65a2                	ld	a1,8(sp)
  8000a6:	8522                	mv	a0,s0
  8000a8:	05a000ef          	jal	ra,800102 <vcprintf>
  8000ac:	00001517          	auipc	a0,0x1
  8000b0:	d6450513          	addi	a0,a0,-668 # 800e10 <main+0x146>
  8000b4:	074000ef          	jal	ra,800128 <cprintf>
  8000b8:	60e2                	ld	ra,24(sp)
  8000ba:	6442                	ld	s0,16(sp)
  8000bc:	6161                	addi	sp,sp,80
  8000be:	8082                	ret

00000000008000c0 <cputch>:
  8000c0:	1141                	addi	sp,sp,-16
  8000c2:	e022                	sd	s0,0(sp)
  8000c4:	e406                	sd	ra,8(sp)
  8000c6:	842e                	mv	s0,a1
  8000c8:	15e000ef          	jal	ra,800226 <sys_putc>
  8000cc:	401c                	lw	a5,0(s0)
  8000ce:	60a2                	ld	ra,8(sp)
  8000d0:	2785                	addiw	a5,a5,1
  8000d2:	c01c                	sw	a5,0(s0)
  8000d4:	6402                	ld	s0,0(sp)
  8000d6:	0141                	addi	sp,sp,16
  8000d8:	8082                	ret

00000000008000da <fputch>:
  8000da:	1101                	addi	sp,sp,-32
  8000dc:	87b2                	mv	a5,a2
  8000de:	e822                	sd	s0,16(sp)
  8000e0:	00a107a3          	sb	a0,15(sp)
  8000e4:	842e                	mv	s0,a1
  8000e6:	853e                	mv	a0,a5
  8000e8:	00f10593          	addi	a1,sp,15
  8000ec:	4605                	li	a2,1
  8000ee:	ec06                	sd	ra,24(sp)
  8000f0:	f41ff0ef          	jal	ra,800030 <write>
  8000f4:	401c                	lw	a5,0(s0)
  8000f6:	60e2                	ld	ra,24(sp)
  8000f8:	2785                	addiw	a5,a5,1
  8000fa:	c01c                	sw	a5,0(s0)
  8000fc:	6442                	ld	s0,16(sp)
  8000fe:	6105                	addi	sp,sp,32
  800100:	8082                	ret

0000000000800102 <vcprintf>:
  800102:	1101                	addi	sp,sp,-32
  800104:	872e                	mv	a4,a1
  800106:	75dd                	lui	a1,0xffff7
  800108:	86aa                	mv	a3,a0
  80010a:	0070                	addi	a2,sp,12
  80010c:	00000517          	auipc	a0,0x0
  800110:	fb450513          	addi	a0,a0,-76 # 8000c0 <cputch>
  800114:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <buffer.1212+0xffffffffff7f29d1>
  800118:	ec06                	sd	ra,24(sp)
  80011a:	c602                	sw	zero,12(sp)
  80011c:	2e8000ef          	jal	ra,800404 <vprintfmt>
  800120:	60e2                	ld	ra,24(sp)
  800122:	4532                	lw	a0,12(sp)
  800124:	6105                	addi	sp,sp,32
  800126:	8082                	ret

0000000000800128 <cprintf>:
  800128:	711d                	addi	sp,sp,-96
  80012a:	02810313          	addi	t1,sp,40
  80012e:	f42e                	sd	a1,40(sp)
  800130:	75dd                	lui	a1,0xffff7
  800132:	f832                	sd	a2,48(sp)
  800134:	fc36                	sd	a3,56(sp)
  800136:	e0ba                	sd	a4,64(sp)
  800138:	86aa                	mv	a3,a0
  80013a:	0050                	addi	a2,sp,4
  80013c:	00000517          	auipc	a0,0x0
  800140:	f8450513          	addi	a0,a0,-124 # 8000c0 <cputch>
  800144:	871a                	mv	a4,t1
  800146:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <buffer.1212+0xffffffffff7f29d1>
  80014a:	ec06                	sd	ra,24(sp)
  80014c:	e4be                	sd	a5,72(sp)
  80014e:	e8c2                	sd	a6,80(sp)
  800150:	ecc6                	sd	a7,88(sp)
  800152:	e41a                	sd	t1,8(sp)
  800154:	c202                	sw	zero,4(sp)
  800156:	2ae000ef          	jal	ra,800404 <vprintfmt>
  80015a:	60e2                	ld	ra,24(sp)
  80015c:	4512                	lw	a0,4(sp)
  80015e:	6125                	addi	sp,sp,96
  800160:	8082                	ret

0000000000800162 <cputs>:
  800162:	1101                	addi	sp,sp,-32
  800164:	e822                	sd	s0,16(sp)
  800166:	ec06                	sd	ra,24(sp)
  800168:	e426                	sd	s1,8(sp)
  80016a:	842a                	mv	s0,a0
  80016c:	00054503          	lbu	a0,0(a0)
  800170:	c51d                	beqz	a0,80019e <cputs+0x3c>
  800172:	0405                	addi	s0,s0,1
  800174:	4485                	li	s1,1
  800176:	9c81                	subw	s1,s1,s0
  800178:	0ae000ef          	jal	ra,800226 <sys_putc>
  80017c:	008487bb          	addw	a5,s1,s0
  800180:	0405                	addi	s0,s0,1
  800182:	fff44503          	lbu	a0,-1(s0)
  800186:	f96d                	bnez	a0,800178 <cputs+0x16>
  800188:	0017841b          	addiw	s0,a5,1
  80018c:	4529                	li	a0,10
  80018e:	098000ef          	jal	ra,800226 <sys_putc>
  800192:	8522                	mv	a0,s0
  800194:	60e2                	ld	ra,24(sp)
  800196:	6442                	ld	s0,16(sp)
  800198:	64a2                	ld	s1,8(sp)
  80019a:	6105                	addi	sp,sp,32
  80019c:	8082                	ret
  80019e:	4405                	li	s0,1
  8001a0:	b7f5                	j	80018c <cputs+0x2a>

00000000008001a2 <fprintf>:
  8001a2:	715d                	addi	sp,sp,-80
  8001a4:	02010313          	addi	t1,sp,32
  8001a8:	f032                	sd	a2,32(sp)
  8001aa:	f436                	sd	a3,40(sp)
  8001ac:	f83a                	sd	a4,48(sp)
  8001ae:	86ae                	mv	a3,a1
  8001b0:	0050                	addi	a2,sp,4
  8001b2:	85aa                	mv	a1,a0
  8001b4:	871a                	mv	a4,t1
  8001b6:	00000517          	auipc	a0,0x0
  8001ba:	f2450513          	addi	a0,a0,-220 # 8000da <fputch>
  8001be:	ec06                	sd	ra,24(sp)
  8001c0:	fc3e                	sd	a5,56(sp)
  8001c2:	e0c2                	sd	a6,64(sp)
  8001c4:	e4c6                	sd	a7,72(sp)
  8001c6:	e41a                	sd	t1,8(sp)
  8001c8:	c202                	sw	zero,4(sp)
  8001ca:	23a000ef          	jal	ra,800404 <vprintfmt>
  8001ce:	60e2                	ld	ra,24(sp)
  8001d0:	4512                	lw	a0,4(sp)
  8001d2:	6161                	addi	sp,sp,80
  8001d4:	8082                	ret

00000000008001d6 <syscall>:
  8001d6:	7175                	addi	sp,sp,-144
  8001d8:	f8ba                	sd	a4,112(sp)
  8001da:	e0ba                	sd	a4,64(sp)
  8001dc:	0118                	addi	a4,sp,128
  8001de:	e42a                	sd	a0,8(sp)
  8001e0:	ecae                	sd	a1,88(sp)
  8001e2:	f0b2                	sd	a2,96(sp)
  8001e4:	f4b6                	sd	a3,104(sp)
  8001e6:	fcbe                	sd	a5,120(sp)
  8001e8:	e142                	sd	a6,128(sp)
  8001ea:	e546                	sd	a7,136(sp)
  8001ec:	f42e                	sd	a1,40(sp)
  8001ee:	f832                	sd	a2,48(sp)
  8001f0:	fc36                	sd	a3,56(sp)
  8001f2:	f03a                	sd	a4,32(sp)
  8001f4:	e4be                	sd	a5,72(sp)
  8001f6:	4522                	lw	a0,8(sp)
  8001f8:	55a2                	lw	a1,40(sp)
  8001fa:	5642                	lw	a2,48(sp)
  8001fc:	56e2                	lw	a3,56(sp)
  8001fe:	4706                	lw	a4,64(sp)
  800200:	47a6                	lw	a5,72(sp)
  800202:	00000073          	ecall
  800206:	ce2a                	sw	a0,28(sp)
  800208:	4572                	lw	a0,28(sp)
  80020a:	6149                	addi	sp,sp,144
  80020c:	8082                	ret

000000000080020e <sys_exit>:
  80020e:	85aa                	mv	a1,a0
  800210:	4505                	li	a0,1
  800212:	fc5ff06f          	j	8001d6 <syscall>

0000000000800216 <sys_fork>:
  800216:	4509                	li	a0,2
  800218:	fbfff06f          	j	8001d6 <syscall>

000000000080021c <sys_wait>:
  80021c:	862e                	mv	a2,a1
  80021e:	85aa                	mv	a1,a0
  800220:	450d                	li	a0,3
  800222:	fb5ff06f          	j	8001d6 <syscall>

0000000000800226 <sys_putc>:
  800226:	85aa                	mv	a1,a0
  800228:	4579                	li	a0,30
  80022a:	fadff06f          	j	8001d6 <syscall>

000000000080022e <sys_exec>:
  80022e:	86b2                	mv	a3,a2
  800230:	862e                	mv	a2,a1
  800232:	85aa                	mv	a1,a0
  800234:	4511                	li	a0,4
  800236:	fa1ff06f          	j	8001d6 <syscall>

000000000080023a <sys_open>:
  80023a:	862e                	mv	a2,a1
  80023c:	85aa                	mv	a1,a0
  80023e:	06400513          	li	a0,100
  800242:	f95ff06f          	j	8001d6 <syscall>

0000000000800246 <sys_close>:
  800246:	85aa                	mv	a1,a0
  800248:	06500513          	li	a0,101
  80024c:	f8bff06f          	j	8001d6 <syscall>

0000000000800250 <sys_read>:
  800250:	86b2                	mv	a3,a2
  800252:	862e                	mv	a2,a1
  800254:	85aa                	mv	a1,a0
  800256:	06600513          	li	a0,102
  80025a:	f7dff06f          	j	8001d6 <syscall>

000000000080025e <sys_write>:
  80025e:	86b2                	mv	a3,a2
  800260:	862e                	mv	a2,a1
  800262:	85aa                	mv	a1,a0
  800264:	06700513          	li	a0,103
  800268:	f6fff06f          	j	8001d6 <syscall>

000000000080026c <sys_dup>:
  80026c:	862e                	mv	a2,a1
  80026e:	85aa                	mv	a1,a0
  800270:	08200513          	li	a0,130
  800274:	f63ff06f          	j	8001d6 <syscall>

0000000000800278 <exit>:
  800278:	1141                	addi	sp,sp,-16
  80027a:	e406                	sd	ra,8(sp)
  80027c:	f93ff0ef          	jal	ra,80020e <sys_exit>
  800280:	00001517          	auipc	a0,0x1
  800284:	b5850513          	addi	a0,a0,-1192 # 800dd8 <main+0x10e>
  800288:	ea1ff0ef          	jal	ra,800128 <cprintf>
  80028c:	a001                	j	80028c <exit+0x14>

000000000080028e <fork>:
  80028e:	f89ff06f          	j	800216 <sys_fork>

0000000000800292 <waitpid>:
  800292:	f8bff06f          	j	80021c <sys_wait>

0000000000800296 <__exec>:
  800296:	619c                	ld	a5,0(a1)
  800298:	862e                	mv	a2,a1
  80029a:	cf81                	beqz	a5,8002b2 <__exec+0x1c>
  80029c:	00858793          	addi	a5,a1,8
  8002a0:	4701                	li	a4,0
  8002a2:	07a1                	addi	a5,a5,8
  8002a4:	ff87b683          	ld	a3,-8(a5)
  8002a8:	2705                	addiw	a4,a4,1
  8002aa:	fee5                	bnez	a3,8002a2 <__exec+0xc>
  8002ac:	85ba                	mv	a1,a4
  8002ae:	f81ff06f          	j	80022e <sys_exec>
  8002b2:	4581                	li	a1,0
  8002b4:	f7bff06f          	j	80022e <sys_exec>

00000000008002b8 <initfd>:
  8002b8:	1101                	addi	sp,sp,-32
  8002ba:	87ae                	mv	a5,a1
  8002bc:	e426                	sd	s1,8(sp)
  8002be:	85b2                	mv	a1,a2
  8002c0:	84aa                	mv	s1,a0
  8002c2:	853e                	mv	a0,a5
  8002c4:	e822                	sd	s0,16(sp)
  8002c6:	ec06                	sd	ra,24(sp)
  8002c8:	d59ff0ef          	jal	ra,800020 <open>
  8002cc:	842a                	mv	s0,a0
  8002ce:	00054463          	bltz	a0,8002d6 <initfd+0x1e>
  8002d2:	00951863          	bne	a0,s1,8002e2 <initfd+0x2a>
  8002d6:	8522                	mv	a0,s0
  8002d8:	60e2                	ld	ra,24(sp)
  8002da:	6442                	ld	s0,16(sp)
  8002dc:	64a2                	ld	s1,8(sp)
  8002de:	6105                	addi	sp,sp,32
  8002e0:	8082                	ret
  8002e2:	8526                	mv	a0,s1
  8002e4:	d45ff0ef          	jal	ra,800028 <close>
  8002e8:	85a6                	mv	a1,s1
  8002ea:	8522                	mv	a0,s0
  8002ec:	d49ff0ef          	jal	ra,800034 <dup2>
  8002f0:	84aa                	mv	s1,a0
  8002f2:	8522                	mv	a0,s0
  8002f4:	d35ff0ef          	jal	ra,800028 <close>
  8002f8:	8426                	mv	s0,s1
  8002fa:	bff1                	j	8002d6 <initfd+0x1e>

00000000008002fc <umain>:
  8002fc:	1101                	addi	sp,sp,-32
  8002fe:	e822                	sd	s0,16(sp)
  800300:	e426                	sd	s1,8(sp)
  800302:	842a                	mv	s0,a0
  800304:	84ae                	mv	s1,a1
  800306:	4601                	li	a2,0
  800308:	00001597          	auipc	a1,0x1
  80030c:	ae858593          	addi	a1,a1,-1304 # 800df0 <main+0x126>
  800310:	4501                	li	a0,0
  800312:	ec06                	sd	ra,24(sp)
  800314:	fa5ff0ef          	jal	ra,8002b8 <initfd>
  800318:	02054263          	bltz	a0,80033c <umain+0x40>
  80031c:	4605                	li	a2,1
  80031e:	00001597          	auipc	a1,0x1
  800322:	b1258593          	addi	a1,a1,-1262 # 800e30 <main+0x166>
  800326:	4505                	li	a0,1
  800328:	f91ff0ef          	jal	ra,8002b8 <initfd>
  80032c:	02054663          	bltz	a0,800358 <umain+0x5c>
  800330:	85a6                	mv	a1,s1
  800332:	8522                	mv	a0,s0
  800334:	197000ef          	jal	ra,800cca <main>
  800338:	f41ff0ef          	jal	ra,800278 <exit>
  80033c:	86aa                	mv	a3,a0
  80033e:	00001617          	auipc	a2,0x1
  800342:	aba60613          	addi	a2,a2,-1350 # 800df8 <main+0x12e>
  800346:	02000593          	li	a1,32
  80034a:	00001517          	auipc	a0,0x1
  80034e:	ace50513          	addi	a0,a0,-1330 # 800e18 <main+0x14e>
  800352:	d2dff0ef          	jal	ra,80007e <__warn>
  800356:	b7d9                	j	80031c <umain+0x20>
  800358:	86aa                	mv	a3,a0
  80035a:	00001617          	auipc	a2,0x1
  80035e:	ade60613          	addi	a2,a2,-1314 # 800e38 <main+0x16e>
  800362:	02500593          	li	a1,37
  800366:	00001517          	auipc	a0,0x1
  80036a:	ab250513          	addi	a0,a0,-1358 # 800e18 <main+0x14e>
  80036e:	d11ff0ef          	jal	ra,80007e <__warn>
  800372:	bf7d                	j	800330 <umain+0x34>

0000000000800374 <printnum>:
  800374:	02071893          	slli	a7,a4,0x20
  800378:	7139                	addi	sp,sp,-64
  80037a:	0208d893          	srli	a7,a7,0x20
  80037e:	e456                	sd	s5,8(sp)
  800380:	0316fab3          	remu	s5,a3,a7
  800384:	f822                	sd	s0,48(sp)
  800386:	f426                	sd	s1,40(sp)
  800388:	f04a                	sd	s2,32(sp)
  80038a:	ec4e                	sd	s3,24(sp)
  80038c:	fc06                	sd	ra,56(sp)
  80038e:	e852                	sd	s4,16(sp)
  800390:	84aa                	mv	s1,a0
  800392:	89ae                	mv	s3,a1
  800394:	8932                	mv	s2,a2
  800396:	fff7841b          	addiw	s0,a5,-1
  80039a:	2a81                	sext.w	s5,s5
  80039c:	0516f163          	bleu	a7,a3,8003de <printnum+0x6a>
  8003a0:	8a42                	mv	s4,a6
  8003a2:	00805863          	blez	s0,8003b2 <printnum+0x3e>
  8003a6:	347d                	addiw	s0,s0,-1
  8003a8:	864e                	mv	a2,s3
  8003aa:	85ca                	mv	a1,s2
  8003ac:	8552                	mv	a0,s4
  8003ae:	9482                	jalr	s1
  8003b0:	f87d                	bnez	s0,8003a6 <printnum+0x32>
  8003b2:	1a82                	slli	s5,s5,0x20
  8003b4:	020ada93          	srli	s5,s5,0x20
  8003b8:	00001797          	auipc	a5,0x1
  8003bc:	cc078793          	addi	a5,a5,-832 # 801078 <error_string+0xc8>
  8003c0:	9abe                	add	s5,s5,a5
  8003c2:	7442                	ld	s0,48(sp)
  8003c4:	000ac503          	lbu	a0,0(s5)
  8003c8:	70e2                	ld	ra,56(sp)
  8003ca:	6a42                	ld	s4,16(sp)
  8003cc:	6aa2                	ld	s5,8(sp)
  8003ce:	864e                	mv	a2,s3
  8003d0:	85ca                	mv	a1,s2
  8003d2:	69e2                	ld	s3,24(sp)
  8003d4:	7902                	ld	s2,32(sp)
  8003d6:	8326                	mv	t1,s1
  8003d8:	74a2                	ld	s1,40(sp)
  8003da:	6121                	addi	sp,sp,64
  8003dc:	8302                	jr	t1
  8003de:	0316d6b3          	divu	a3,a3,a7
  8003e2:	87a2                	mv	a5,s0
  8003e4:	f91ff0ef          	jal	ra,800374 <printnum>
  8003e8:	b7e9                	j	8003b2 <printnum+0x3e>

00000000008003ea <sprintputch>:
  8003ea:	499c                	lw	a5,16(a1)
  8003ec:	6198                	ld	a4,0(a1)
  8003ee:	6594                	ld	a3,8(a1)
  8003f0:	2785                	addiw	a5,a5,1
  8003f2:	c99c                	sw	a5,16(a1)
  8003f4:	00d77763          	bleu	a3,a4,800402 <sprintputch+0x18>
  8003f8:	00170793          	addi	a5,a4,1
  8003fc:	e19c                	sd	a5,0(a1)
  8003fe:	00a70023          	sb	a0,0(a4)
  800402:	8082                	ret

0000000000800404 <vprintfmt>:
  800404:	7119                	addi	sp,sp,-128
  800406:	f4a6                	sd	s1,104(sp)
  800408:	f0ca                	sd	s2,96(sp)
  80040a:	ecce                	sd	s3,88(sp)
  80040c:	e4d6                	sd	s5,72(sp)
  80040e:	e0da                	sd	s6,64(sp)
  800410:	fc5e                	sd	s7,56(sp)
  800412:	f862                	sd	s8,48(sp)
  800414:	ec6e                	sd	s11,24(sp)
  800416:	fc86                	sd	ra,120(sp)
  800418:	f8a2                	sd	s0,112(sp)
  80041a:	e8d2                	sd	s4,80(sp)
  80041c:	f466                	sd	s9,40(sp)
  80041e:	f06a                	sd	s10,32(sp)
  800420:	89aa                	mv	s3,a0
  800422:	892e                	mv	s2,a1
  800424:	84b2                	mv	s1,a2
  800426:	8db6                	mv	s11,a3
  800428:	8b3a                	mv	s6,a4
  80042a:	5bfd                	li	s7,-1
  80042c:	00001a97          	auipc	s5,0x1
  800430:	a28a8a93          	addi	s5,s5,-1496 # 800e54 <main+0x18a>
  800434:	05e00c13          	li	s8,94
  800438:	000dc503          	lbu	a0,0(s11)
  80043c:	02500793          	li	a5,37
  800440:	001d8413          	addi	s0,s11,1
  800444:	00f50f63          	beq	a0,a5,800462 <vprintfmt+0x5e>
  800448:	c529                	beqz	a0,800492 <vprintfmt+0x8e>
  80044a:	02500a13          	li	s4,37
  80044e:	a011                	j	800452 <vprintfmt+0x4e>
  800450:	c129                	beqz	a0,800492 <vprintfmt+0x8e>
  800452:	864a                	mv	a2,s2
  800454:	85a6                	mv	a1,s1
  800456:	0405                	addi	s0,s0,1
  800458:	9982                	jalr	s3
  80045a:	fff44503          	lbu	a0,-1(s0)
  80045e:	ff4519e3          	bne	a0,s4,800450 <vprintfmt+0x4c>
  800462:	00044603          	lbu	a2,0(s0)
  800466:	02000813          	li	a6,32
  80046a:	4a01                	li	s4,0
  80046c:	4881                	li	a7,0
  80046e:	5d7d                	li	s10,-1
  800470:	5cfd                	li	s9,-1
  800472:	05500593          	li	a1,85
  800476:	4525                	li	a0,9
  800478:	fdd6071b          	addiw	a4,a2,-35
  80047c:	0ff77713          	andi	a4,a4,255
  800480:	00140d93          	addi	s11,s0,1
  800484:	22e5e363          	bltu	a1,a4,8006aa <vprintfmt+0x2a6>
  800488:	070a                	slli	a4,a4,0x2
  80048a:	9756                	add	a4,a4,s5
  80048c:	4318                	lw	a4,0(a4)
  80048e:	9756                	add	a4,a4,s5
  800490:	8702                	jr	a4
  800492:	70e6                	ld	ra,120(sp)
  800494:	7446                	ld	s0,112(sp)
  800496:	74a6                	ld	s1,104(sp)
  800498:	7906                	ld	s2,96(sp)
  80049a:	69e6                	ld	s3,88(sp)
  80049c:	6a46                	ld	s4,80(sp)
  80049e:	6aa6                	ld	s5,72(sp)
  8004a0:	6b06                	ld	s6,64(sp)
  8004a2:	7be2                	ld	s7,56(sp)
  8004a4:	7c42                	ld	s8,48(sp)
  8004a6:	7ca2                	ld	s9,40(sp)
  8004a8:	7d02                	ld	s10,32(sp)
  8004aa:	6de2                	ld	s11,24(sp)
  8004ac:	6109                	addi	sp,sp,128
  8004ae:	8082                	ret
  8004b0:	4705                	li	a4,1
  8004b2:	008b0613          	addi	a2,s6,8
  8004b6:	01174463          	blt	a4,a7,8004be <vprintfmt+0xba>
  8004ba:	28088563          	beqz	a7,800744 <vprintfmt+0x340>
  8004be:	000b3683          	ld	a3,0(s6)
  8004c2:	4741                	li	a4,16
  8004c4:	8b32                	mv	s6,a2
  8004c6:	a86d                	j	800580 <vprintfmt+0x17c>
  8004c8:	00144603          	lbu	a2,1(s0)
  8004cc:	4a05                	li	s4,1
  8004ce:	846e                	mv	s0,s11
  8004d0:	b765                	j	800478 <vprintfmt+0x74>
  8004d2:	000b2503          	lw	a0,0(s6)
  8004d6:	864a                	mv	a2,s2
  8004d8:	85a6                	mv	a1,s1
  8004da:	0b21                	addi	s6,s6,8
  8004dc:	9982                	jalr	s3
  8004de:	bfa9                	j	800438 <vprintfmt+0x34>
  8004e0:	4705                	li	a4,1
  8004e2:	008b0a13          	addi	s4,s6,8
  8004e6:	01174463          	blt	a4,a7,8004ee <vprintfmt+0xea>
  8004ea:	24088563          	beqz	a7,800734 <vprintfmt+0x330>
  8004ee:	000b3403          	ld	s0,0(s6)
  8004f2:	26044563          	bltz	s0,80075c <vprintfmt+0x358>
  8004f6:	86a2                	mv	a3,s0
  8004f8:	8b52                	mv	s6,s4
  8004fa:	4729                	li	a4,10
  8004fc:	a051                	j	800580 <vprintfmt+0x17c>
  8004fe:	000b2783          	lw	a5,0(s6)
  800502:	46e1                	li	a3,24
  800504:	0b21                	addi	s6,s6,8
  800506:	41f7d71b          	sraiw	a4,a5,0x1f
  80050a:	8fb9                	xor	a5,a5,a4
  80050c:	40e7873b          	subw	a4,a5,a4
  800510:	1ce6c163          	blt	a3,a4,8006d2 <vprintfmt+0x2ce>
  800514:	00371793          	slli	a5,a4,0x3
  800518:	00001697          	auipc	a3,0x1
  80051c:	a9868693          	addi	a3,a3,-1384 # 800fb0 <error_string>
  800520:	97b6                	add	a5,a5,a3
  800522:	639c                	ld	a5,0(a5)
  800524:	1a078763          	beqz	a5,8006d2 <vprintfmt+0x2ce>
  800528:	873e                	mv	a4,a5
  80052a:	00001697          	auipc	a3,0x1
  80052e:	d5668693          	addi	a3,a3,-682 # 801280 <error_string+0x2d0>
  800532:	8626                	mv	a2,s1
  800534:	85ca                	mv	a1,s2
  800536:	854e                	mv	a0,s3
  800538:	25a000ef          	jal	ra,800792 <printfmt>
  80053c:	bdf5                	j	800438 <vprintfmt+0x34>
  80053e:	00144603          	lbu	a2,1(s0)
  800542:	2885                	addiw	a7,a7,1
  800544:	846e                	mv	s0,s11
  800546:	bf0d                	j	800478 <vprintfmt+0x74>
  800548:	4705                	li	a4,1
  80054a:	008b0613          	addi	a2,s6,8
  80054e:	01174463          	blt	a4,a7,800556 <vprintfmt+0x152>
  800552:	1e088e63          	beqz	a7,80074e <vprintfmt+0x34a>
  800556:	000b3683          	ld	a3,0(s6)
  80055a:	4721                	li	a4,8
  80055c:	8b32                	mv	s6,a2
  80055e:	a00d                	j	800580 <vprintfmt+0x17c>
  800560:	03000513          	li	a0,48
  800564:	864a                	mv	a2,s2
  800566:	85a6                	mv	a1,s1
  800568:	e042                	sd	a6,0(sp)
  80056a:	9982                	jalr	s3
  80056c:	864a                	mv	a2,s2
  80056e:	85a6                	mv	a1,s1
  800570:	07800513          	li	a0,120
  800574:	9982                	jalr	s3
  800576:	0b21                	addi	s6,s6,8
  800578:	ff8b3683          	ld	a3,-8(s6)
  80057c:	6802                	ld	a6,0(sp)
  80057e:	4741                	li	a4,16
  800580:	87e6                	mv	a5,s9
  800582:	8626                	mv	a2,s1
  800584:	85ca                	mv	a1,s2
  800586:	854e                	mv	a0,s3
  800588:	dedff0ef          	jal	ra,800374 <printnum>
  80058c:	b575                	j	800438 <vprintfmt+0x34>
  80058e:	000b3703          	ld	a4,0(s6)
  800592:	0b21                	addi	s6,s6,8
  800594:	1e070063          	beqz	a4,800774 <vprintfmt+0x370>
  800598:	00170413          	addi	s0,a4,1
  80059c:	19905563          	blez	s9,800726 <vprintfmt+0x322>
  8005a0:	02d00613          	li	a2,45
  8005a4:	14c81963          	bne	a6,a2,8006f6 <vprintfmt+0x2f2>
  8005a8:	00074703          	lbu	a4,0(a4)
  8005ac:	0007051b          	sext.w	a0,a4
  8005b0:	c90d                	beqz	a0,8005e2 <vprintfmt+0x1de>
  8005b2:	000d4563          	bltz	s10,8005bc <vprintfmt+0x1b8>
  8005b6:	3d7d                	addiw	s10,s10,-1
  8005b8:	037d0363          	beq	s10,s7,8005de <vprintfmt+0x1da>
  8005bc:	864a                	mv	a2,s2
  8005be:	85a6                	mv	a1,s1
  8005c0:	180a0c63          	beqz	s4,800758 <vprintfmt+0x354>
  8005c4:	3701                	addiw	a4,a4,-32
  8005c6:	18ec7963          	bleu	a4,s8,800758 <vprintfmt+0x354>
  8005ca:	03f00513          	li	a0,63
  8005ce:	9982                	jalr	s3
  8005d0:	0405                	addi	s0,s0,1
  8005d2:	fff44703          	lbu	a4,-1(s0)
  8005d6:	3cfd                	addiw	s9,s9,-1
  8005d8:	0007051b          	sext.w	a0,a4
  8005dc:	f979                	bnez	a0,8005b2 <vprintfmt+0x1ae>
  8005de:	e5905de3          	blez	s9,800438 <vprintfmt+0x34>
  8005e2:	3cfd                	addiw	s9,s9,-1
  8005e4:	864a                	mv	a2,s2
  8005e6:	85a6                	mv	a1,s1
  8005e8:	02000513          	li	a0,32
  8005ec:	9982                	jalr	s3
  8005ee:	e40c85e3          	beqz	s9,800438 <vprintfmt+0x34>
  8005f2:	3cfd                	addiw	s9,s9,-1
  8005f4:	864a                	mv	a2,s2
  8005f6:	85a6                	mv	a1,s1
  8005f8:	02000513          	li	a0,32
  8005fc:	9982                	jalr	s3
  8005fe:	fe0c92e3          	bnez	s9,8005e2 <vprintfmt+0x1de>
  800602:	bd1d                	j	800438 <vprintfmt+0x34>
  800604:	4705                	li	a4,1
  800606:	008b0613          	addi	a2,s6,8
  80060a:	01174463          	blt	a4,a7,800612 <vprintfmt+0x20e>
  80060e:	12088663          	beqz	a7,80073a <vprintfmt+0x336>
  800612:	000b3683          	ld	a3,0(s6)
  800616:	4729                	li	a4,10
  800618:	8b32                	mv	s6,a2
  80061a:	b79d                	j	800580 <vprintfmt+0x17c>
  80061c:	00144603          	lbu	a2,1(s0)
  800620:	02d00813          	li	a6,45
  800624:	846e                	mv	s0,s11
  800626:	bd89                	j	800478 <vprintfmt+0x74>
  800628:	864a                	mv	a2,s2
  80062a:	85a6                	mv	a1,s1
  80062c:	02500513          	li	a0,37
  800630:	9982                	jalr	s3
  800632:	b519                	j	800438 <vprintfmt+0x34>
  800634:	000b2d03          	lw	s10,0(s6)
  800638:	00144603          	lbu	a2,1(s0)
  80063c:	0b21                	addi	s6,s6,8
  80063e:	846e                	mv	s0,s11
  800640:	e20cdce3          	bgez	s9,800478 <vprintfmt+0x74>
  800644:	8cea                	mv	s9,s10
  800646:	5d7d                	li	s10,-1
  800648:	bd05                	j	800478 <vprintfmt+0x74>
  80064a:	00144603          	lbu	a2,1(s0)
  80064e:	03000813          	li	a6,48
  800652:	846e                	mv	s0,s11
  800654:	b515                	j	800478 <vprintfmt+0x74>
  800656:	fd060d1b          	addiw	s10,a2,-48
  80065a:	00144603          	lbu	a2,1(s0)
  80065e:	846e                	mv	s0,s11
  800660:	fd06071b          	addiw	a4,a2,-48
  800664:	0006031b          	sext.w	t1,a2
  800668:	fce56ce3          	bltu	a0,a4,800640 <vprintfmt+0x23c>
  80066c:	0405                	addi	s0,s0,1
  80066e:	002d171b          	slliw	a4,s10,0x2
  800672:	00044603          	lbu	a2,0(s0)
  800676:	01a706bb          	addw	a3,a4,s10
  80067a:	0016969b          	slliw	a3,a3,0x1
  80067e:	006686bb          	addw	a3,a3,t1
  800682:	fd06071b          	addiw	a4,a2,-48
  800686:	fd068d1b          	addiw	s10,a3,-48
  80068a:	0006031b          	sext.w	t1,a2
  80068e:	fce57fe3          	bleu	a4,a0,80066c <vprintfmt+0x268>
  800692:	b77d                	j	800640 <vprintfmt+0x23c>
  800694:	fffcc713          	not	a4,s9
  800698:	977d                	srai	a4,a4,0x3f
  80069a:	00ecf7b3          	and	a5,s9,a4
  80069e:	00144603          	lbu	a2,1(s0)
  8006a2:	00078c9b          	sext.w	s9,a5
  8006a6:	846e                	mv	s0,s11
  8006a8:	bbc1                	j	800478 <vprintfmt+0x74>
  8006aa:	864a                	mv	a2,s2
  8006ac:	85a6                	mv	a1,s1
  8006ae:	02500513          	li	a0,37
  8006b2:	9982                	jalr	s3
  8006b4:	fff44703          	lbu	a4,-1(s0)
  8006b8:	02500793          	li	a5,37
  8006bc:	8da2                	mv	s11,s0
  8006be:	d6f70de3          	beq	a4,a5,800438 <vprintfmt+0x34>
  8006c2:	02500713          	li	a4,37
  8006c6:	1dfd                	addi	s11,s11,-1
  8006c8:	fffdc783          	lbu	a5,-1(s11)
  8006cc:	fee79de3          	bne	a5,a4,8006c6 <vprintfmt+0x2c2>
  8006d0:	b3a5                	j	800438 <vprintfmt+0x34>
  8006d2:	00001697          	auipc	a3,0x1
  8006d6:	b9e68693          	addi	a3,a3,-1122 # 801270 <error_string+0x2c0>
  8006da:	8626                	mv	a2,s1
  8006dc:	85ca                	mv	a1,s2
  8006de:	854e                	mv	a0,s3
  8006e0:	0b2000ef          	jal	ra,800792 <printfmt>
  8006e4:	bb91                	j	800438 <vprintfmt+0x34>
  8006e6:	00001717          	auipc	a4,0x1
  8006ea:	b8270713          	addi	a4,a4,-1150 # 801268 <error_string+0x2b8>
  8006ee:	00001417          	auipc	s0,0x1
  8006f2:	b7b40413          	addi	s0,s0,-1157 # 801269 <error_string+0x2b9>
  8006f6:	853a                	mv	a0,a4
  8006f8:	85ea                	mv	a1,s10
  8006fa:	e03a                	sd	a4,0(sp)
  8006fc:	e442                	sd	a6,8(sp)
  8006fe:	110000ef          	jal	ra,80080e <strnlen>
  800702:	40ac8cbb          	subw	s9,s9,a0
  800706:	6702                	ld	a4,0(sp)
  800708:	01905f63          	blez	s9,800726 <vprintfmt+0x322>
  80070c:	6822                	ld	a6,8(sp)
  80070e:	0008079b          	sext.w	a5,a6
  800712:	e43e                	sd	a5,8(sp)
  800714:	6522                	ld	a0,8(sp)
  800716:	864a                	mv	a2,s2
  800718:	85a6                	mv	a1,s1
  80071a:	e03a                	sd	a4,0(sp)
  80071c:	3cfd                	addiw	s9,s9,-1
  80071e:	9982                	jalr	s3
  800720:	6702                	ld	a4,0(sp)
  800722:	fe0c99e3          	bnez	s9,800714 <vprintfmt+0x310>
  800726:	00074703          	lbu	a4,0(a4)
  80072a:	0007051b          	sext.w	a0,a4
  80072e:	e80512e3          	bnez	a0,8005b2 <vprintfmt+0x1ae>
  800732:	b319                	j	800438 <vprintfmt+0x34>
  800734:	000b2403          	lw	s0,0(s6)
  800738:	bb6d                	j	8004f2 <vprintfmt+0xee>
  80073a:	000b6683          	lwu	a3,0(s6)
  80073e:	4729                	li	a4,10
  800740:	8b32                	mv	s6,a2
  800742:	bd3d                	j	800580 <vprintfmt+0x17c>
  800744:	000b6683          	lwu	a3,0(s6)
  800748:	4741                	li	a4,16
  80074a:	8b32                	mv	s6,a2
  80074c:	bd15                	j	800580 <vprintfmt+0x17c>
  80074e:	000b6683          	lwu	a3,0(s6)
  800752:	4721                	li	a4,8
  800754:	8b32                	mv	s6,a2
  800756:	b52d                	j	800580 <vprintfmt+0x17c>
  800758:	9982                	jalr	s3
  80075a:	bd9d                	j	8005d0 <vprintfmt+0x1cc>
  80075c:	864a                	mv	a2,s2
  80075e:	85a6                	mv	a1,s1
  800760:	02d00513          	li	a0,45
  800764:	e042                	sd	a6,0(sp)
  800766:	9982                	jalr	s3
  800768:	8b52                	mv	s6,s4
  80076a:	408006b3          	neg	a3,s0
  80076e:	4729                	li	a4,10
  800770:	6802                	ld	a6,0(sp)
  800772:	b539                	j	800580 <vprintfmt+0x17c>
  800774:	01905663          	blez	s9,800780 <vprintfmt+0x37c>
  800778:	02d00713          	li	a4,45
  80077c:	f6e815e3          	bne	a6,a4,8006e6 <vprintfmt+0x2e2>
  800780:	00001417          	auipc	s0,0x1
  800784:	ae940413          	addi	s0,s0,-1303 # 801269 <error_string+0x2b9>
  800788:	02800513          	li	a0,40
  80078c:	02800713          	li	a4,40
  800790:	b50d                	j	8005b2 <vprintfmt+0x1ae>

0000000000800792 <printfmt>:
  800792:	7139                	addi	sp,sp,-64
  800794:	02010313          	addi	t1,sp,32
  800798:	f03a                	sd	a4,32(sp)
  80079a:	871a                	mv	a4,t1
  80079c:	ec06                	sd	ra,24(sp)
  80079e:	f43e                	sd	a5,40(sp)
  8007a0:	f842                	sd	a6,48(sp)
  8007a2:	fc46                	sd	a7,56(sp)
  8007a4:	e41a                	sd	t1,8(sp)
  8007a6:	c5fff0ef          	jal	ra,800404 <vprintfmt>
  8007aa:	60e2                	ld	ra,24(sp)
  8007ac:	6121                	addi	sp,sp,64
  8007ae:	8082                	ret

00000000008007b0 <vsnprintf>:
  8007b0:	15fd                	addi	a1,a1,-1
  8007b2:	7179                	addi	sp,sp,-48
  8007b4:	95aa                	add	a1,a1,a0
  8007b6:	f406                	sd	ra,40(sp)
  8007b8:	e42a                	sd	a0,8(sp)
  8007ba:	e82e                	sd	a1,16(sp)
  8007bc:	cc02                	sw	zero,24(sp)
  8007be:	c515                	beqz	a0,8007ea <vsnprintf+0x3a>
  8007c0:	02a5e563          	bltu	a1,a0,8007ea <vsnprintf+0x3a>
  8007c4:	75dd                	lui	a1,0xffff7
  8007c6:	8736                	mv	a4,a3
  8007c8:	00000517          	auipc	a0,0x0
  8007cc:	c2250513          	addi	a0,a0,-990 # 8003ea <sprintputch>
  8007d0:	86b2                	mv	a3,a2
  8007d2:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <buffer.1212+0xffffffffff7f29d1>
  8007d6:	0030                	addi	a2,sp,8
  8007d8:	c2dff0ef          	jal	ra,800404 <vprintfmt>
  8007dc:	67a2                	ld	a5,8(sp)
  8007de:	00078023          	sb	zero,0(a5)
  8007e2:	4562                	lw	a0,24(sp)
  8007e4:	70a2                	ld	ra,40(sp)
  8007e6:	6145                	addi	sp,sp,48
  8007e8:	8082                	ret
  8007ea:	5575                	li	a0,-3
  8007ec:	bfe5                	j	8007e4 <vsnprintf+0x34>

00000000008007ee <snprintf>:
  8007ee:	715d                	addi	sp,sp,-80
  8007f0:	02810313          	addi	t1,sp,40
  8007f4:	f436                	sd	a3,40(sp)
  8007f6:	869a                	mv	a3,t1
  8007f8:	ec06                	sd	ra,24(sp)
  8007fa:	f83a                	sd	a4,48(sp)
  8007fc:	fc3e                	sd	a5,56(sp)
  8007fe:	e0c2                	sd	a6,64(sp)
  800800:	e4c6                	sd	a7,72(sp)
  800802:	e41a                	sd	t1,8(sp)
  800804:	fadff0ef          	jal	ra,8007b0 <vsnprintf>
  800808:	60e2                	ld	ra,24(sp)
  80080a:	6161                	addi	sp,sp,80
  80080c:	8082                	ret

000000000080080e <strnlen>:
  80080e:	c185                	beqz	a1,80082e <strnlen+0x20>
  800810:	00054783          	lbu	a5,0(a0)
  800814:	cf89                	beqz	a5,80082e <strnlen+0x20>
  800816:	4781                	li	a5,0
  800818:	a021                	j	800820 <strnlen+0x12>
  80081a:	00074703          	lbu	a4,0(a4)
  80081e:	c711                	beqz	a4,80082a <strnlen+0x1c>
  800820:	0785                	addi	a5,a5,1
  800822:	00f50733          	add	a4,a0,a5
  800826:	fef59ae3          	bne	a1,a5,80081a <strnlen+0xc>
  80082a:	853e                	mv	a0,a5
  80082c:	8082                	ret
  80082e:	4781                	li	a5,0
  800830:	853e                	mv	a0,a5
  800832:	8082                	ret

0000000000800834 <strcpy>:
  800834:	87aa                	mv	a5,a0
  800836:	0585                	addi	a1,a1,1
  800838:	fff5c703          	lbu	a4,-1(a1)
  80083c:	0785                	addi	a5,a5,1
  80083e:	fee78fa3          	sb	a4,-1(a5)
  800842:	fb75                	bnez	a4,800836 <strcpy+0x2>
  800844:	8082                	ret

0000000000800846 <strcmp>:
  800846:	00054783          	lbu	a5,0(a0)
  80084a:	0005c703          	lbu	a4,0(a1)
  80084e:	cb91                	beqz	a5,800862 <strcmp+0x1c>
  800850:	00e79c63          	bne	a5,a4,800868 <strcmp+0x22>
  800854:	0505                	addi	a0,a0,1
  800856:	00054783          	lbu	a5,0(a0)
  80085a:	0585                	addi	a1,a1,1
  80085c:	0005c703          	lbu	a4,0(a1)
  800860:	fbe5                	bnez	a5,800850 <strcmp+0xa>
  800862:	4501                	li	a0,0
  800864:	9d19                	subw	a0,a0,a4
  800866:	8082                	ret
  800868:	0007851b          	sext.w	a0,a5
  80086c:	9d19                	subw	a0,a0,a4
  80086e:	8082                	ret

0000000000800870 <strchr>:
  800870:	00054783          	lbu	a5,0(a0)
  800874:	cb91                	beqz	a5,800888 <strchr+0x18>
  800876:	00b79563          	bne	a5,a1,800880 <strchr+0x10>
  80087a:	a809                	j	80088c <strchr+0x1c>
  80087c:	00b78763          	beq	a5,a1,80088a <strchr+0x1a>
  800880:	0505                	addi	a0,a0,1
  800882:	00054783          	lbu	a5,0(a0)
  800886:	fbfd                	bnez	a5,80087c <strchr+0xc>
  800888:	4501                	li	a0,0
  80088a:	8082                	ret
  80088c:	8082                	ret

000000000080088e <gettoken>:
  80088e:	7139                	addi	sp,sp,-64
  800890:	f822                	sd	s0,48(sp)
  800892:	6100                	ld	s0,0(a0)
  800894:	fc06                	sd	ra,56(sp)
  800896:	f426                	sd	s1,40(sp)
  800898:	f04a                	sd	s2,32(sp)
  80089a:	ec4e                	sd	s3,24(sp)
  80089c:	e852                	sd	s4,16(sp)
  80089e:	e456                	sd	s5,8(sp)
  8008a0:	e05a                	sd	s6,0(sp)
  8008a2:	c405                	beqz	s0,8008ca <gettoken+0x3c>
  8008a4:	89aa                	mv	s3,a0
  8008a6:	892e                	mv	s2,a1
  8008a8:	00001497          	auipc	s1,0x1
  8008ac:	9e048493          	addi	s1,s1,-1568 # 801288 <error_string+0x2d8>
  8008b0:	a021                	j	8008b8 <gettoken+0x2a>
  8008b2:	0405                	addi	s0,s0,1
  8008b4:	fe040fa3          	sb	zero,-1(s0)
  8008b8:	00044583          	lbu	a1,0(s0)
  8008bc:	8526                	mv	a0,s1
  8008be:	fb3ff0ef          	jal	ra,800870 <strchr>
  8008c2:	f965                	bnez	a0,8008b2 <gettoken+0x24>
  8008c4:	00044783          	lbu	a5,0(s0)
  8008c8:	ef81                	bnez	a5,8008e0 <gettoken+0x52>
  8008ca:	4501                	li	a0,0
  8008cc:	70e2                	ld	ra,56(sp)
  8008ce:	7442                	ld	s0,48(sp)
  8008d0:	74a2                	ld	s1,40(sp)
  8008d2:	7902                	ld	s2,32(sp)
  8008d4:	69e2                	ld	s3,24(sp)
  8008d6:	6a42                	ld	s4,16(sp)
  8008d8:	6aa2                	ld	s5,8(sp)
  8008da:	6b02                	ld	s6,0(sp)
  8008dc:	6121                	addi	sp,sp,64
  8008de:	8082                	ret
  8008e0:	00893023          	sd	s0,0(s2)
  8008e4:	00044583          	lbu	a1,0(s0)
  8008e8:	00001517          	auipc	a0,0x1
  8008ec:	9a850513          	addi	a0,a0,-1624 # 801290 <error_string+0x2e0>
  8008f0:	f81ff0ef          	jal	ra,800870 <strchr>
  8008f4:	892a                	mv	s2,a0
  8008f6:	c115                	beqz	a0,80091a <gettoken+0x8c>
  8008f8:	00044503          	lbu	a0,0(s0)
  8008fc:	00140913          	addi	s2,s0,1
  800900:	00040023          	sb	zero,0(s0)
  800904:	00094783          	lbu	a5,0(s2)
  800908:	00f037b3          	snez	a5,a5
  80090c:	40f007b3          	neg	a5,a5
  800910:	00f97933          	and	s2,s2,a5
  800914:	0129b023          	sd	s2,0(s3)
  800918:	bf55                	j	8008cc <gettoken+0x3e>
  80091a:	00044583          	lbu	a1,0(s0)
  80091e:	4481                	li	s1,0
  800920:	00001b17          	auipc	s6,0x1
  800924:	978b0b13          	addi	s6,s6,-1672 # 801298 <error_string+0x2e8>
  800928:	02200a13          	li	s4,34
  80092c:	02000a93          	li	s5,32
  800930:	cd91                	beqz	a1,80094c <gettoken+0xbe>
  800932:	c095                	beqz	s1,800956 <gettoken+0xc8>
  800934:	00044783          	lbu	a5,0(s0)
  800938:	01479663          	bne	a5,s4,800944 <gettoken+0xb6>
  80093c:	01540023          	sb	s5,0(s0)
  800940:	0014c493          	xori	s1,s1,1
  800944:	0405                	addi	s0,s0,1
  800946:	00044583          	lbu	a1,0(s0)
  80094a:	f5e5                	bnez	a1,800932 <gettoken+0xa4>
  80094c:	07700513          	li	a0,119
  800950:	0129b023          	sd	s2,0(s3)
  800954:	bfa5                	j	8008cc <gettoken+0x3e>
  800956:	855a                	mv	a0,s6
  800958:	f19ff0ef          	jal	ra,800870 <strchr>
  80095c:	dd61                	beqz	a0,800934 <gettoken+0xa6>
  80095e:	8922                	mv	s2,s0
  800960:	07700513          	li	a0,119
  800964:	b745                	j	800904 <gettoken+0x76>

0000000000800966 <readline>:
  800966:	711d                	addi	sp,sp,-96
  800968:	ec86                	sd	ra,88(sp)
  80096a:	e8a2                	sd	s0,80(sp)
  80096c:	e4a6                	sd	s1,72(sp)
  80096e:	e0ca                	sd	s2,64(sp)
  800970:	fc4e                	sd	s3,56(sp)
  800972:	f852                	sd	s4,48(sp)
  800974:	f456                	sd	s5,40(sp)
  800976:	f05a                	sd	s6,32(sp)
  800978:	ec5e                	sd	s7,24(sp)
  80097a:	c909                	beqz	a0,80098c <readline+0x26>
  80097c:	862a                	mv	a2,a0
  80097e:	00001597          	auipc	a1,0x1
  800982:	90258593          	addi	a1,a1,-1790 # 801280 <error_string+0x2d0>
  800986:	4505                	li	a0,1
  800988:	81bff0ef          	jal	ra,8001a2 <fprintf>
  80098c:	6985                	lui	s3,0x1
  80098e:	4401                	li	s0,0
  800990:	448d                	li	s1,3
  800992:	497d                	li	s2,31
  800994:	4a21                	li	s4,8
  800996:	4aa9                	li	s5,10
  800998:	4b35                	li	s6,13
  80099a:	19f9                	addi	s3,s3,-2
  80099c:	00003b97          	auipc	s7,0x3
  8009a0:	76cb8b93          	addi	s7,s7,1900 # 804108 <buffer.1212>
  8009a4:	4605                	li	a2,1
  8009a6:	00f10593          	addi	a1,sp,15
  8009aa:	4501                	li	a0,0
  8009ac:	e80ff0ef          	jal	ra,80002c <read>
  8009b0:	04054163          	bltz	a0,8009f2 <readline+0x8c>
  8009b4:	c549                	beqz	a0,800a3e <readline+0xd8>
  8009b6:	00f14603          	lbu	a2,15(sp)
  8009ba:	02960c63          	beq	a2,s1,8009f2 <readline+0x8c>
  8009be:	04c97663          	bleu	a2,s2,800a0a <readline+0xa4>
  8009c2:	fe89c1e3          	blt	s3,s0,8009a4 <readline+0x3e>
  8009c6:	00001597          	auipc	a1,0x1
  8009ca:	94a58593          	addi	a1,a1,-1718 # 801310 <error_string+0x360>
  8009ce:	4505                	li	a0,1
  8009d0:	fd2ff0ef          	jal	ra,8001a2 <fprintf>
  8009d4:	00f14703          	lbu	a4,15(sp)
  8009d8:	008b87b3          	add	a5,s7,s0
  8009dc:	4605                	li	a2,1
  8009de:	00f10593          	addi	a1,sp,15
  8009e2:	4501                	li	a0,0
  8009e4:	00e78023          	sb	a4,0(a5)
  8009e8:	2405                	addiw	s0,s0,1
  8009ea:	e42ff0ef          	jal	ra,80002c <read>
  8009ee:	fc0553e3          	bgez	a0,8009b4 <readline+0x4e>
  8009f2:	4501                	li	a0,0
  8009f4:	60e6                	ld	ra,88(sp)
  8009f6:	6446                	ld	s0,80(sp)
  8009f8:	64a6                	ld	s1,72(sp)
  8009fa:	6906                	ld	s2,64(sp)
  8009fc:	79e2                	ld	s3,56(sp)
  8009fe:	7a42                	ld	s4,48(sp)
  800a00:	7aa2                	ld	s5,40(sp)
  800a02:	7b02                	ld	s6,32(sp)
  800a04:	6be2                	ld	s7,24(sp)
  800a06:	6125                	addi	sp,sp,96
  800a08:	8082                	ret
  800a0a:	01461d63          	bne	a2,s4,800a24 <readline+0xbe>
  800a0e:	d859                	beqz	s0,8009a4 <readline+0x3e>
  800a10:	4621                	li	a2,8
  800a12:	00001597          	auipc	a1,0x1
  800a16:	8fe58593          	addi	a1,a1,-1794 # 801310 <error_string+0x360>
  800a1a:	4505                	li	a0,1
  800a1c:	f86ff0ef          	jal	ra,8001a2 <fprintf>
  800a20:	347d                	addiw	s0,s0,-1
  800a22:	b749                	j	8009a4 <readline+0x3e>
  800a24:	03560a63          	beq	a2,s5,800a58 <readline+0xf2>
  800a28:	f7661ee3          	bne	a2,s6,8009a4 <readline+0x3e>
  800a2c:	4635                	li	a2,13
  800a2e:	00001597          	auipc	a1,0x1
  800a32:	8e258593          	addi	a1,a1,-1822 # 801310 <error_string+0x360>
  800a36:	4505                	li	a0,1
  800a38:	f6aff0ef          	jal	ra,8001a2 <fprintf>
  800a3c:	a011                	j	800a40 <readline+0xda>
  800a3e:	d855                	beqz	s0,8009f2 <readline+0x8c>
  800a40:	00003797          	auipc	a5,0x3
  800a44:	6c878793          	addi	a5,a5,1736 # 804108 <buffer.1212>
  800a48:	943e                	add	s0,s0,a5
  800a4a:	00040023          	sb	zero,0(s0)
  800a4e:	00003517          	auipc	a0,0x3
  800a52:	6ba50513          	addi	a0,a0,1722 # 804108 <buffer.1212>
  800a56:	bf79                	j	8009f4 <readline+0x8e>
  800a58:	4629                	li	a2,10
  800a5a:	bfd1                	j	800a2e <readline+0xc8>

0000000000800a5c <reopen>:
  800a5c:	1101                	addi	sp,sp,-32
  800a5e:	ec06                	sd	ra,24(sp)
  800a60:	e822                	sd	s0,16(sp)
  800a62:	e426                	sd	s1,8(sp)
  800a64:	842e                	mv	s0,a1
  800a66:	e04a                	sd	s2,0(sp)
  800a68:	84aa                	mv	s1,a0
  800a6a:	8932                	mv	s2,a2
  800a6c:	dbcff0ef          	jal	ra,800028 <close>
  800a70:	8522                	mv	a0,s0
  800a72:	85ca                	mv	a1,s2
  800a74:	dacff0ef          	jal	ra,800020 <open>
  800a78:	842a                	mv	s0,a0
  800a7a:	00054463          	bltz	a0,800a82 <reopen+0x26>
  800a7e:	00a49e63          	bne	s1,a0,800a9a <reopen+0x3e>
  800a82:	00142513          	slti	a0,s0,1
  800a86:	40a0053b          	negw	a0,a0
  800a8a:	8d61                	and	a0,a0,s0
  800a8c:	60e2                	ld	ra,24(sp)
  800a8e:	6442                	ld	s0,16(sp)
  800a90:	64a2                	ld	s1,8(sp)
  800a92:	6902                	ld	s2,0(sp)
  800a94:	2501                	sext.w	a0,a0
  800a96:	6105                	addi	sp,sp,32
  800a98:	8082                	ret
  800a9a:	8526                	mv	a0,s1
  800a9c:	d8cff0ef          	jal	ra,800028 <close>
  800aa0:	85a6                	mv	a1,s1
  800aa2:	8522                	mv	a0,s0
  800aa4:	d90ff0ef          	jal	ra,800034 <dup2>
  800aa8:	84aa                	mv	s1,a0
  800aaa:	8522                	mv	a0,s0
  800aac:	d7cff0ef          	jal	ra,800028 <close>
  800ab0:	8426                	mv	s0,s1
  800ab2:	bfc1                	j	800a82 <reopen+0x26>

0000000000800ab4 <testfile>:
  800ab4:	1141                	addi	sp,sp,-16
  800ab6:	4581                	li	a1,0
  800ab8:	e406                	sd	ra,8(sp)
  800aba:	d66ff0ef          	jal	ra,800020 <open>
  800abe:	87aa                	mv	a5,a0
  800ac0:	00054563          	bltz	a0,800aca <testfile+0x16>
  800ac4:	d64ff0ef          	jal	ra,800028 <close>
  800ac8:	4781                	li	a5,0
  800aca:	60a2                	ld	ra,8(sp)
  800acc:	853e                	mv	a0,a5
  800ace:	0141                	addi	sp,sp,16
  800ad0:	8082                	ret

0000000000800ad2 <runcmd>:
  800ad2:	711d                	addi	sp,sp,-96
  800ad4:	e0ca                	sd	s2,64(sp)
  800ad6:	f852                	sd	s4,48(sp)
  800ad8:	f456                	sd	s5,40(sp)
  800ada:	f05a                	sd	s6,32(sp)
  800adc:	ec86                	sd	ra,88(sp)
  800ade:	e8a2                	sd	s0,80(sp)
  800ae0:	e4a6                	sd	s1,72(sp)
  800ae2:	fc4e                	sd	s3,56(sp)
  800ae4:	e42a                	sd	a0,8(sp)
  800ae6:	07700913          	li	s2,119
  800aea:	02000a93          	li	s5,32
  800aee:	00002b17          	auipc	s6,0x2
  800af2:	512b0b13          	addi	s6,s6,1298 # 803000 <argv.1236>
  800af6:	07c00a13          	li	s4,124
  800afa:	4481                	li	s1,0
  800afc:	03c00413          	li	s0,60
  800b00:	03e00993          	li	s3,62
  800b04:	082c                	addi	a1,sp,24
  800b06:	0028                	addi	a0,sp,8
  800b08:	d87ff0ef          	jal	ra,80088e <gettoken>
  800b0c:	0c850563          	beq	a0,s0,800bd6 <runcmd+0x104>
  800b10:	02a45c63          	ble	a0,s0,800b48 <runcmd+0x76>
  800b14:	0b250363          	beq	a0,s2,800bba <runcmd+0xe8>
  800b18:	0f450d63          	beq	a0,s4,800c12 <runcmd+0x140>
  800b1c:	0d350c63          	beq	a0,s3,800bf4 <runcmd+0x122>
  800b20:	862a                	mv	a2,a0
  800b22:	00001597          	auipc	a1,0x1
  800b26:	87658593          	addi	a1,a1,-1930 # 801398 <error_string+0x3e8>
  800b2a:	4505                	li	a0,1
  800b2c:	e76ff0ef          	jal	ra,8001a2 <fprintf>
  800b30:	54fd                	li	s1,-1
  800b32:	60e6                	ld	ra,88(sp)
  800b34:	6446                	ld	s0,80(sp)
  800b36:	8526                	mv	a0,s1
  800b38:	6906                	ld	s2,64(sp)
  800b3a:	64a6                	ld	s1,72(sp)
  800b3c:	79e2                	ld	s3,56(sp)
  800b3e:	7a42                	ld	s4,48(sp)
  800b40:	7aa2                	ld	s5,40(sp)
  800b42:	7b02                	ld	s6,32(sp)
  800b44:	6125                	addi	sp,sp,96
  800b46:	8082                	ret
  800b48:	c121                	beqz	a0,800b88 <runcmd+0xb6>
  800b4a:	03b00793          	li	a5,59
  800b4e:	fcf519e3          	bne	a0,a5,800b20 <runcmd+0x4e>
  800b52:	f3cff0ef          	jal	ra,80028e <fork>
  800b56:	87aa                	mv	a5,a0
  800b58:	c905                	beqz	a0,800b88 <runcmd+0xb6>
  800b5a:	12054963          	bltz	a0,800c8c <runcmd+0x1ba>
  800b5e:	4581                	li	a1,0
  800b60:	f32ff0ef          	jal	ra,800292 <waitpid>
  800b64:	bf59                	j	800afa <runcmd+0x28>
  800b66:	12054363          	bltz	a0,800c8c <runcmd+0x1ba>
  800b6a:	4505                	li	a0,1
  800b6c:	cbcff0ef          	jal	ra,800028 <close>
  800b70:	4585                	li	a1,1
  800b72:	4501                	li	a0,0
  800b74:	cc0ff0ef          	jal	ra,800034 <dup2>
  800b78:	06054c63          	bltz	a0,800bf0 <runcmd+0x11e>
  800b7c:	4501                	li	a0,0
  800b7e:	caaff0ef          	jal	ra,800028 <close>
  800b82:	4501                	li	a0,0
  800b84:	ca4ff0ef          	jal	ra,800028 <close>
  800b88:	d4cd                	beqz	s1,800b32 <runcmd+0x60>
  800b8a:	00002417          	auipc	s0,0x2
  800b8e:	47640413          	addi	s0,s0,1142 # 803000 <argv.1236>
  800b92:	6008                	ld	a0,0(s0)
  800b94:	00001597          	auipc	a1,0x1
  800b98:	82c58593          	addi	a1,a1,-2004 # 8013c0 <error_string+0x410>
  800b9c:	cabff0ef          	jal	ra,800846 <strcmp>
  800ba0:	ed49                	bnez	a0,800c3a <runcmd+0x168>
  800ba2:	4789                	li	a5,2
  800ba4:	0ef49663          	bne	s1,a5,800c90 <runcmd+0x1be>
  800ba8:	640c                	ld	a1,8(s0)
  800baa:	00001517          	auipc	a0,0x1
  800bae:	45650513          	addi	a0,a0,1110 # 802000 <shcwd>
  800bb2:	4481                	li	s1,0
  800bb4:	c81ff0ef          	jal	ra,800834 <strcpy>
  800bb8:	bfad                	j	800b32 <runcmd+0x60>
  800bba:	0f548f63          	beq	s1,s5,800cb8 <runcmd+0x1e6>
  800bbe:	6762                	ld	a4,24(sp)
  800bc0:	00349793          	slli	a5,s1,0x3
  800bc4:	97da                	add	a5,a5,s6
  800bc6:	082c                	addi	a1,sp,24
  800bc8:	0028                	addi	a0,sp,8
  800bca:	e398                	sd	a4,0(a5)
  800bcc:	2485                	addiw	s1,s1,1
  800bce:	cc1ff0ef          	jal	ra,80088e <gettoken>
  800bd2:	f2851fe3          	bne	a0,s0,800b10 <runcmd+0x3e>
  800bd6:	082c                	addi	a1,sp,24
  800bd8:	0028                	addi	a0,sp,8
  800bda:	cb5ff0ef          	jal	ra,80088e <gettoken>
  800bde:	0d251463          	bne	a0,s2,800ca6 <runcmd+0x1d4>
  800be2:	65e2                	ld	a1,24(sp)
  800be4:	4601                	li	a2,0
  800be6:	4501                	li	a0,0
  800be8:	e75ff0ef          	jal	ra,800a5c <reopen>
  800bec:	f0050ce3          	beqz	a0,800b04 <runcmd+0x32>
  800bf0:	84aa                	mv	s1,a0
  800bf2:	b781                	j	800b32 <runcmd+0x60>
  800bf4:	082c                	addi	a1,sp,24
  800bf6:	0028                	addi	a0,sp,8
  800bf8:	c97ff0ef          	jal	ra,80088e <gettoken>
  800bfc:	09251c63          	bne	a0,s2,800c94 <runcmd+0x1c2>
  800c00:	65e2                	ld	a1,24(sp)
  800c02:	4659                	li	a2,22
  800c04:	4505                	li	a0,1
  800c06:	e57ff0ef          	jal	ra,800a5c <reopen>
  800c0a:	ee050de3          	beqz	a0,800b04 <runcmd+0x32>
  800c0e:	84aa                	mv	s1,a0
  800c10:	b70d                	j	800b32 <runcmd+0x60>
  800c12:	e7cff0ef          	jal	ra,80028e <fork>
  800c16:	87aa                	mv	a5,a0
  800c18:	f539                	bnez	a0,800b66 <runcmd+0x94>
  800c1a:	c0eff0ef          	jal	ra,800028 <close>
  800c1e:	4581                	li	a1,0
  800c20:	4501                	li	a0,0
  800c22:	c12ff0ef          	jal	ra,800034 <dup2>
  800c26:	84aa                	mv	s1,a0
  800c28:	f00545e3          	bltz	a0,800b32 <runcmd+0x60>
  800c2c:	4501                	li	a0,0
  800c2e:	bfaff0ef          	jal	ra,800028 <close>
  800c32:	4501                	li	a0,0
  800c34:	bf4ff0ef          	jal	ra,800028 <close>
  800c38:	b5c9                	j	800afa <runcmd+0x28>
  800c3a:	6008                	ld	a0,0(s0)
  800c3c:	e79ff0ef          	jal	ra,800ab4 <testfile>
  800c40:	c905                	beqz	a0,800c70 <runcmd+0x19e>
  800c42:	57c1                	li	a5,-16
  800c44:	faf516e3          	bne	a0,a5,800bf0 <runcmd+0x11e>
  800c48:	6014                	ld	a3,0(s0)
  800c4a:	00000617          	auipc	a2,0x0
  800c4e:	77e60613          	addi	a2,a2,1918 # 8013c8 <error_string+0x418>
  800c52:	6585                	lui	a1,0x1
  800c54:	00002517          	auipc	a0,0x2
  800c58:	4b450513          	addi	a0,a0,1204 # 803108 <argv0.1235>
  800c5c:	b93ff0ef          	jal	ra,8007ee <snprintf>
  800c60:	00002797          	auipc	a5,0x2
  800c64:	4a878793          	addi	a5,a5,1192 # 803108 <argv0.1235>
  800c68:	00002717          	auipc	a4,0x2
  800c6c:	38f73c23          	sd	a5,920(a4) # 803000 <argv.1236>
  800c70:	00349793          	slli	a5,s1,0x3
  800c74:	97a2                	add	a5,a5,s0
  800c76:	0007b023          	sd	zero,0(a5)
  800c7a:	6008                	ld	a0,0(s0)
  800c7c:	00002597          	auipc	a1,0x2
  800c80:	38458593          	addi	a1,a1,900 # 803000 <argv.1236>
  800c84:	e12ff0ef          	jal	ra,800296 <__exec>
  800c88:	84aa                	mv	s1,a0
  800c8a:	b565                	j	800b32 <runcmd+0x60>
  800c8c:	84be                	mv	s1,a5
  800c8e:	b555                	j	800b32 <runcmd+0x60>
  800c90:	54fd                	li	s1,-1
  800c92:	b545                	j	800b32 <runcmd+0x60>
  800c94:	00000597          	auipc	a1,0x0
  800c98:	6d458593          	addi	a1,a1,1748 # 801368 <error_string+0x3b8>
  800c9c:	4505                	li	a0,1
  800c9e:	d04ff0ef          	jal	ra,8001a2 <fprintf>
  800ca2:	54fd                	li	s1,-1
  800ca4:	b579                	j	800b32 <runcmd+0x60>
  800ca6:	00000597          	auipc	a1,0x0
  800caa:	69258593          	addi	a1,a1,1682 # 801338 <error_string+0x388>
  800cae:	4505                	li	a0,1
  800cb0:	cf2ff0ef          	jal	ra,8001a2 <fprintf>
  800cb4:	54fd                	li	s1,-1
  800cb6:	bdb5                	j	800b32 <runcmd+0x60>
  800cb8:	00000597          	auipc	a1,0x0
  800cbc:	66058593          	addi	a1,a1,1632 # 801318 <error_string+0x368>
  800cc0:	4505                	li	a0,1
  800cc2:	ce0ff0ef          	jal	ra,8001a2 <fprintf>
  800cc6:	54fd                	li	s1,-1
  800cc8:	b5ad                	j	800b32 <runcmd+0x60>

0000000000800cca <main>:
  800cca:	7179                	addi	sp,sp,-48
  800ccc:	f022                	sd	s0,32(sp)
  800cce:	842a                	mv	s0,a0
  800cd0:	00000517          	auipc	a0,0x0
  800cd4:	5d850513          	addi	a0,a0,1496 # 8012a8 <error_string+0x2f8>
  800cd8:	ec26                	sd	s1,24(sp)
  800cda:	f406                	sd	ra,40(sp)
  800cdc:	e84a                	sd	s2,16(sp)
  800cde:	84ae                	mv	s1,a1
  800ce0:	c82ff0ef          	jal	ra,800162 <cputs>
  800ce4:	4789                	li	a5,2
  800ce6:	04f40e63          	beq	s0,a5,800d42 <main+0x78>
  800cea:	00000497          	auipc	s1,0x0
  800cee:	60e48493          	addi	s1,s1,1550 # 8012f8 <error_string+0x348>
  800cf2:	0687c163          	blt	a5,s0,800d54 <main+0x8a>
  800cf6:	00000917          	auipc	s2,0x0
  800cfa:	60a90913          	addi	s2,s2,1546 # 801300 <error_string+0x350>
  800cfe:	a831                	j	800d1a <main+0x50>
  800d00:	00001797          	auipc	a5,0x1
  800d04:	30078023          	sb	zero,768(a5) # 802000 <shcwd>
  800d08:	d86ff0ef          	jal	ra,80028e <fork>
  800d0c:	cd2d                	beqz	a0,800d86 <main+0xbc>
  800d0e:	04054c63          	bltz	a0,800d66 <main+0x9c>
  800d12:	006c                	addi	a1,sp,12
  800d14:	d7eff0ef          	jal	ra,800292 <waitpid>
  800d18:	cd09                	beqz	a0,800d32 <main+0x68>
  800d1a:	8526                	mv	a0,s1
  800d1c:	c4bff0ef          	jal	ra,800966 <readline>
  800d20:	842a                	mv	s0,a0
  800d22:	fd79                	bnez	a0,800d00 <main+0x36>
  800d24:	4501                	li	a0,0
  800d26:	70a2                	ld	ra,40(sp)
  800d28:	7402                	ld	s0,32(sp)
  800d2a:	64e2                	ld	s1,24(sp)
  800d2c:	6942                	ld	s2,16(sp)
  800d2e:	6145                	addi	sp,sp,48
  800d30:	8082                	ret
  800d32:	46b2                	lw	a3,12(sp)
  800d34:	d2fd                	beqz	a3,800d1a <main+0x50>
  800d36:	8636                	mv	a2,a3
  800d38:	85ca                	mv	a1,s2
  800d3a:	4505                	li	a0,1
  800d3c:	c66ff0ef          	jal	ra,8001a2 <fprintf>
  800d40:	bfe9                	j	800d1a <main+0x50>
  800d42:	648c                	ld	a1,8(s1)
  800d44:	4601                	li	a2,0
  800d46:	4501                	li	a0,0
  800d48:	d15ff0ef          	jal	ra,800a5c <reopen>
  800d4c:	c62a                	sw	a0,12(sp)
  800d4e:	4481                	li	s1,0
  800d50:	d15d                	beqz	a0,800cf6 <main+0x2c>
  800d52:	bfd1                	j	800d26 <main+0x5c>
  800d54:	00000597          	auipc	a1,0x0
  800d58:	67c58593          	addi	a1,a1,1660 # 8013d0 <error_string+0x420>
  800d5c:	4505                	li	a0,1
  800d5e:	c44ff0ef          	jal	ra,8001a2 <fprintf>
  800d62:	557d                	li	a0,-1
  800d64:	b7c9                	j	800d26 <main+0x5c>
  800d66:	00000697          	auipc	a3,0x0
  800d6a:	55a68693          	addi	a3,a3,1370 # 8012c0 <error_string+0x310>
  800d6e:	00000617          	auipc	a2,0x0
  800d72:	56260613          	addi	a2,a2,1378 # 8012d0 <error_string+0x320>
  800d76:	12000593          	li	a1,288
  800d7a:	00000517          	auipc	a0,0x0
  800d7e:	56e50513          	addi	a0,a0,1390 # 8012e8 <error_string+0x338>
  800d82:	abcff0ef          	jal	ra,80003e <__panic>
  800d86:	8522                	mv	a0,s0
  800d88:	d4bff0ef          	jal	ra,800ad2 <runcmd>
  800d8c:	c62a                	sw	a0,12(sp)
  800d8e:	ceaff0ef          	jal	ra,800278 <exit>
