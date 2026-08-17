import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(const AlvesDevApp());
}

class AppColors {
  static const background = Color(0xFF070B16);
  static const background2 = Color(0xFF0F172A);
  static const card = Color(0xFF0B1120);
  static const cardHover = Color(0xFF111827);
  static const purple = Color(0xFF4338CA);
  static const purple2 = Color(0xFF6366F1);
  static const purpleLight = Color(0xFFA5B4FC);
  static const textSecondary = Color(0xFFCBD5E1);
  static const textMuted = Color(0xFF94A3B8);
  static const green = Color(0xFF6EE7B7);
}

class AppLinks {
  static const github = 'https://github.com/Alvesdd7';
  static const instagram = 'https://www.instagram.com/joaoalvesp.dev/';
  static const whatsapp = 'https://wa.me/5517991656885';

  // Deploy público que consegui confirmar.
  static const jarvis = 'https://jarvis-beta.vercel.app';
}

class AlvesDevApp extends StatelessWidget {
  const AlvesDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alves Dev | Flutter Developer',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.purple,
          brightness: Brightness.dark,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _inicioKey = GlobalKey();
  final GlobalKey _sobreKey = GlobalKey();
  final GlobalKey _projetosKey = GlobalKey();
  final GlobalKey _trajetoriaKey = GlobalKey();
  final GlobalKey _tecnologiasKey = GlobalKey();
  final GlobalKey _contatoKey = GlobalKey();

  Future<void> _abrirLink(String value) async {
    final uri = Uri.tryParse(value);
    if (uri == null) return;

    try {
      final ok = await launchUrl(uri);
      if (!ok && mounted) _mostrarErroLink();
    } catch (_) {
      if (mounted) _mostrarErroLink();
    }
  }

