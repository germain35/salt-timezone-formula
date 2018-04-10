{%- from "timezone/map.jinja" import timezone with context %}

timezone_packages:
  pkg.installed:
    - pkgs: {{ timezone.pkgs }}

timezone_setting:
  timezone.system:
    - name: {{ timezone.name }}
    - utc: {{ timezone.utc }}
    - require:
      - pkg: timezone_packages

timezone_symlink:
  file.symlink:
    - name: {{ timezone.path_localtime }}
    - target: {{ timezone.path_zoneinfo | path_join(timezone.name)}}
    - force: True
    - require:
      - pkg: timezone_packages
