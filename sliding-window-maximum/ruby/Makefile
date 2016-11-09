test:
	for i in $$(ls ../*.in); do \
	  cat $$i | ./main.rb >/tmp/swm.out; \
          if diff /tmp/swm.out $${i%.in}.out >/dev/null 2>&1; then \
            echo "PASS $$i"; \
	  else \
            echo "FAIL $$i"; \
	    diff -y /tmp/swm.out $${i%.in}.out; \
            break; \
          fi; \
        done