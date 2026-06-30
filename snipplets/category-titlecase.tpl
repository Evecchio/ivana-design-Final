{%- set raw_category_title = category_name | default('') | trim -%}
{%- set lower_category_title = raw_category_title | lower -%}
{%- set minor_words = [
  'a',
  'ante',
  'bajo',
  'con',
  'contra',
  'de',
  'del',
  'desde',
  'durante',
  'en',
  'entre',
  'hacia',
  'hasta',
  'mediante',
  'para',
  'por',
  'según',
  'segun',
  'sin',
  'sobre',
  'tras',
  'el',
  'la',
  'los',
  'las',
  'un',
  'una',
  'unos',
  'unas',
  'y',
  'e',
  'o',
  'u'
] -%}
{%- if lower_category_title == 'productos' -%}
  Colección
{%- else -%}
  {%- for word in lower_category_title | split(' ') -%}
    {%- set clean_word = word | trim -%}
    {%- if clean_word -%}
      {{- not loop.first ? ' ' : '' -}}
      {%- if not loop.first and clean_word in minor_words -%}
        {{- clean_word -}}
      {%- else -%}
        {{- clean_word | capitalize -}}
      {%- endif -%}
    {%- endif -%}
  {%- endfor -%}
{%- endif -%}
