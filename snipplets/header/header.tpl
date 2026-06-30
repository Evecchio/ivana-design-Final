{# Header classes #}

{% set header_position_md_classes = settings.head_fix_desktop ? 'position-sticky-md' : 'position-relative-md' %}
{% set header_position_classes = 'position-sticky ' ~ header_position_md_classes %}
{% set header_colors_classes = settings.header_colors ? 'head-colors' %}
{% set header_with_categories_classes = settings.head_main_categories ? 'head-with-mobile-categories' %}

{# Logo classes #}

{% set header_logo_classes = settings.logo_position_mobile == 'center' ? 'logo-center' : 'logo-left' %}
{% set header_logo_md_classes = settings.logo_position_desktop == 'center' ? 'logo-md-center' : 'logo-md-left' %}
{% set logo_size_class = settings.logo_size == 'small' ? 'logo-small' : settings.logo_size == 'big' ? 'logo-big' %}

{# Logo sizes #}

{% set logo_size_thumbnail = settings.logo_size == 'big' ? 'huge' : 'large' %}
{% set header_logo_src = store.logo ? store.logo : ('images/logo-transparent.svg' | static_url) %}

{# Utilities #}

{% set utilities_md_spacing_class = settings.utilities_type_desktop == 'icons' ? 'icons-md-only' %}
{% set has_languages = languages | length > 1 %}
{% set utilities_languages_main_nav = has_languages and settings.utilities_type_desktop == 'icons' %}
{% set utilities_languages_secondary_nav = has_languages and settings.utilities_type_desktop == 'icons_text' %}

{# Navigation #}

{% set nav_secondary_col = settings.head_secondary_menu_show or utilities_languages_secondary_nav %}
{% set nav_desktop_color_class = settings.desktop_nav_colors ? 'nav-desktop-colors' %}
{% set nav_desktop_grid_class = settings.category_item or nav_secondary_col ? 'nav-desktop-grid' %}
{% set nav_desktop_grid_secondary_nav_class = settings.head_secondary_menu_show and not settings.category_item ? 'nav-desktop-grid-secondary-nav-only' %}
{% set nav_desktop_text_class = settings.desktop_main_nav_uppercase ? 'nav-desktop-uppercase' %}

<header class="js-head-main head-main {{ header_colors_classes }} {{ header_position_classes }} {{ header_with_categories_classes }} transition-soft" data-store="head" data-header-md-fixed="{{ settings.head_fix_desktop ? 'true' : 'false' }}">
	{% include "snipplets/header/header-advertising.tpl" with {adbar_primary: true} %}
	{% include "snipplets/header/header-advertising.tpl" with {adbar_secondary: true} %}
	<div class="js-head-row head-row container ivana-header-layout {{ header_logo_classes }} {{ header_logo_md_classes }}">

		{# Menu #}

		<div class="menu-container head-slot head-slot-menu d-md-none">
			{% include "snipplets/header/utilities/menu.tpl" %}
		</div>

		{# Logo #}

		<div class="js-logo-container logo-container head-slot head-slot-logo">
			<div class="m-0 ivana-logo-wrap">
				<a href="{{ store.url }}" class="ivana-logo-link" aria-label="{{ store.name }}">
					<img src="{{ header_logo_src }}" alt="{{ store.name }}" class="logo-img {{ logo_size_class }} ivana-logo-img transition-soft" width="640" height="171" loading="eager" fetchpriority="high" decoding="async">
				</a>
			</div>
		</div>

		{# Search #}

		<div class="search-container head-slot head-slot-search" role="search" aria-label="{{ 'Buscar productos' | translate }}">
			{{ component('search/search-form', {
				form_classes: { 
					input_group: 'position-relative m-0', 
					input: 'input_class', 
					submit: 'svg-icon-mask ', 
					delete_content: 'svg-icon-mask',  
					search_suggestions_container: ''
				}
				}) 
			}}
		</div>

		{# Utilities #}

		<div class="utilities-container head-slot head-slot-utilities {{ utilities_md_spacing_class }}">
			{% if utilities_languages_main_nav or (params.preview and has_languages) %}
				<span class="d-none d-md-inline-block">
					{% include "snipplets/header/utilities/language.tpl" with {dropdown: true} %}
				</span>
			{% endif %}
			{% include "snipplets/header/utilities/account.tpl" %}
			{% include "snipplets/header/utilities/cart.tpl" %}
		</div>

	</div>{# /ivana-header-layout #}

	{# Add to cart notification — fuera del grid para no romper el layout #}

	{% if settings.ajax_cart %}
		{{ component(
			'notification',{
				type: 'add_to_cart',
				icons: {
					close_icon_id: 'times',
				},
				notification_classes: {
					notification_cart_container: 'notification-cart-container notification-hidden',
					notification: 'p-3 w-100',
					cart_item_image_container: 'mr-3',
					cart_item_image: 'img-absolute-centered-vertically',
					cart_item_name: 'mb-2 mb-md-1',
					cart_item: 'd-grid grid-auto-1',
					cart_item_price_container: 'mb-2 mb-md-1',
					cart_item_success_message: 'font-weight-bold',
					close_icon: 'icon-inline',
				}
			})
		}}
	{% endif %}

	{# Mobile main categories #}

	{% if settings.head_main_categories or params.preview %}
		<div class="js-main-categories-container main-categories-container d-md-none" {% if not settings.head_main_categories %}style="display: none;"{% endif %}>
			{% include 'snipplets/navigation/navigation-categories-mobile.tpl' %}
		</div>
	{% endif %}

	{# Desktop navigation #}

	<div class="js-nav-desktop-color-container nav-desktop-container {{ nav_desktop_color_class }} d-none d-md-block">
		<div class="js-nav-desktop-container {{ nav_desktop_grid_class }} {{ nav_desktop_grid_secondary_nav_class }} container" data-desktop-nav-secondary-or-language="{{ nav_secondary_col ? 'true' : 'false' }}" data-desktop-nav-secondary="{{ settings.head_secondary_menu_show ? 'true' : 'false' }}" data-desktop-main-categories="{{ settings.category_item ? 'true' : 'false' }}" style="visibility:hidden; height:0;">

			<div class="js-desktop-nav-col nav-desktop-main {{ nav_desktop_text_class }}">
				{% snipplet "navigation/navigation.tpl" %}
			</div>
			{% if nav_secondary_col or params.preview %}
				<div class="js-desktop-secondary-nav-col nav-desktop-secondary" {% if not nav_secondary_col %}style="display: none;"{% endif %}>
					{% if settings.head_secondary_menu_show %}
						{% include "snipplets/navigation/navigation-secondary.tpl" with {desktop: true} %}
					{% endif %}
					{% if utilities_languages_secondary_nav or (params.preview and has_languages) %}
						{% include "snipplets/header/utilities/language.tpl" with {secondary_nav: true, dropdown: true} %}
					{% endif %}
				</div>
			{% endif %}
		</div>
	</div>
</header>

{% if status_page_url %}
	{{ component(
		'notification',{
			type: 'order',
			content_wrapper: true,
			icons: {
				close_icon_id: 'times',
			},
			notification_classes: {
				notification: 'mt-3 text-center text-md-left notification-fixed notification-fixed-md-right transition-soft',
				content_wrapper: 'd-block mr-3 pr-2',
				link: 'btn-link',
				close_icon: 'icon-inline'
			}
		}) 
	}}
{% endif %}

{{ component(
	'notification',{
		type: 'cookies',
		notification_classes: {
			notification: 'notification-fixed notification-fixed-bottom',
			link: 'btn-link ml-1',
		}
	}) 
}}


{% include "snipplets/header/header-modals.tpl" %}
