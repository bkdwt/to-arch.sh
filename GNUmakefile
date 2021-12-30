all: to-arch

to-arch: src/*
	@#The at symbol tells gmake to not echo the line being executed

	@# This line is to escape the single quotes in the convert script that gets inserted in "sudo bash -c".

	@if command -v gsed; then \
		gsed "s/'/'\"'\"'/g" src/convert-manjaro.sh > src/convert-manjaro_.sh; \
	else \
		sed "s/'/'\"'\"'/g" src/convert-manjaro.sh > src/convert-manjaro_.sh; \
	fi
	
	@if command -v gsed; then \
		gsed "s/'/'\"'\"'/g" src/convert-endeavour.sh > src/convert-endeavour_.sh; \
	else \
		sed "s/'/'\"'\"'/g" src/convert-endeavour.sh > src/convert-endeavour_.sh; \
	fi

	@if command -v gsed; then \
		gsed -e '/__CONVERTSCRIPT_MANJARNO__/{r 'src/convert-manjaro_.sh'' -e 'd}' 'src/premerge' > src/convertmanjaromerge; \
	else \
		sed -e '/__CONVERTSCRIPT_MANJARNO__/{r 'src/convert-manjaro_.sh'' -e 'd}' 'src/premerge' > src/convertmanjaromerge; \
	fi
	
	@if command -v gsed; then \
		gsed -e '/__CONVERTSCRIPT_ENDEAVOUROS__/{r 'src/convert-endeavour_.sh'' -e 'd}' 'src/premerge' > src/convertendeavourmerge; \
	else \
		sed -e '/__CONVERTSCRIPT_ENDEAVOUROS__/{r 'src/convert-endeavour_.sh'' -e 'd}' 'src/premerge' > src/convertendeavourmerge; \
	fi

	@if command -v gsed; then \
		gsed -e '/__POSTSCRIPT_MANJARNO__/{r 'src/convertendeavourmerge.sh'' -e 'd}' 'src/convertendeavourmerge' > postjaro.sh; \
	else \
		sed -e '/__POSTSCRIPT_MANJARNO__/{r 'src/convertendeavourmerge.sh'' -e 'd}' 'src/convertendeavourmerge' > postjaro.sh; \
	fi
	
	@if command -v gsed; then \
		gsed -e '/__POSTSCRIPT_ENDEAVOUROS__/{r 'src/postjaro.sh'' -e 'd}' 'src/postrun-endeavour.sh' > to-arch.sh; \
	else \
		sed -e '/__POSTSCRIPT_ENDEAVOUROS__/{r 'src/postjaro.sh'' -e 'd}' 'src/postrun-endeavour.sh' > to-arch.sh; \
	fi
	
	@rm -f src/*merge src/convert_.sh

	@chmod 755 to-arch.sh

	@echo Successfully made script
.PHONY: clean
clean:
	@rm -f to-arch.sh

	@echo Successfully cleaned script
