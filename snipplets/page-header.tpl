{# /*============================================================================
  #Page header
==============================================================================*/

#Properties

#Title

#Breadcrumbs

#}

<section class="page-header my-4 {{ page_header_class }}" data-store="page-title">
	<div class="ivana-page-header-copy">
		{% include 'snipplets/breadcrumbs.tpl' %}
		{% set sanitized_page_header_title_class = page_header_title_class | default('') | replace('text-uppercase', '') %}
		<h1 class="h4 h2-md {{ sanitized_page_header_title_class }}">
			{% block page_header_text %}{% endblock %}
		</h1>
	</div>
</section>
