all: to-arch

to-arch: src/*
	@#The at symbol tells gmake to not echo the line being executed

	@# This line is to escape the single quotes in the convert script that gets inserted in "sudo bash -c".

	@sed "s/'/'\"'\"'/g" src/convert-manjaro.sh > src/convert-manjaro_.sh; \
	
	@sed "s/'/'\"'\"'/g" src/convert-endeavour.sh > src/convert-endeavour_.sh; \
	

	@sed -e '/__CONVERTSCRIPT_MANJARNO__/{r 'src/convert-manjaro_.sh'' -e 'd}' 'src/body.sh' > src/convertmanjaromerge; \
	
	
	@sed -e '/__CONVERTSCRIPT_ENDEAVOUROS__/{r 'src/convert-endeavour_.sh'' -e 'd}' 'src/convertmanjaromerge' > src/convertendeavourmerge; \
	

	@sed -e '/__POSTSCRIPT_MANJARNO__/{r 'src/postrun-manjaro.sh'' -e 'd}' 'src/convertendeavourmerge' > src/postjaro.sh; \
	
	
	@sed -e '/__POSTSCRIPT_ENDEAVOUROS__/{r 'src/postrun-endeavour.sh'' -e 'd}' 'src/postjaro.sh' > to-arch.sh; \
	
	
	@rm -f src/*merge src/postjaro.sh src/*_.sh

	@chmod 755 to-arch.sh

	@echo Successfully made script
.PHONY: clean
clean:
	@rm -f to-arch.sh

	@echo Successfully cleaned script
