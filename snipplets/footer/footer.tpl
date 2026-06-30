{% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
{% set has_footer_contact_info = (store.whatsapp or store.phone or store.email or store.address or store.blog) and settings.footer_contact_show %}
{% set has_footer_logo = "footer_logo.jpg" | has_custom_image %}
{% set has_footer_institutional_info = has_footer_logo or settings.footer_about_description %}
{% set has_footer_contact_or_institutional_info = has_social_network or has_footer_contact_info or has_footer_institutional_info %}
{% set has_footer_menu = settings.footer_menu and settings.footer_menu_show %}
{% set has_footer_menu_secondary = settings.footer_menu_secondary and settings.footer_menu_secondary_show %}
{% set has_menus = has_footer_menu or has_footer_menu_secondary %}
{% set password_page = template == 'password' %}
{% set footer_color_classes = settings.footer_colors ? 'footer-colors' %}
{% set footer_menu_title = settings.footer_menu_title ? settings.footer_menu_title : 'Navegación' | translate %}
{% set hide_footer_menu_title = footer_menu_title in ['Categorías', 'Categorias'] %}

<footer class="js-footer ivana-footer {{ footer_color_classes }} display-when-content-ready" data-store="footer">
	<div class="container ivana-footer-main">
		<div class="ivana-footer-grid{% if settings.news_show and not password_page %} ivana-footer-grid-news{% endif %}">
			<div class="ivana-footer-col ivana-footer-col-contact">
				{% if has_footer_logo %}
					{{ component(
						'image',{
							image_name: 'footer_logo.jpg',
							image_classes: 'footer-logo-img ivana-footer-logo mb-4',
							image_alt: store.name,
						})
					}}
				{% else %}
					<div class="ivana-footer-brand mb-4">{{ store.name }}</div>
				{% endif %}

				{% if has_social_network %}
					<div class="ivana-footer-social mb-4">
						{% include "snipplets/social/social-links.tpl" %}
					</div>
				{% endif %}

				{% if settings.footer_about_description %}
					<div class="ivana-footer-about mb-4">{{ settings.footer_about_description }}</div>
				{% endif %}

				{% if has_footer_contact_info %}
					<div class="ivana-footer-contact-links">
						{% include "snipplets/contact-links.tpl" with {dedupe_whatsapp_phone: true} %}
					</div>
				{% endif %}
			</div>

		{% if has_footer_menu and not password_page %}
			<div class="ivana-footer-col ivana-footer-col-nav">
				{% if not hide_footer_menu_title and not settings.footer_menus_toggle %}
					<div class="ivana-footer-title">{{ footer_menu_title }}</div>
				{% endif %}
				{% include "snipplets/footer/footer-navigation.tpl" with {show_footer_navigation_title: settings.footer_menus_toggle and not hide_footer_menu_title} %}
			</div>
		{% endif %}

		{% if has_footer_menu_secondary and not password_page %}
			<div class="ivana-footer-col ivana-footer-col-nav">
				{% if not settings.footer_menus_toggle %}
					<div class="ivana-footer-title">{{ settings.footer_menu_secondary_title ? settings.footer_menu_secondary_title : 'Información' | translate }}</div>
				{% endif %}
				{% include "snipplets/footer/footer-navigation.tpl" with {footer_menu_secondary: true, show_footer_navigation_title: settings.footer_menus_toggle} %}
			</div>
		{% endif %}

			{% if settings.news_show and not password_page %}
				<div class="ivana-footer-col ivana-footer-col-newsletter">
					<div class="ivana-footer-title">{{ settings.news_title ? settings.news_title : 'Newsletter' | translate }}</div>
					{% if settings.news_description %}
						<div class="ivana-footer-news-description mb-3">{{ settings.news_description }}</div>
					{% endif %}
					{% include "snipplets/forms/newsletter.tpl" with {
						form_classes: 'ivana-footer-newsletter-form',
						form_empty_action_js: true,
						form_data_store: 'newsletter-form',
						input_custom_class: 'ivana-footer-newsletter-input',
						submit_custom_class: 'ivana-footer-newsletter-submit',
					} %}
				</div>
			{% endif %}
		</div>
	</div>

	<div class="container ivana-footer-payments-row">
		{% include "snipplets/footer/footer-legal.tpl" %}
	</div>
</footer>
