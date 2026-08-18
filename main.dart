import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const AlvesPortfolioApp());
}

class AppColors {
  static const background = Color(0xFF050814);
  static const background2 = Color(0xFF0B1022);
  static const card = Color(0xCC11172A);
  static const border = Color(0x22FFFFFF);
  static const primary = Color(0xFF5B7CFF);
  static const secondary = Color(0xFFA855F7);
  static const accent = Color(0xFF22C55E);
  static const text = Color(0xFFF8FAFC);
  static const muted = Color(0xFF94A3B8);
}

class AlvesPortfolioApp extends StatelessWidget {
  const AlvesPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'João Pedro Alves Santos',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.background2,
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
  final _scroll = ScrollController();
  final _inicioKey = GlobalKey();
  final _sobreKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _iaKey = GlobalKey();
  final _contatoKey = GlobalKey();

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse(
      'https://wa.me/5517991656885?text=${Uri.encodeComponent('Olá João! Vi seu portfólio e gostaria de conversar com você.')}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _goTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      alignment: 0.04,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < 820;

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _Background()),
          Positioned.fill(
            child: CustomScrollView(
              controller: _scroll,
              slivers: [
                SliverToBoxAdapter(
                  child: _NavBar(
                    mobile: mobile,
                    onInicio: () => _goTo(_inicioKey),
                    onSobre: () => _goTo(_sobreKey),
                    onSkills: () => _goTo(_skillsKey),
                    onIa: () => _goTo(_iaKey),
                    onContato: () => _goTo(_contatoKey),
                    onWhatsApp: _openWhatsApp,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _HeroSection(
                    key: _inicioKey,
                    mobile: mobile,
                    onAbout: () => _goTo(_sobreKey),
                    onWhatsApp: _openWhatsApp,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _Section(
                    key: _sobreKey,
                    eyebrow: 'Sobre mim',
                    title: 'Aprendendo, construindo e evoluindo',
                    subtitle:
                        'Sou estudante de Desenvolvimento de Sistemas e gosto de transformar ideias em experiências digitais modernas, funcionais e intuitivas.',
                    child: const _AboutCards(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _Section(
                    key: _skillsKey,
                    eyebrow: 'Habilidades',
                    title: 'Tecnologias que estou aprendendo',
                    subtitle:
                        'Meu foco é evoluir na prática, entendendo cada vez melhor como as soluções funcionam de verdade.',
                    child: const _SkillsGrid(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _Section(
                    key: _iaKey,
                    eyebrow: 'IA no processo',
                    title: 'Este portfólio também é parte do meu aprendizado',
                    subtitle:
                        'O projeto foi desenvolvido juntamente com inteligência artificial. Usei IA como parceira para planejar, revisar código, explorar ideias de interface e aprender durante o processo — sem esconder isso.',
                    child: const _IaCard(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _Section(
                    key: _contatoKey,
                    eyebrow: 'Contato',
                    title: 'Vamos conversar?',
                    subtitle:
                        'Se você quer falar sobre uma ideia, oportunidade, colaboração ou simplesmente trocar experiência, pode me chamar no WhatsApp.',
                    child: _ContactCard(onWhatsApp: _openWhatsApp),
                  ),
                ),
                const SliverToBoxAdapter(child: _Footer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatefulWidget {
  const _Background();

  @override
  State<_Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<_Background>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, -1 + t * .3),
              end: Alignment(1, 1 - t * .3),
              colors: const [
                AppColors.background,
                Color(0xFF071120),
                Color(0xFF11102B),
                Color(0xFF090A16),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: -120 + t * 60,
                top: 120,
                child: const _GlowOrb(
                  size: 380,
                  color: AppColors.primary,
                ),
              ),
              Positioned(
                right: -80,
                bottom: 120 + t * 70,
                child: const _GlowOrb(
                  size: 340,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: .18),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final bool mobile;
  final VoidCallback onInicio;
  final VoidCallback onSobre;
  final VoidCallback onSkills;
  final VoidCallback onIa;
  final VoidCallback onContato;
  final VoidCallback onWhatsApp;

  const _NavBar({
    required this.mobile,
    required this.onInicio,
    required this.onSobre,
    required this.onSkills,
    required this.onIa,
    required this.onContato,
    required this.onWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1240),
          margin: EdgeInsets.fromLTRB(mobile ? 14 : 30, 16, mobile ? 14 : 30, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xAA0B1022),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Text(
                      'JP',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'João Pedro Alves Santos',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    if (!mobile) ...[
                      _NavButton('Início', onInicio),
                      _NavButton('Sobre', onSobre),
                      _NavButton('Habilidades', onSkills),
                      _NavButton('IA', onIa),
                      _NavButton('Contato', onContato),
                      const SizedBox(width: 10),
                    ],
                    FilledButton.icon(
                      onPressed: onWhatsApp,
                      icon: const Icon(Icons.chat_rounded, size: 18),
                      label: Text(mobile ? 'WhatsApp' : 'Enviar mensagem'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _NavButton(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(text),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool mobile;
  final VoidCallback onAbout;
  final VoidCallback onWhatsApp;

  const _HeroSection({
    super.key,
    required this.mobile,
    required this.onAbout,
    required this.onWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1240),
        padding: EdgeInsets.fromLTRB(
          mobile ? 24 : 48,
          mobile ? 72 : 120,
          mobile ? 24 : 48,
          mobile ? 70 : 110,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Badge(text: 'Olá, eu sou 👋'),
            const SizedBox(height: 24),
            Text(
              'João Pedro\nAlves Santos',
              style: TextStyle(
                fontSize: mobile ? 48 : 74,
                height: .98,
                fontWeight: FontWeight.w900,
                letterSpacing: -2.5,
              ),
            ),
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ).createShader(rect),
              child: Text(
                'Desenvolvedor em formação',
                style: TextStyle(
                  fontSize: mobile ? 25 : 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: const Text(
                'Estudante de Desenvolvimento de Sistemas, apaixonado por tecnologia, interfaces e pelo processo de transformar ideias em soluções digitais.',
                style: TextStyle(
                  fontSize: 17,
                  height: 1.7,
                  color: AppColors.muted,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: onWhatsApp,
                  icon: const Icon(Icons.chat_rounded),
                  label: const Text('Fale comigo no WhatsApp'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: onAbout,
                  icon: const Icon(Icons.arrow_downward_rounded),
                  label: const Text('Mais sobre mim'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  const _Section({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 820;
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1240),
        padding: EdgeInsets.symmetric(
          horizontal: mobile ? 24 : 48,
          vertical: mobile ? 64 : 90,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Badge(text: eyebrow),
            const SizedBox(height: 18),
            Text(
              title,
              style: TextStyle(
                fontSize: mobile ? 34 : 48,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.4,
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.7,
                  color: AppColors.muted,
                ),
              ),
            ),
            const SizedBox(height: 34),
            child,
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;

  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: .25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFB7C5FF),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _AboutCards extends StatelessWidget {
  const _AboutCards();

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveGrid(
      minWidth: 235,
      children: [
        _InfoCard(
          icon: Icons.school_outlined,
          title: 'Formação',
          text: 'Estudante de Desenvolvimento de Sistemas.',
        ),
        _InfoCard(
          icon: Icons.menu_book_rounded,
          title: 'Aprendizado contínuo',
          text: 'Praticando e evoluindo todos os dias.',
        ),
        _InfoCard(
          icon: Icons.lightbulb_outline_rounded,
          title: 'Foco em soluções',
          text: 'Entender problemas e construir soluções úteis.',
        ),
        _InfoCard(
          icon: Icons.rocket_launch_outlined,
          title: 'Objetivo',
          text: 'Crescer no mercado de tecnologia com base sólida.',
        ),
      ],
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  const _SkillsGrid();

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveGrid(
      minWidth: 165,
      children: [
        _SkillCard(icon: Icons.flutter_dash, name: 'Flutter'),
        _SkillCard(icon: Icons.code_rounded, name: 'Dart'),
        _SkillCard(icon: Icons.language_rounded, name: 'HTML'),
        _SkillCard(icon: Icons.palette_outlined, name: 'CSS'),
        _SkillCard(icon: Icons.javascript_rounded, name: 'JavaScript'),
        _SkillCard(icon: Icons.account_tree_outlined, name: 'Git'),
        _SkillCard(icon: Icons.terminal_rounded, name: 'Linux'),
        _SkillCard(icon: Icons.design_services_outlined, name: 'UI/UX'),
      ],
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  final double minWidth;
  final List<Widget> children;

  const _ResponsiveGrid({
    required this.minWidth,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / minWidth).floor().clamp(1, 4);
        final width =
            (constraints.maxWidth - ((columns - 1) * 14)) / columns;

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: children
              .map((child) => SizedBox(width: width, child: child))
              .toList(),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.muted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final IconData icon;
  final String name;

  const _SkillCard({
    required this.icon,
    required this.name,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, hover ? -6 : 0, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: hover
              ? AppColors.primary.withValues(alpha: .12)
              : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hover
                ? AppColors.primary.withValues(alpha: .35)
                : AppColors.border,
          ),
        ),
        child: Column(
          children: [
            Icon(widget.icon, size: 34, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(
              widget.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _IaCard extends StatelessWidget {
  const _IaCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      glow: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            size: 42,
            color: AppColors.secondary,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Desenvolvido juntamente com IA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'A inteligência artificial foi usada como ferramenta de apoio no desenvolvimento deste portfólio. O objetivo foi combinar criatividade, estudo e tecnologia para acelerar meu aprendizado e melhorar o resultado final.',
                  style: TextStyle(
                    color: AppColors.muted,
                    height: 1.7,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _MiniChip('Planejamento'),
                    _MiniChip('Código'),
                    _MiniChip('Design'),
                    _MiniChip('Revisão'),
                    _MiniChip('Aprendizado'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  final String text;

  const _MiniChip(this.text);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(text),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final VoidCallback onWhatsApp;

  const _ContactCard({required this.onWhatsApp});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 24,
        runSpacing: 24,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WhatsApp',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '+55 17 99165-6885',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          FilledButton.icon(
            onPressed: onWhatsApp,
            icon: const Icon(Icons.chat_rounded),
            label: const Text('Enviar mensagem'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final bool glow;

  const _GlassCard({
    required this.child,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: glow
              ? AppColors.secondary.withValues(alpha: .38)
              : AppColors.border,
        ),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: .10),
                  blurRadius: 40,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1240),
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 50),
        child: const Row(
          children: [
            Icon(Icons.code_rounded, color: AppColors.primary),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'João Pedro Alves Santos • Portfólio em Flutter Web',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
