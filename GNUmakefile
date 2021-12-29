all: to_arch

to_arch: src/*
	@#The at symbol tells gmake to not echo the line being executed

	@if command -v gsed; then \
		gsed -e '/__PRESCRIPT__/{r 'src/prerun.sh'' -e 'd}' 'src/body.sh' > src/premerge; \
	else \
		sed -e '/__PRESCRIPT__/{r 'src/prerun.sh'' -e 'd}' 'src/body.sh' > src/premerge; \
	fi

	@# This line is to escape the single quotes in the convert script that gets inserted in「sudo bash -c」.

	@if command -v gsed; then \
		gsed "s/'/'\"'\"'/g" src/convert.sh > src/convert_.sh; \
	else \
		sed "s/'/'\"'\"'/g" src/convert.sh > src/convert_.sh; \
	fi

	@if command -v gsed; then \
		gsed -e '/__CONVERTSCRIPT__/{r 'src/convert_.sh'' -e 'd}' 'src/premerge' > src/convertmerge; \
	else \
		sed -e '/__CONVERTSCRIPT__/{r 'src/convert_.sh'' -e 'd}' 'src/premerge' > src/convertmerge; \
	fi

	@if command -v gsed; then \
		gsed -e '/__POSTSCRIPT__/{r 'src/postrun.sh'' -e 'd}' 'src/convertmerge' > to_arch.sh; \
	else \
		sed -e '/__POSTSCRIPT__/{r 'src/postrun.sh'' -e 'd}' 'src/convertmerge' > to_arch.sh; \
	fi
	
	@rm -f src/*merge src/convert_.sh

	@chmod 755 to_arch.sh

	@echo Successfully made script
.PHONY: clean
clean:
	@rm -f to_arch.sh

	@echo Successfully cleaned script
