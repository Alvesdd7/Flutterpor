const WHATSAPP_NUMBER = "5517991656885";
const WHATSAPP_MESSAGE =
  "Olá João! Vi seu portfólio e gostaria de conversar com você.";

const whatsappUrl =
  `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(WHATSAPP_MESSAGE)}`;

document.querySelectorAll(".whatsapp").forEach((element) => {
  element.href = whatsappUrl;
  element.target = "_blank";
  element.rel = "noopener noreferrer";
});

// Menu mobile
const menuButton = document.getElementById("menuButton");
const mobileNav = document.getElementById("mobileNav");

menuButton?.addEventListener("click", () => {
  mobileNav.classList.toggle("open");
});

mobileNav?.querySelectorAll("a").forEach((link) => {
  link.addEventListener("click", () => {
    mobileNav.classList.remove("open");
  });
});

// Animações ao rolar
const revealObserver = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
        revealObserver.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.12 }
);

document.querySelectorAll(".reveal").forEach((element) => {
  revealObserver.observe(element);
});

// Terminal animado inspirado no visual original do portfólio
const scripts = [
  {
    command: "flutter run",
    outputs: [
      ["Launching lib/main.dart...", "output-muted"],
      ["✓ Build completed", "output-green"],
      ["✓ App running", "output-green"],
    ],
  },
  {
    command: "whoami",
    outputs: [
      ["João Alves", "output-purple"],
      ["Estudante de Desenvolvimento de Sistemas", "output-muted"],
    ],
  },
  {
    command: "focus",
    outputs: [
      ["Flutter • Dart • Mobile", "output-purple"],
      ["status: learning & building...", "output-green"],
    ],
  },
  {
    command: "portfolio --about-ai",
    outputs: [
      ["AI: development partner", "output-purple"],
      ["transparency: enabled ✓", "output-green"],
    ],
  },
];

const typedCommand = document.getElementById("typedCommand");
const terminalOutput = document.getElementById("terminalOutput");

const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function typeCommand(text) {
  typedCommand.textContent = "";

  for (const char of text) {
    typedCommand.textContent += char;
    await wait(76);
  }
}

async function showOutput(outputs) {
  terminalOutput.innerHTML = "";

  for (const [text, cssClass] of outputs) {
    const line = document.createElement("div");
    line.className = `output-line ${cssClass}`;
    line.textContent = text;
    terminalOutput.appendChild(line);
    await wait(620);
  }
}

async function runTerminal() {
  await wait(650);

  let index = 0;

  while (true) {
    const current = scripts[index];

    terminalOutput.innerHTML = "";
    await typeCommand(current.command);
    await wait(420);
    await showOutput(current.outputs);
    await wait(2600);

    index = (index + 1) % scripts.length;
  }
}

runTerminal();
