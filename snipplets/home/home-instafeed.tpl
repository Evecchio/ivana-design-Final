<section class="section-instafeed-home" data-store="home-instagram-feed">
	<div class="js-instagram-feed">
		<div class="container text-center py-4">
			{% set instuser = store.instagram|split('/')|last %}
			<a target="_blank" rel="noopener noreferrer" href="{{ store.instagram }}" class="mb-0" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
				<div class="instafeed-title mb-3">
					<svg class="icon-inline icon-2x svg-icon-text mr-md-3 mb-md-0 mb-3" aria-hidden="true" focusable="false"><use xlink:href="#instagram"/></svg>
					<h2 class="h4 instafeed-user mb-0">{{ 'Seguinos en' | translate }} @{{ instuser }}</h2>
				</div>
			</a>
			<p class="mb-0">
				<a target="_blank" rel="noopener noreferrer" href="{{ store.instagram }}" class="btn-link">
					{{ 'Ver publicaciones en Instagram' | translate }}
				</a>
			</p>
		</div>
	</div>
</section>