  void _mostrarErroLink() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Não foi possível abrir este link.'),
      ),
    );
  }

  void _irPara(GlobalKey key) {
    final target = key.currentContext;
    if (target == null) return;

    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < 820;

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedPortfolioBackground()),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 92),
                  HeroSection(
                    key: _inicioKey,
                    mobile: mobile,
                    onProjetos: () => _irPara(_projetosKey),
                    onContato: () => _irPara(_contatoKey),
                    onGithub: () => _abrirLink(AppLinks.github),
                    onInstagram: () => _abrirLink(AppLinks.instagram),
                  ),
                  SectionContainer(
                    key: _sobreKey,
                    child: AboutSection(mobile: mobile),
                  ),
                  SectionContainer(
                    key: _projetosKey,
                    darker: true,
                    child: ProjectsSection(onOpen: _abrirLink),
                  ),
                  SectionContainer(
                    key: _trajetoriaKey,
                    child: const TimelineSection(),
                  ),
                  SectionContainer(
                    key: _tecnologiasKey,
                    darker: true,
                    child: const TechnologiesSection(),
                  ),
                  SectionContainer(
                    key: _contatoKey,
                    child: ContactSection(
                      mobile: mobile,
                      onWhatsapp: () => _abrirLink(AppLinks.whatsapp),
                      onInstagram: () => _abrirLink(AppLinks.instagram),
                      onGithub: () => _abrirLink(AppLinks.github),
                    ),
                  ),
                  const PortfolioFooter(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: GlassNavbar(
                mobile: mobile,
                onInicio: () => _irPara(_inicioKey),
                onSobre: () => _irPara(_sobreKey),
                onProjetos: () => _irPara(_projetosKey),
                onTrajetoria: () => _irPara(_trajetoriaKey),
                onTecnologias: () => _irPara(_tecnologiasKey),
                onContato: () => _irPara(_contatoKey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedPortfolioBackground extends StatefulWidget {
  const AnimatedPortfolioBackground({super.key});

  @override
  State<AnimatedPortfolioBackground> createState() =>
      _AnimatedPortfolioBackgroundState();
}

class _AnimatedPortfolioBackgroundState
    extends State<AnimatedPortfolioBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final value = _controller.value;
              return Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-1, -1 + value * 0.35),
                          end: Alignment(1, 1 - value * 0.25),
                          colors: const [
                            Color(0xFF070B16),
                            Color(0xFF0F172A),
                            Color(0xFF172554),
                            Color(0xFF312E81),
                          ],
                          stops: const [0, 0.35, 0.72, 1],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: constraints.maxWidth * (0.03 + value * 0.05),
                    top: 130,
                    child: const GlowOrb(
                      size: 430,
                      color: Color(0xFF4338CA),
                    ),
                  ),
                  Positioned(
                    right: constraints.maxWidth * 0.02,
                    bottom: 170 + value * 70,
                    child: const GlowOrb(
                      size: 380,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const GlowOrb({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}

class GlassNavbar extends StatelessWidget {
  final bool mobile;
  final VoidCallback onInicio;
  final VoidCallback onSobre;
  final VoidCallback onProjetos;
  final VoidCallback onTrajetoria;
  final VoidCallback onTecnologias;
  final VoidCallback onContato;

  const GlassNavbar({
    super.key,
    required this.mobile,
    required this.onInicio,
    required this.onSobre,
    required this.onProjetos,
    required this.onTrajetoria,
    required this.onTecnologias,
    required this.onContato,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: mobile ? 14 : 30,
          vertical: 10,
        ),
        constraints: const BoxConstraints(maxWidth: 1280),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 66,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: const Color(0xFF090E1B).withValues(alpha: 0.68),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.20),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: onInicio,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        '<Alves Dev />',
                        style: GoogleFonts.firaCode(
                          color: Colors.white,
                          fontSize: mobile ? 14 : 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (!mobile) ...[
                    NavItem(texto: 'Início', onTap: onInicio),
                    NavItem(texto: 'Sobre', onTap: onSobre),
                    NavItem(texto: 'Projetos', onTap: onProjetos),
                    NavItem(texto: 'Trajetória', onTap: onTrajetoria),
                    NavItem(texto: 'Skills', onTap: onTecnologias),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: onContato,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purpleLight,
                        foregroundColor: AppColors.background,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Contato'),
                    ),
                  ] else
                    PopupMenuButton<String>(
                      color: AppColors.card,
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                      onSelected: (value) {
                        switch (value) {
                          case 'inicio':
                            onInicio();
                            break;
                          case 'sobre':
                            onSobre();
                            break;
                          case 'projetos':
                            onProjetos();
                            break;
                          case 'trajetoria':
                            onTrajetoria();
                            break;
                          case 'skills':
                            onTecnologias();
                            break;
                          case 'contato':
                            onContato();
                            break;
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'inicio', child: Text('Início')),
                        PopupMenuItem(value: 'sobre', child: Text('Sobre')),
                        PopupMenuItem(
                          value: 'projetos',
                          child: Text('Projetos'),
                        ),
                        PopupMenuItem(
                          value: 'trajetoria',
                          child: Text('Trajetória'),
                        ),
                        PopupMenuItem(value: 'skills', child: Text('Skills')),
                        PopupMenuItem(value: 'contato', child: Text('Contato')),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final String texto;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.texto,
    required this.onTap,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: GoogleFonts.inter(
                  color: hover ? AppColors.purpleLight : Colors.white70,
                  fontSize: 13,
                  fontWeight: hover ? FontWeight.w600 : FontWeight.w400,
                ),
                child: Text(widget.texto),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 2,
                width: hover ? 18 : 0,
                decoration: BoxDecoration(
                  color: AppColors.purpleLight,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final bool mobile;
  final VoidCallback onProjetos;
  final VoidCallback onContato;
  final VoidCallback onGithub;
  final VoidCallback onInstagram;

  const HeroSection({
    super.key,
    required this.mobile,
    required this.onProjetos,
    required this.onContato,
    required this.onGithub,
    required this.onInstagram,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height - 92,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 24 : 50,
              vertical: 70,
            ),
            child: mobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeroContent(
                        mobile: true,
                        onProjetos: onProjetos,
                        onContato: onContato,
                        onGithub: onGithub,
                        onInstagram: onInstagram,
                      )
                          .animate()
                          .fadeIn(duration: 700.ms)
                          .slide(
                            begin: const Offset(-0.07, 0),
                            end: Offset.zero,
                            duration: 700.ms,
                            curve: Curves.easeOutCubic,
                          ),
                      const SizedBox(height: 60),
                      const TerminalCard()
                          .animate(delay: 180.ms)
                          .fadeIn(duration: 700.ms)
                          .slide(
                            begin: const Offset(0.07, 0),
                            end: Offset.zero,
                            duration: 700.ms,
                          ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: HeroContent(
                          mobile: false,
                          onProjetos: onProjetos,
                          onContato: onContato,
                          onGithub: onGithub,
                          onInstagram: onInstagram,
                        )
                            .animate()
                            .fadeIn(duration: 750.ms)
                            .slide(
                              begin: const Offset(-0.07, 0),
                              end: Offset.zero,
                              duration: 750.ms,
                              curve: Curves.easeOutCubic,
                            ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(
                        flex: 5,
                        child: const TerminalCard()
                            .animate(delay: 180.ms)
                            .fadeIn(duration: 750.ms)
                            .slide(
                              begin: const Offset(0.07, 0),
                              end: Offset.zero,
                              duration: 750.ms,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class HeroContent extends StatelessWidget {
  final bool mobile;
  final VoidCallback onProjetos;
  final VoidCallback onContato;
  final VoidCallback onGithub;
  final VoidCallback onInstagram;

  const HeroContent({
    super.key,
    required this.mobile,
    required this.onProjetos,
    required this.onContato,
    required this.onGithub,
    required this.onInstagram,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.purpleLight.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.purpleLight.withValues(alpha: 0.24),
            ),
          ),
          child: Text(
            '● Técnico em Desenvolvimento de Sistemas',
            style: GoogleFonts.firaCode(
              color: AppColors.purpleLight,
              fontSize: mobile ? 10 : 11,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'Olá, eu sou o João 👋',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: mobile ? 16 : 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Flutter',
          style: GoogleFonts.firaCode(
            color: Colors.white,
            fontSize: mobile ? 46 : 65,
            fontWeight: FontWeight.bold,
            height: 0.95,
            letterSpacing: -3,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [
                Color(0xFFA5B4FC),
                Color(0xFF818CF8),
                Color(0xFFC4B5FD),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            'Developer.',
            style: GoogleFonts.firaCode(
              color: Colors.white,
              fontSize: mobile ? 46 : 65,
              fontWeight: FontWeight.bold,
              height: 0.95,
              letterSpacing: -3,
            ),
          ),
        ),
        const SizedBox(height: 30),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 610),
          child: Text(
            'Transformo ideias em interfaces e aplicativos modernos enquanto evoluo meus conhecimentos em Flutter, Dart e desenvolvimento de software.',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: mobile ? 15 : 16,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              texto: 'Ver projetos',
              icon: Icons.arrow_downward_rounded,
              onPressed: onProjetos,
            ),
            SecondaryButton(
              texto: 'Contato',
              icon: Icons.chat_bubble_outline,
              onPressed: onContato,
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            SocialButton(
              icon: Icons.code_rounded,
              tooltip: 'GitHub',
              onPressed: onGithub,
            ),
            const SizedBox(width: 10),
            SocialButton(
              icon: Icons.camera_alt_outlined,
              tooltip: 'Instagram',
              onPressed: onInstagram,
            ),
          ],
        ),
      ],
    );
  }
}

class TerminalScript {
  final String command;
  final List<TerminalOutput> outputs;

  const TerminalScript({
    required this.command,
    required this.outputs,
  });
}

class TerminalOutput {
  final String text;
  final Color color;

  const TerminalOutput(this.text, this.color);
}

class TerminalCard extends StatefulWidget {
  const TerminalCard({super.key});

  @override
  State<TerminalCard> createState() => _TerminalCardState();
}

class _TerminalCardState extends State<TerminalCard> {
  final scripts = const [
    TerminalScript(
      command: 'flutter run',
      outputs: [
        TerminalOutput('Launching lib/main.dart...', AppColors.textMuted),
        TerminalOutput('✓ Build completed', AppColors.green),
        TerminalOutput('✓ App running', AppColors.green),
      ],
    ),
    TerminalScript(
      command: 'whoami',
      outputs: [
        TerminalOutput('João Alves', AppColors.purpleLight),
        TerminalOutput(
          'Estudante de Desenvolvimento de Sistemas',
          AppColors.textMuted,
        ),
      ],
    ),
    TerminalScript(
      command: 'focus',
      outputs: [
        TerminalOutput('Flutter • Dart • Mobile', AppColors.purpleLight),
        TerminalOutput('status: learning & building...', AppColors.green),
      ],
    ),
  ];

  String typedCommand = '';
  List<TerminalOutput> outputs = [];
  int scriptIndex = 0;
  bool cursorVisible = true;
  Timer? cursorTimer;

  @override
  void initState() {
    super.initState();
    cursorTimer = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) {
        if (!mounted) return;
        setState(() => cursorVisible = !cursorVisible);
      },
    );
    _runTerminal();
  }

  Future<void> _runTerminal() async {
    await Future.delayed(const Duration(milliseconds: 700));

    while (mounted) {
      final script = scripts[scriptIndex];
      if (!mounted) return;

      setState(() {
        typedCommand = '';
        outputs = [];
      });

      for (int i = 0; i < script.command.length; i++) {
        if (!mounted) return;
        setState(() => typedCommand += script.command[i]);
        await Future.delayed(const Duration(milliseconds: 80));
      }

      await Future.delayed(const Duration(milliseconds: 450));

      for (final output in script.outputs) {
        if (!mounted) return;
        setState(() => outputs = [...outputs, output]);
        await Future.delayed(const Duration(milliseconds: 700));
      }

      await Future.delayed(const Duration(seconds: 3));
      scriptIndex = (scriptIndex + 1) % scripts.length;
    }
  }

  @override
  void dispose() {
    cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFF060B15),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 50,
            offset: const Offset(0, 25),
          ),
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.15),
            blurRadius: 70,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _dot(const Color(0xFFFF5F57)),
              const SizedBox(width: 8),
              _dot(const Color(0xFFFFBD2E)),
              const SizedBox(width: 8),
              _dot(const Color(0xFF28C840)),
              const Spacer(),
              Text(
                'alves_dev — terminal',
                style: GoogleFonts.firaCode(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          Row(
            children: [
              Text(
                'alves@dev',
                style: GoogleFonts.firaCode(
                  color: AppColors.purpleLight,
                  fontSize: 14,
                ),
              ),
              Text(
                ':~\$ ',
                style: GoogleFonts.firaCode(
                  color: AppColors.textMuted,
                  fontSize: 14,
                ),
              ),
              Flexible(
                child: Text(
                  typedCommand,
                  style: GoogleFonts.firaCode(
                    color: AppColors.green,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                cursorVisible ? '█' : ' ',
                style: GoogleFonts.firaCode(
                  color: AppColors.purpleLight,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...outputs.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Text(
                line.text,
                style: GoogleFonts.firaCode(
                  color: line.color,
                  fontSize: 13,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 250.ms)
                .slide(begin: const Offset(0, 0.1), end: Offset.zero),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final Widget child;
  final bool darker;

  const SectionContainer({
    super.key,
    required this.child,
    this.darker = false,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 820;

    return Container(
      width: double.infinity,
      color: darker
          ? const Color(0xFF050914).withValues(alpha: 0.60)
          : Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 24 : 50,
              vertical: mobile ? 82 : 110,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String label;
  final String title;
  final String description;

  const SectionTitle({
    super.key,
    required this.label,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 820;

    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '<$label />',
            style: GoogleFonts.firaCode(
              color: AppColors.purpleLight,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: mobile ? 32 : 40,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.3,
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              description,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final bool mobile;

  const AboutSection({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          label: 'SOBRE_MIM',
          title: 'Aprendendo, criando e evoluindo.',
          description:
              'Meu foco é transformar estudo em prática através de projetos reais e continuar evoluindo como desenvolvedor.',
        ),
        const SizedBox(height: 60),
        mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _texto(),
                  const SizedBox(height: 35),
                  _cards(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _texto()),
                  const SizedBox(width: 70),
                  Expanded(flex: 5, child: _cards()),
                ],
              ),
      ],
    );
  }

  Widget _texto() {
    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Atualmente curso Técnico em Desenvolvimento de Sistemas e estou focando meus estudos em Flutter e Dart.',
            style: GoogleFonts.inter(
              fontSize: 20,
              height: 1.6,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Gosto de criar aplicações, experimentar novas tecnologias e aprender como cada parte de um projeto funciona — da interface até integrações com serviços e hardware.',
            style: GoogleFonts.inter(
              fontSize: 15,
              height: 1.7,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cards() {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: const [
        MiniInfoCard(
          icon: Icons.flutter_dash_rounded,
          title: 'Foco atual',
          description: 'Flutter & Dart',
        ),
        MiniInfoCard(
          icon: Icons.school_outlined,
          title: 'Formação',
          description: 'Desenvolvimento de Sistemas',
        ),
        MiniInfoCard(
          icon: Icons.rocket_launch_outlined,
          title: 'Objetivo',
          description: 'Criar projetos reais',
        ),
        MiniInfoCard(
          icon: Icons.memory_rounded,
          title: 'Explorando',
          description: 'Arduino & Cloud',
        ),
      ],
    );
  }
}

class MiniInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const MiniInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 132,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.purpleLight),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  final Future<void> Function(String url) onOpen;

  const ProjectsSection({
    super.key,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          label: 'PROJETOS REAIS',
          title: 'Ideias que eu quero levar adiante.',
          description:
              'Uma seleção dos projetos que melhor representam produto, automação, experimentação e aplicação comercial — não apenas exercícios de código.',
        ),
        const SizedBox(height: 55),
        LayoutBuilder(
          builder: (context, constraints) {
            final largura = constraints.maxWidth >= 900
                ? (constraints.maxWidth - 24) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                RevealOnScroll(
                  delay: 60.ms,
                  child: ProjectCard(
                    width: largura,
                    badge: 'PRODUTO • MAIOR POTENCIAL',
                    title: 'ServiGo',
                    description:
                        'Aplicativo Flutter pensado para profissionais autônomos organizarem clientes, orçamentos, ordens de serviço, cobranças e financeiro em um único fluxo.',
                    future:
                        'Potencial: virar um SaaS de verdade para prestadores de serviço.',
                    technologies: const [
                      'Flutter',
                      'Dart',
                      'Riverpod',
                      'Supabase',
                      'SaaS',
                    ],
                    icon: Icons.handyman_rounded,
                    previewColor: const Color(0xFF065F46),
                    actionLabel: 'Produto em evolução',
                  ),
                ),
                RevealOnScroll(
                  delay: 140.ms,
                  child: ProjectCard(
                    width: largura,
                    badge: 'IA • AUTOMAÇÃO',
                    title: 'JARVIS Nexus',
                    description:
                        'Assistente pessoal com voz, lembretes, modo foco, notas, mensagens, automações e integrações locais. Possui uma versão web publicada.',
                    future:
                        'Potencial: central pessoal de produtividade e automação residencial.',
                    technologies: const [
                      'JavaScript',
                      'IA',
                      'Automação',
                      'PWA',
                      'Web APIs',
                    ],
                    icon: Icons.smart_toy_rounded,
                    previewColor: const Color(0xFF312E81),
                    imageAsset: 'assets/images/jarvis-nexus.png',
                    actionLabel: 'Abrir na Vercel',
                    onProject: () => onOpen(AppLinks.jarvis),
                  ),
                ),
                RevealOnScroll(
                  delay: 220.ms,
                  child: ProjectCard(
                    width: largura,
                    badge: 'EXPERIMENTAL • PWA',
                    title: 'AlvesOS Mobile',
                    description:
                        'Edição mobile/web experimental com SpringUI, tela de bloqueio, aplicativos, diagnóstico, cache via Service Worker e integração com recursos expostos pelo navegador.',
                    future:
                        'Potencial: laboratório autoral de interfaces, PWA e Web APIs.',
                    technologies: const [
                      'JavaScript',
                      'PWA',
                      'Service Worker',
                      'Web APIs',
                      'UI/UX',
                    ],
                    icon: Icons.phone_iphone_rounded,
                    previewColor: const Color(0xFF1D4ED8),
                    imageAsset: 'assets/images/alvesos-mobile.jpg',
                    actionLabel: 'Projeto experimental',
                  ),
                ),
                RevealOnScroll(
                  delay: 300.ms,
                  child: ProjectCard(
                    width: largura,
                    badge: 'WEB • NEGÓCIOS',
                    title: 'TF Móveis Planejados',
                    description:
                        'Proposta de landing page demonstrativa para uma empresa real, com apresentação da marca, ambientes, mapa, Instagram e conversão para orçamento pelo WhatsApp.',
                    future:
                        'Potencial: transformar protótipos bem feitos em projetos para clientes reais.',
                    technologies: const [
                      'HTML',
                      'CSS',
                      'JavaScript',
                      'Vercel',
                      'UI/UX',
                    ],
                    icon: Icons.chair_alt_rounded,
                    previewColor: const Color(0xFF78350F),
                    actionLabel: 'Case demonstrativo',
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final double width;
  final String badge;
  final String title;
  final String description;
  final String future;
  final List<String> technologies;
  final IconData icon;
  final Color previewColor;
  final String actionLabel;
  final VoidCallback? onProject;
  final VoidCallback? onGithub;
  final String? imageAsset;

  const ProjectCard({
    super.key,
    required this.width,
    required this.badge,
    required this.title,
    required this.description,
    required this.future,
    required this.technologies,
    required this.icon,
    required this.previewColor,
    required this.actionLabel,
    this.onProject,
    this.onGithub,
    this.imageAsset,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedSlide(
        offset: hover ? const Offset(0, -0.018) : Offset.zero,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          width: widget.width,
          height: widget.width < 520 ? 640 : 590,
          decoration: BoxDecoration(
            color: hover ? AppColors.cardHover : AppColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: hover
                  ? AppColors.purpleLight.withValues(alpha: 0.45)
                  : Colors.white.withValues(alpha: 0.07),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: hover ? 0.4 : 0.2),
                blurRadius: hover ? 45 : 22,
                offset: Offset(0, hover ? 22 : 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 205,
                  width: double.infinity,
                  child: _projectPreview(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.purple.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: AppColors.purpleLight.withValues(alpha: 0.16),
                            ),
                          ),
                          child: Text(
                            widget.badge,
                            style: GoogleFonts.firaCode(
                              color: AppColors.purpleLight,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          widget.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 13.5,
                            height: 1.48,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 7,
                          runSpacing: 7,
                          children: widget.technologies.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.055),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                tech,
                                style: GoogleFonts.firaCode(
                                  color: const Color(0xFFC7D2FE),
                                  fontSize: 9.5,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.green.withValues(alpha: 0.13),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.trending_up_rounded,
                                color: AppColors.green,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.future,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFA7F3D0),
                                    fontSize: 11.5,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (widget.onProject != null)
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: widget.onProject,
                                  icon: const Icon(
                                    Icons.open_in_new_rounded,
                                    size: 17,
                                  ),
                                  label: Text(widget.actionLabel),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.purpleLight,
                                    foregroundColor: AppColors.background,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.onGithub != null) ...[
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: widget.onGithub,
                                  tooltip: 'GitHub',
                                  style: IconButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.white.withValues(alpha: 0.12),
                                    ),
                                    padding: const EdgeInsets.all(14),
                                  ),
                                  icon: const Icon(Icons.code_rounded),
                                ),
                              ],
                            ],
                          )
                        else
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.045),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.auto_awesome_rounded,
                                  size: 16,
                                  color: AppColors.textMuted,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.actionLabel,
                                  style: GoogleFonts.inter(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _projectPreview() {
    if (widget.imageAsset != null) {
      return AnimatedScale(
        scale: hover ? 1.045 : 1,
        duration: const Duration(milliseconds: 300),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.imageAsset!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _fallbackPreview(),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.card.withValues(alpha: 0.42),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return _fallbackPreview();
  }

  Widget _fallbackPreview() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.previewColor,
            widget.previewColor.withValues(alpha: 0.45),
            AppColors.card,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -45,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Center(
            child: AnimatedScale(
              scale: hover ? 1.12 : 1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              child: Icon(widget.icon, size: 60, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          label: 'TRAJETÓRIA',
          title: 'Minha evolução.',
          description:
              'Uma jornada ainda no começo, construída através de estudo, prática e projetos.',
        ),
        SizedBox(height: 55),
        TimelineItem(
          number: '01',
          title: 'Desenvolvimento de Sistemas',
          subtitle: 'Formação técnica em andamento',
          description:
              'Estudando programação, lógica, desenvolvimento de aplicações e fundamentos da área.',
        ),
        TimelineItem(
          number: '02',
          title: 'Flutter & Dart',
          subtitle: 'Foco atual',
          description:
              'Criando interfaces, aplicativos responsivos, navegação e aprendendo arquitetura de projetos.',
        ),
        TimelineItem(
          number: '03',
          title: 'Arduino',
          subtitle: 'Software + hardware',
          description:
              'Experimentando integração entre aplicativos Flutter e projetos físicos.',
        ),
        TimelineItem(
          number: '04',
          title: 'Cloud',
          subtitle: 'Explorando Azure',
          description:
              'Aprendendo como serviços em nuvem podem fazer parte de aplicações reais.',
          last: true,
        ),
      ],
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final String description;
  final bool last;

  const TimelineItem({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.description,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 55,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.purpleLight,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.purpleLight.withValues(alpha: 0.25),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Text(
                    number,
                    style: GoogleFonts.firaCode(
                      color: AppColors.background,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!last)
                  Container(
                    width: 1,
                    height: 120,
                    color: AppColors.purpleLight.withValues(alpha: 0.20),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.firaCode(
                      color: AppColors.purpleLight,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      height: 1.6,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TechnologiesSection extends StatelessWidget {
  const TechnologiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    const technologies = [
      TechnologyData('Flutter', 'Foco atual', Icons.flutter_dash_rounded),
      TechnologyData('Dart', 'Foco atual', Icons.code_rounded),
      TechnologyData('Git', 'Ferramenta', Icons.account_tree_rounded),
      TechnologyData('GitHub', 'Ferramenta', Icons.terminal_rounded),
      TechnologyData('Arduino', 'Explorando', Icons.memory_rounded),
      TechnologyData('Azure', 'Explorando', Icons.cloud_outlined),
      TechnologyData('HTML', 'Web', Icons.language_rounded),
      TechnologyData('CSS', 'Web', Icons.palette_outlined),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          label: 'TECNOLOGIAS',
          title: 'Minha stack atual.',
          description:
              'Ferramentas que utilizo ou estou estudando. O objetivo não é colecionar tecnologias, mas aprender a utilizá-las para construir projetos.',
        ),
        const SizedBox(height: 55),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            for (int i = 0; i < technologies.length; i++)
              RevealOnScroll(
                delay: Duration(milliseconds: i * 60),
                child: TechnologyCard(data: technologies[i]),
              ),
          ],
        ),
      ],
    );
  }
}

class TechnologyData {
  final String name;
  final String category;
  final IconData icon;

  const TechnologyData(this.name, this.category, this.icon);
}

class TechnologyCard extends StatefulWidget {
  final TechnologyData data;

  const TechnologyCard({super.key, required this.data});

  @override
  State<TechnologyCard> createState() => _TechnologyCardState();
}

class _TechnologyCardState extends State<TechnologyCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedSlide(
        offset: hover ? const Offset(0, -0.05) : Offset.zero,
        duration: const Duration(milliseconds: 220),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 220,
          height: 120,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: hover ? const Color(0xFF172554) : AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: hover
                  ? AppColors.purpleLight
                  : Colors.white.withValues(alpha: 0.07),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: hover ? 0.30 : 0.10),
                blurRadius: hover ? 28 : 12,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              AnimatedScale(
                scale: hover ? 1.14 : 1,
                duration: const Duration(milliseconds: 220),
                child: Icon(
                  widget.data.icon,
                  size: 31,
                  color: AppColors.purpleLight,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.name,
                      style: GoogleFonts.firaCode(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.data.category,
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  final bool mobile;
  final VoidCallback onWhatsapp;
  final VoidCallback onInstagram;
  final VoidCallback onGithub;

  const ContactSection({
    super.key,
    required this.mobile,
    required this.onWhatsapp,
    required this.onInstagram,
    required this.onGithub,
  });

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(mobile ? 28 : 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.purple.withValues(alpha: 0.35),
              AppColors.card,
              AppColors.card,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.30),
              blurRadius: 45,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _content(),
                  const SizedBox(height: 35),
                  _actions(),
                ],
              )
            : Row(
                children: [
                  Expanded(child: _content()),
                  const SizedBox(width: 50),
                  Flexible(child: _actions()),
                ],
              ),
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '<CONTATO />',
          style: GoogleFonts.firaCode(
            color: AppColors.purpleLight,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Vamos conversar?',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Quer trocar uma ideia sobre desenvolvimento ou conversar sobre algum projeto? Você pode falar comigo pelas redes abaixo.',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              height: 1.6,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _actions() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        PrimaryButton(
          texto: 'WhatsApp',
          icon: Icons.chat_rounded,
          onPressed: onWhatsapp,
        ),
        SecondaryButton(
          texto: 'Instagram',
          icon: Icons.camera_alt_outlined,
          onPressed: onInstagram,
        ),
        SecondaryButton(
          texto: 'GitHub',
          icon: Icons.code_rounded,
          onPressed: onGithub,
        ),
      ],
    );
  }
}

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF04070D),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
      child: Column(
        children: [
          Text(
            '<Alves Dev />',
            style: GoogleFonts.firaCode(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Construído com Flutter.',
            style: GoogleFonts.inter(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '© 2026',
            style: GoogleFonts.firaCode(
              color: Colors.white38,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String texto;
  final IconData icon;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.texto,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(texto),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purpleLight,
        foregroundColor: AppColors.background,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String texto;
  final IconData icon;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.texto,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(texto),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.purpleLight,
        side: BorderSide(
          color: AppColors.purpleLight.withValues(alpha: 0.60),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.04),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      icon: Icon(icon, color: AppColors.textSecondary),
    );
  }
}

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  final Key visibilityKey = UniqueKey();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: visibilityKey,
      onVisibilityChanged: (info) {
        if (visible) return;
        if (info.visibleFraction > 0.10) {
          setState(() => visible = true);
        }
      },
      child: widget.child
          .animate(target: visible ? 1 : 0)
          .fade(
            begin: 0,
            end: 1,
            delay: widget.delay,
            duration: 650.ms,
            curve: Curves.easeOut,
          )
          .slide(
            begin: const Offset(0, 0.07),
            end: Offset.zero,
            delay: widget.delay,
            duration: 650.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}
