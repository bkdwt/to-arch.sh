all: to_arch

to_arch: src/*
	if command -v gsed; then gsed -e '/__PRESCRIPT__/{r 'src/prerun.sh'' -e 'd}' 'src/body.sh' > src/premerge; else sed -e '/__PRESCRIPT__/{r 'src/prerun.sh'' -e 'd}' 'src/body.sh' > src/premerge; fi
	if command -v gsed; then gsed "s/'/'\"'\"'/g" src/convert.sh > convert_.sh; else sed "s/'/'\"'\"'/g" src/convert.sh > convert_.sh; fi
	if command -v gsed; then gsed -e '/__CONVERTSCRIPT__/{r 'src/convert_.sh'' -e 'd}' 'src/premerge' > src/convertmerge; else sed -e '/__CONVERTSCRIPT__/{r 'src/convert_.sh'' -e 'd}' 'src/premerge' > src/convertmerge; fi
	if command -v gsed; then gsed -e '/__POSTSCRIPT__/{r 'src/postrun.sh'' -e 'd}' 'src/convertmerge' > to_arch; else sed -e '/__POSTSCRIPT__/{r 'src/postrun.sh'' -e 'd}' 'src/convertmerge' > to_arch; fi
	rm -f src/*merge src/convert_.sh
	chmod 755 to_arch

.PHONY: clean
clean:
	rm -f to_arch
