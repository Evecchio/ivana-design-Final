{% include "snipplets/svg/empty-placeholders.tpl" %}

<section class="category-body" data-store="category-grid">
	<div class="container pt-4 mb-4">
		{% set formatted_category_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: category.name } %}{% endset %}
		<h1 class="h4 mb-4">{{ formatted_category_name | trim }}</h1>
		<div class="grid grid-1 grid-md-5">
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_1': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_2': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_3': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_4': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_5': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_6': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_7': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_8': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_1': true} %}
			{% include 'snipplets/defaults/help_item.tpl' with {'help_item_2': true} %}
		</div>
	</div>
</section>
