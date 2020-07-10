
"Formats json
com! FormatJSON :%!python3 -c "import json, sys; print(json.dumps(json.load(sys.stdin), ensure_ascii=False, indent=2))"
nnoremap = :FormatJSON<Cr>

