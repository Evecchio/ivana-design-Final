{# /* Style tokens */ #}

{# Opacity hex suffixes para construir colores con transparencia #}
{% set opacity_03 = '08' %}
{% set opacity_05 = '0D' %}
{% set opacity_10 = '1A' %}
{% set opacity_20 = '33' %}
{% set opacity_30 = '4D' %}
{% set opacity_40 = '66' %}
{% set opacity_50 = '80' %}
{% set opacity_60 = '99' %}
{% set opacity_70 = 'B3' %}
{% set opacity_80 = 'CC' %}

:root {
  
  {#/*============================================================================
    #Colors
  ==============================================================================*/#}

  {#### Colors settings #}

  {# Main colors #}

  {% set main_background = settings.background_color %}
  {% set main_foreground = settings.text_color %}

  {% set accent_color = '#FF1493' %}

  {% set button_background = accent_color %}
  {% set button_foreground = '#ffffff' %}

  {% set label_background = accent_color %}
  {% set label_foreground = '#ffffff' %}

  {% set label_shipping_background = accent_color %}
  {% set label_shipping_foreground = '#ffffff' %}

  {% set banner_services_background = settings.banner_services_background_color %}
  {% set banner_services_foreground = settings.banner_services_foreground_color %}

  {% set stock_color = accent_color %}

  {% set header_background = settings.header_colors ? settings.header_background_color : main_background %}
  {% set header_foreground = settings.header_colors ? settings.header_foreground_color : main_foreground %}

  {% set footer_background = settings.footer_colors ? settings.footer_background_color : main_background %}
  {% set footer_foreground = settings.footer_colors ? settings.footer_foreground_color : main_foreground %}

  {% set newsletter_background = settings.newsletter_colors ? settings.newsletter_background_color : main_background %}
  {% set newsletter_foreground = settings.newsletter_colors ? settings.newsletter_foreground_color : main_foreground %}

  /* --- Brand & Premium Colors --- */
  --accent-color: {{ accent_color }};
  --accent-color-hover: {{ accent_color }}EE; /* 93% opacity for hover */
  --accent-color-soft: {{ accent_color }}1A;  /* 10% opacity for backgrounds */

  /* --- Neutral Palette --- */
  --main-background: {{ main_background }};
  --main-foreground: {{ main_foreground }};
  
  /* Text semantic colors */
  --text-primary: {{ main_foreground }};
  --text-secondary: {{ main_foreground }}{{ opacity_70 }};
  --text-muted: {{ main_foreground }}{{ opacity_50 }};
  --text-on-accent: #ffffff;

  /* Surfaces & Overlays */
  --bg-surface: {{ main_background }};
  --bg-surface-alt: {{ main_foreground }}{{ opacity_03 }};
  --bg-overlay: rgba(0, 0, 0, 0.72);
  --text-on-overlay: #ffffff;
  
  --border-color: {{ main_foreground }}{{ opacity_10 }};
  --border-color-light: {{ main_foreground }}{{ opacity_05 }};

  /* --- Functional Components --- */
  --button-background: var(--accent-color);
  --button-foreground: var(--text-on-accent);

  --label-background: var(--accent-color);
  --label-foreground: var(--text-on-accent);

  --label-shipping-background: var(--accent-color);
  --label-shipping-foreground: var(--text-on-accent);

  --stock-color: var(--accent-color);
  
  --header-background: {{ header_background }};
  --header-foreground: {{ header_foreground }};

  --header-desktop-nav-background: var(--header-background);
  --header-desktop-nav-foreground: var(--header-foreground);
  --header-search-btn-background: var(--header-background);
  --header-search-btn-foreground: var(--header-foreground);

  --banner-services-background: {{ banner_services_background }};
  --banner-services-foreground: {{ banner_services_foreground }};

  --main-text-transform: none;

  --header-badge-background: var(--accent-color);
  --header-badge-foreground: var(--text-on-accent);

  --primary-adbar-background: var(--accent-color);
  --primary-adbar-foreground: var(--text-on-accent);
  --secondary-adbar-background: var(--accent-color);
  --secondary-adbar-foreground: var(--text-on-accent);

  --footer-background: var(--accent-color);
  --footer-foreground: #ffffff;

  --newsletter-background: var(--accent-color);
  --newsletter-foreground: #ffffff;

  /* --- Opacity Helpers --- */
  --main-foreground-opacity-03: {{ main_foreground }}{{ opacity_03 }};
  --main-foreground-opacity-05: {{ main_foreground }}{{ opacity_05 }};
  --main-foreground-opacity-10: {{ main_foreground }}{{ opacity_10 }};
  --main-foreground-opacity-20: {{ main_foreground }}{{ opacity_20 }};
  --main-foreground-opacity-30: {{ main_foreground }}{{ opacity_30 }};
  --main-foreground-opacity-40: {{ main_foreground }}{{ opacity_40 }};
  --main-foreground-opacity-50: {{ main_foreground }}{{ opacity_50 }};
  --main-foreground-opacity-60: {{ main_foreground }}{{ opacity_60 }};
  --main-foreground-opacity-70: {{ main_foreground }}{{ opacity_70 }};

  --main-background-opacity-30: {{ main_background }}{{ opacity_30 }};
  --main-background-opacity-50: {{ main_background }}{{ opacity_50 }};
  --main-background-opacity-80: {{ main_background }}{{ opacity_80 }};

  --label-shipping-background-80: {{ label_shipping_background }}{{ opacity_80 }};

  --newsletter-foreground-opacity-50: {{ newsletter_foreground }}{{ opacity_50 }};

  --footer-foreground-opacity-40: {{ footer_foreground }}{{ opacity_40 }};
  --footer-foreground-opacity-60: {{ footer_foreground }}{{ opacity_60 }};

  {# Alert colors CSS #}

  --success: #4bb98c;
  --danger: #dd7774;
  --warning: #dc8f38;

  {#/*============================================================================
    #Fonts
  ==============================================================================*/#}

  {# Font families #}

  --heading-font: {{ settings.font_headings | raw }};
  --body-font: {{ settings.font_rest | raw }};

  {# Font sizes #}

  {% set font_base_size = settings.font_base_size %}

  --font-base: {{ font_base_size }}px;
  --font-base-default: 16px;

  {% set font_rest_size = settings.font_rest_size %}

  --font-huge: {{ font_rest_size + 5 }}px;
  --font-big: {{ font_rest_size + 4 }}px;
  --font-medium: {{ font_rest_size + 2 }}px;
  --font-small: {{ font_rest_size }}px;
  --font-smallest: {{ font_rest_size - 2 }}px;
  --font-extra-smallest: {{ font_rest_size - 3 }}px;

  {# Scales using 1.2 minor third scale #}

  {% set heading_size = settings.headings_size %}

  --h1: {{ heading_size }}px;
  --h2: {{ (heading_size * 0.833) | round }}px;
  --h3: {{ (heading_size * 0.6875) | round }}px;
  --h4: {{ (heading_size * 0.583) | round }}px;
  --h5: {{ (heading_size * 0.479) | round }}px;
  --h6: {{ (heading_size * 0.396) | round }}px;
  --h6-small: {{ (heading_size * 0.3333) | round }}px;

  {# Titles weight #}

  {% set title_weight = settings.headings_bold ? '700' : '400' %}

  --title-font-weight: {{ title_weight }};

  {#/*============================================================================
    #Layout
  ==============================================================================*/#}

  {# Spacing #}

  --spacing-base: 16px;
  --spacing-half: calc(var(--spacing-base) / 2);
  --spacing-quarter: calc(var(--spacing-base) / 4);

  --spacing-1: calc(var(--spacing-base) * 0.25);
  --spacing-2: calc(var(--spacing-base) * 0.5);
  --spacing-3: var(--spacing-base);
  --spacing-4: calc(var(--spacing-base) * 1.5);
  --spacing-5: calc(var(--spacing-base) * 3);

  {# Gutters #}

  --gutter: var(--spacing-base);
  --gutter-container: var(--gutter);
  --gutter-container-md: calc(var(--gutter) * 2);
  --gutter-negative: calc(var(--gutter) * -1);
  --gutter-half: calc(var(--gutter) / 2);
  --gutter-half-negative: calc(var(--gutter) * -1 / 2);
  --gutter-double: calc(var(--gutter) * 2);

  {#/*============================================================================
    #Misc
  ==============================================================================*/#}

  {# Transitions #}

  --transition-fast: all 0.05s ease;
  --transition-normal: all 0.3s ease;
  --transition-slow: all 1s ease;

  {# Shadows #}

  --drop-shadow: 0 0 8px 4px var(--main-foreground-opacity-05);

  {# Border radius #}

  --border-radius: 8px;
  --border-radius-medium: calc(var(--border-radius) / 1.3333);
  --border-radius-small: calc(var(--border-radius) / 2);
  --border-radius-smallest: calc(var(--border-radius) / 4);
  --border-radius-full: 100%;

  {# Border stroke #}

  --border-solid: 1px solid;

  {#/*============================================================================
    #Marca — Ivana Design (fuente única de verdad para colores de marca)
  ==============================================================================*/#}

  --brand:        #FF1493;
  --brand-dark:   #cc007a;
  --brand-80:     rgba(255, 20, 147, 0.80);
  --brand-50:     rgba(255, 20, 147, 0.50);
  --brand-20:     rgba(255, 20, 147, 0.20);
  --brand-10:     rgba(255, 20, 147, 0.10);

  {# Neutros #}
  --negro:        #111111;
  --gris-oscuro:  #333333;
  --gris:         #666666;
  --gris-claro:   #f8f8f8;
  --blanco:       #ffffff;
  --negro-80:     rgba(0, 0, 0, 0.80);
  --negro-50:     rgba(0, 0, 0, 0.50);
  --negro-10:     rgba(0, 0, 0, 0.10);
  --negro-05:     rgba(0, 0, 0, 0.05);
  --blanco-80:    rgba(255, 255, 255, 0.80);
  --blanco-20:    rgba(255, 255, 255, 0.20);

  {#/*============================================================================
    #Sistema fluido — Tipografía, espaciado e iconos con clamp()
  ==============================================================================*/#}

  {# Tipografía fluida #}
  --fluid-body:    clamp(0.875rem, 0.82rem + 0.25vw, 1.125rem);
  --fluid-h1:      clamp(2rem, 1.4rem + 2.8vw, 4.2rem);
  --fluid-h2:      clamp(1.6rem, 1.2rem + 1.8vw, 3rem);
  --fluid-h3:      clamp(1.2rem, 1rem + 0.9vw, 2rem);
  --fluid-small:   clamp(0.68rem, 0.64rem + 0.18vw, 0.8rem);
  --fluid-caption: clamp(0.6rem, 0.56rem + 0.15vw, 0.72rem);

  {# Espaciado fluido #}
  --fluid-space-xs: clamp(0.25rem, 0.2rem + 0.2vw, 0.5rem);
  --fluid-space-sm: clamp(0.5rem, 0.4rem + 0.4vw, 1rem);
  --fluid-space-md: clamp(1rem, 0.8rem + 0.8vw, 2rem);
  --fluid-space-lg: clamp(1.5rem, 1rem + 2vw, 3.5rem);
  --fluid-space-xl: clamp(2rem, 1.2rem + 3.5vw, 5rem);

  {# Logo fluido #}
  --logo-height:    clamp(40px, 3.5vw + 20px, 78px);
  --logo-max-width: clamp(120px, 15vw + 60px, 280px);

  {# Contenedor fluido #}
  --fluid-gutter:   clamp(0.75rem, 0.5rem + 2vw, 2.5rem);

  {# Iconos de utilidad fluidos #}
  --utility-size:   clamp(34px, 2vw + 16px, 44px);
  --utility-icon:   clamp(16px, 0.6vw + 12px, 20px);

  {# Categorías home #}
  --cat-circle:     clamp(72px, 6vw + 28px, 120px);

  {# Buscador #}
  --search-height:  clamp(40px, 2vw + 22px, 50px);
  --search-icon:    clamp(14px, 0.5vw + 10px, 18px);

  {# Variables Ivana (complementarias al sistema base) #}
  --ivana-content-max-width: 1440px;
  --ivana-narrow-max-width:  1240px;
  --ivana-shell-radius:      32px;
  --ivana-card-radius:       24px;
  --ivana-card-radius-mobile: 20px;
  --ivana-radius-sm:         8px;
  --ivana-radius-md:         12px;
  --ivana-radius-pill:       999px;
  --ivana-control-height:    48px;
  --ivana-surface:           #ffffff;
  --ivana-surface-soft:      #fbf7f8;
  --ivana-surface-tint:      #fff1f6;
  --ivana-border:            rgba(17, 17, 17, 0.09);
  --ivana-border-strong:     rgba(17, 17, 17, 0.14);
  --ivana-text:              #151417;
  --ivana-text-soft:         #655f66;
  --ivana-text-muted:        #8a8388;
  --ivana-success:           #008f45;
  --ivana-warning:           #f57c00;
  --ivana-danger:            #d32f2f;
  --ivana-focus-ring:        0 0 0 3px rgba(255, 20, 147, 0.22);
  --ivana-shadow-soft:       0 26px 72px rgba(17, 17, 17, 0.08);
  --ivana-shadow-card:       0 18px 46px rgba(17, 17, 17, 0.06);
  --ivana-shadow-focus:      0 0 0 3px rgba(255, 20, 147, 0.22);

}

/* ============================================================
   PREMIUM UPGRADE — Minimalista Luxury
   ============================================================ */

h1, h2, h3, h4, h5, h6,
.h1, .h2, .h3, .h4, .h5, .h6 {
  letter-spacing: -0.01em;
}

.js-products-featured-title,
.js-products-new-title,
.js-products-sale-title {
  letter-spacing: 0.12em;
  text-transform: uppercase;
  font-weight: 600;
  margin-bottom: 2rem;
  padding-bottom: 0.75rem;
  position: relative;
}
.js-products-featured-title::after,
.js-products-new-title::after,
.js-products-sale-title::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 36px;
  height: 2px;
  background: var(--accent-color);
}

.section-home { padding-top: 3rem; padding-bottom: 3rem; }
@media (min-width: 768px) {
  .section-home { padding-top: 5rem; padding-bottom: 5rem; }
}

.js-product-container .product-item-image-container { overflow: hidden; }
.js-product-container .product-item-image-container img { transition: transform 0.55s ease; }
.js-product-container:hover .product-item-image-container img { transform: none; }

/* Contener el badge dentro del slider de imágenes */
.product-images-slider {
  overflow: hidden;
}

.product-discount-overlay {
  position: absolute !important;
  top: 10px !important;
  left: 10px !important;
  right: auto !important;
  z-index: 10 !important;
  display: flex !important;
  flex-direction: column !important;
  align-items: flex-start !important;
  gap: 4px !important;
  pointer-events: none !important;
}
.product-discount-badge {
  display: inline-block;
  background: var(--accent-color);
  color: var(--button-foreground);
  font-size: 11px;
  font-weight: 700;
  padding: 3px 8px;
  letter-spacing: 0.06em;
  line-height: 1.4;
}
.product-price-badge {
  display: inline-block;
  background: rgba(0, 0, 0, 0.72);
  color: #fff;
  font-size: 11px;
  font-weight: 600;
  padding: 3px 8px;
  letter-spacing: 0.03em;
  line-height: 1.4;
}

.btn-primary, .btn-secondary {
  letter-spacing: 0.07em;
  text-transform: uppercase;
  font-size: var(--font-smallest);
  font-weight: 600;
}
.btn.btn-small {
  letter-spacing: 0.07em;
  text-transform: uppercase;
  font-size: var(--font-extra-smallest);
}

.js-footer { border-top: 1px solid var(--main-foreground-opacity-10); }
.js-footer a { letter-spacing: 0.02em; transition: var(--transition-fast); text-decoration: none; }
.js-footer a:hover { opacity: 0.7; }
.footer-main-info { padding-top: 3rem; padding-bottom: 3rem; }
