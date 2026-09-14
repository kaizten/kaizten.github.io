const toggle = document.querySelector<HTMLButtonElement>(".nav-toggle");
const navigation = document.querySelector<HTMLElement>("#site-navigation");

if (toggle && navigation) {
  toggle.addEventListener("click", () => {
    const isOpen = navigation.classList.toggle("is-open");
    toggle.setAttribute("aria-expanded", String(isOpen));
  });
}

